import 'package:lex_core/features/lawyer/data/models/profile_model/lawyer_self_profile_model.dart';
import 'package:lex_core/features/lawyer/domain/entities/lawyer_entity.dart';

abstract class LawyerRepository {
  Future<PaginatedLawyersEntity> getLawyers(int pageNumber, int pageSize);
  Future<LawyerSelfProfileModel> getLawyerProfile(String userId);
}
