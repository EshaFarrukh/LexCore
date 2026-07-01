import 'package:lex_core/features/student/data/models/certification_model.dart';
import 'package:lex_core/features/student/data/models/research_model.dart';
import 'package:lex_core/features/student/data/models/student_model.dart';
import 'package:lex_core/features/student/data/models/task_model.dart';
import 'package:lex_core/features/student/domain/repositories/student_repository.dart';

class GetCertificationsUseCase {
  final StudentRepository repository;

  GetCertificationsUseCase(this.repository);

  Future<List<CertificationModel>> execute() async {
    return await repository.getCertifications();
  }
}

class GetTasksUseCase {
  final StudentRepository repository;

  GetTasksUseCase(this.repository);

  Future<List<TaskModel>> execute(String userId) async {
    return await repository.getTasks(userId);
  }
}

class GetResearchUseCase {
  final StudentRepository repository;

  GetResearchUseCase(this.repository);

  Future<List<ResearchModel>> execute() async {
    return await repository.getResearch();
  }
}

class GetStudentProfileUseCase {
  final StudentRepository repository;

  GetStudentProfileUseCase(this.repository);

  Future<StudentModel> execute(String userId) async {
    return await repository.getStudentProfile(userId);
  }
}
