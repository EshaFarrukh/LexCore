import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lex_core/features/client/domain/repositories/client_repository.dart';

abstract class ClientRemoteDataSource {
  Future<Map<String, dynamic>> createCase(CreateCaseParams params);
  Future<List<Map<String, dynamic>>> getCasesByUserId(String userId);
}

class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  final FirebaseFirestore firestore;

  ClientRemoteDataSourceImpl(this.firestore);

  @override
  Future<Map<String, dynamic>> createCase(CreateCaseParams params) async {
    final docRef = firestore.collection('cases').doc();
    
    final data = {
      'caseId': docRef.id,
      'category': params.caseType,
      'appointmentType': params.appointmentType,
      'hearingDate': params.appointmentDate,
      'submissionMethod': params.submissionMethod,
      'clientId': params.userId ?? params.createdBy ?? '',
      'status': 'Pending',
      'createdAt': FieldValue.serverTimestamp(),
    };

    if (params.filePath != null && params.filePath!.isNotEmpty) {
      // In a real app, upload to Firebase Storage and get URL
      data['documents'] = [params.filePath!];
    }

    await docRef.set(data);
    
    return data;
  }

  @override
  Future<List<Map<String, dynamic>>> getCasesByUserId(String userId) async {
    final querySnapshot = await firestore
        .collection('cases')
        .where('clientId', isEqualTo: userId)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['documentId'] = doc.id;
      return data;
    }).toList();
  }
}