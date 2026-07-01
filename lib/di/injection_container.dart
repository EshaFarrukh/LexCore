import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:lex_core/core/network/api_client.dart';
import 'package:lex_core/core/network/dio_client.dart';
import 'package:lex_core/features/lawyer/data/datasources/lawyer_remote_datasource.dart';
import 'package:lex_core/features/lawyer/data/repositories/lawyer_repository_impl.dart';
import 'package:lex_core/features/lawyer/domain/repositories/lawyer_repository.dart';
import 'package:lex_core/features/lawyer/domain/usecases/get_lawyers_usecase.dart';
import 'package:lex_core/features/lawyer/domain/usecases/get_lawyer_profile_usecase.dart';
import 'package:lex_core/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lex_core/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:lex_core/features/auth/domain/repositories/auth_repository.dart';
import 'package:lex_core/features/auth/domain/usecases/auth_usecases.dart';
import 'package:lex_core/features/client/data/datasources/client_remote_datasource.dart';
import 'package:lex_core/features/client/data/repositories/client_repository_impl.dart';
import 'package:lex_core/features/client/domain/repositories/client_repository.dart';
import 'package:lex_core/features/client/domain/usecases/client_usecases.dart';
import 'package:lex_core/features/student/data/datasources/student_remote_datasource.dart';
import 'package:lex_core/features/student/data/repositories/student_repository_impl.dart';
import 'package:lex_core/features/student/domain/repositories/student_repository.dart';
import 'package:lex_core/features/student/domain/usecases/student_usecases.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton(() => ApiClient(sl()));
  sl.registerLazySingleton<FirebaseFirestore>(() {
    if (Firebase.apps.isNotEmpty) {
      return FirebaseFirestore.instance;
    } else {
      return FakeFirebaseFirestore();
    }
  });

  // Features - Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<SignupUseCase>(() => SignupUseCase(sl()));
  sl.registerLazySingleton<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton<OtpUseCase>(() => OtpUseCase(sl()));
  sl.registerLazySingleton<ResetPasswordUseCase>(() => ResetPasswordUseCase(sl()));

  // Features - Lawyer
  sl.registerLazySingleton<LawyerRemoteDataSource>(
      () => LawyerRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<LawyerRepository>(
      () => LawyerRepositoryImpl(sl()));
  sl.registerLazySingleton<GetLawyersUseCase>(() => GetLawyersUseCase(sl()));
  sl.registerLazySingleton<GetLawyerProfileUseCase>(() => GetLawyerProfileUseCase(sl()));

  // Features - Client (Cases)
  sl.registerLazySingleton<ClientRemoteDataSource>(
      () => ClientRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ClientRepository>(
      () => ClientRepositoryImpl(sl()));
  sl.registerLazySingleton<CreateCaseUseCase>(() => CreateCaseUseCase(sl()));
  sl.registerLazySingleton<GetCasesByUserIdUseCase>(() => GetCasesByUserIdUseCase(sl()));

  // Features - Student
  sl.registerLazySingleton<StudentRemoteDataSource>(
      () => StudentRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<StudentRepository>(
      () => StudentRepositoryImpl(sl()));
  sl.registerLazySingleton<GetCertificationsUseCase>(() => GetCertificationsUseCase(sl()));
  sl.registerLazySingleton<GetTasksUseCase>(() => GetTasksUseCase(sl()));
  sl.registerLazySingleton<GetResearchUseCase>(() => GetResearchUseCase(sl()));
  sl.registerLazySingleton<GetStudentProfileUseCase>(() => GetStudentProfileUseCase(sl()));
}
