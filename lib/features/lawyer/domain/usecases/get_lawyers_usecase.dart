import 'package:lex_core/features/lawyer/domain/entities/lawyer_entity.dart';
import 'package:lex_core/features/lawyer/domain/repositories/lawyer_repository.dart';

class GetLawyersUseCase {
  final LawyerRepository repository;

  GetLawyersUseCase(this.repository);

  Future<PaginatedLawyersEntity> execute(int pageNumber, int pageSize) async {
    return await repository.getLawyers(pageNumber, pageSize);
  }
}
