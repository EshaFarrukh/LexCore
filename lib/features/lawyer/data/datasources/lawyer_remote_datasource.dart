import 'package:cloud_firestore/cloud_firestore.dart';

abstract class LawyerRemoteDataSource {
  Future<Map<String, dynamic>> getLawyers(int pageNumber, int pageSize);
  Future<Map<String, dynamic>> getLawyerProfile(String userId);
}

class LawyerRemoteDataSourceImpl implements LawyerRemoteDataSource {
  final FirebaseFirestore firestore;

  LawyerRemoteDataSourceImpl(this.firestore);

  @override
  Future<Map<String, dynamic>> getLawyers(int pageNumber, int pageSize) async {
    // Basic pagination (doesn't use cursor for simplicity right now)
    final querySnapshot = await firestore
        .collection('lawyers')
        .limit(pageSize)
        .get();

    final items = <Map<String, dynamic>>[];
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      data['id'] = doc.id;
      
      // Try to get fullName and profileImage from users collection
      try {
        final userDoc = await firestore.collection('users').doc(doc.id).get();
        if (userDoc.exists) {
          final userData = userDoc.data() ?? {};
          final fullName = userData['fullName'] as String? ?? '';
          if (fullName.isNotEmpty) {
            final parts = fullName.split(' ');
            data['firstName'] = parts.first;
            data['lastName'] = parts.length > 1 ? parts.sublist(1).join(' ') : '';
          }
          data['profilePhoto'] = userData['profileImage'];
        }
      } catch (e) {
        // Ignore errors, we'll just have missing names
      }
      
      items.add(data);
    }

    return {
      'data': {
        'items': items,
        'currentPage': pageNumber,
        'totalPages': 1,
        'hasMore': false,
      }
    };
  }

  @override
  Future<Map<String, dynamic>> getLawyerProfile(String userId) async {
    final doc = await firestore.collection('lawyers').doc(userId).get();
    if (!doc.exists) {
      throw Exception('Lawyer profile not found');
    }
    
    // Also fetch basic user details to combine if necessary, but according to our seed data,
    // the lawyer's document in the `lawyers` collection has all needed fields.
    final data = doc.data() ?? {};
    
    // Try to get email and phone from users collection if missing in lawyers collection
    final userDoc = await firestore.collection('users').doc(userId).get();
    if (userDoc.exists) {
      final userData = userDoc.data() ?? {};
      if (!data.containsKey('email')) data['email'] = userData['email'];
      if (!data.containsKey('phone')) data['phone'] = userData['phone'];
      if (!data.containsKey('fullName')) data['fullName'] = userData['name'];
    }

    return data;
  }
}
