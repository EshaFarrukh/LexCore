import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lex_core/core/mock_data/student_certifications_data.dart';

abstract class StudentRemoteDataSource {
  Future<List<Map<String, dynamic>>> getCertifications();
  Future<List<Map<String, dynamic>>> getTasks(String userId);
  Future<List<Map<String, dynamic>>> getResearch();
  Future<Map<String, dynamic>> getStudentProfile(String userId);
}

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final FirebaseFirestore firestore;

  StudentRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<Map<String, dynamic>>> getCertifications() async {
    // Return law-related mock data instead of Firestore (which has IT courses)
    final data = mockStudentCertificationsData['data'] as Map<String, dynamic>;
    final completed = List<Map<String, dynamic>>.from(data['completed_certifications']);
    final available = List<Map<String, dynamic>>.from(data['available_certifications']);
    return [...completed, ...available];
  }

  @override
  Future<List<Map<String, dynamic>>> getTasks(String userId) async {
    final snapshot = await firestore
        .collection('tasks')
        .where('assignedTo', isEqualTo: userId)
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getResearch() async {
    final snapshot = await firestore.collection('research').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  @override
  Future<Map<String, dynamic>> getStudentProfile(String userId) async {
    final doc = await firestore.collection('students').doc(userId).get();
    if (!doc.exists) {
      throw Exception('Student profile not found');
    }
    
    final data = doc.data() ?? {};
    
    // Check users collection for fallback data
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
