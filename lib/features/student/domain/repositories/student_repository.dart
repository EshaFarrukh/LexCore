import 'package:lex_core/features/student/data/models/certification_model.dart';
import 'package:lex_core/features/student/data/models/research_model.dart';
import 'package:lex_core/features/student/data/models/student_model.dart';
import 'package:lex_core/features/student/data/models/task_model.dart';

abstract class StudentRepository {
  Future<List<CertificationModel>> getCertifications();
  Future<List<TaskModel>> getTasks(String userId);
  Future<List<ResearchModel>> getResearch();
  Future<StudentModel> getStudentProfile(String userId);
}
