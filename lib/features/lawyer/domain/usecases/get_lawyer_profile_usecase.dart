import 'package:lex_core/features/lawyer/data/models/profile_model/lawyer_self_profile_model.dart';
import 'package:lex_core/features/lawyer/domain/repositories/lawyer_repository.dart';

class GetLawyerProfileUseCase {
  final LawyerRepository repository;

  GetLawyerProfileUseCase(this.repository);

  Future<LawyerSelfProfileModel> execute(String userId) async {
    return await repository.getLawyerProfile(userId);
  }
}
