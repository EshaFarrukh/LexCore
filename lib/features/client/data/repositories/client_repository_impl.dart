import 'package:lex_core/features/client/data/datasources/client_remote_datasource.dart';
import 'package:lex_core/features/client/data/models/case_model/case_model.dart';
import 'package:lex_core/features/client/domain/entities/case_entity.dart';
import 'package:lex_core/features/client/domain/repositories/client_repository.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientRemoteDataSource remoteDataSource;

  ClientRepositoryImpl(this.remoteDataSource);

  @override
  Future<CaseEntity> createCase(CreateCaseParams params) async {
    final responseMap = await remoteDataSource.createCase(params);
    return CaseModel.fromJson(responseMap);
  }

  @override
  Future<List<CaseEntity>> getCasesByUserId(String userId) async {
    final responseList = await remoteDataSource.getCasesByUserId(userId);

    return responseList.map((map) {
      final List<dynamic> rawNotes = map['notes'] as List<dynamic>? ?? [];
      final notes = rawNotes
          .map((n) => CaseNoteModel.fromJson(n as Map<String, dynamic>))
          .toList();
      return CaseModel.fromJson(map, notes: notes, documentId: map['documentId'] as String?);
    }).toList();
  }
}
