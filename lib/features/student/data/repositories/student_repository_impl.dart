import 'package:lex_core/features/student/data/datasources/student_remote_datasource.dart';
import 'package:lex_core/features/student/data/models/certification_model.dart';
import 'package:lex_core/features/student/data/models/research_model.dart';
import 'package:lex_core/features/student/data/models/student_model.dart';
import 'package:lex_core/features/student/data/models/task_model.dart';
import 'package:lex_core/features/student/domain/repositories/student_repository.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentRemoteDataSource remoteDataSource;

  StudentRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CertificationModel>> getCertifications() async {
    final data = await remoteDataSource.getCertifications();
    return data.map((json) => CertificationModel.fromJson(json)).toList();
  }

  @override
  Future<List<TaskModel>> getTasks(String userId) async {
    final data = await remoteDataSource.getTasks(userId);
    return data.map((json) => TaskModel.fromJson(json)).toList();
  }

  @override
  Future<List<ResearchModel>> getResearch() async {
    final data = await remoteDataSource.getResearch();
    return data.map((json) => ResearchModel.fromJson(json)).toList();
  }

  @override
  Future<StudentModel> getStudentProfile(String userId) async {
    final data = await remoteDataSource.getStudentProfile(userId);
    return StudentModel.fromJson(data);
  }
}
