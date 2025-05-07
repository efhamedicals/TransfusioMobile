import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/dashboard/data/models/data_response.dart';
import 'package:transfusio/src/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetStatsUseCase implements UseCase<DataResponse, NoParams> {
  final DashboardRepository dashRepository;
  const GetStatsUseCase(this.dashRepository);

  @override
  Future<DataState<DataResponse>> call(NoParams params) async {
    return await dashRepository.getStatsInfos();
  }
}
