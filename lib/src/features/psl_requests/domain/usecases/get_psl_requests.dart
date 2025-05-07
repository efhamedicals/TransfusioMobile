import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/psl_requests/data/models/psl_requests_response.dart';
import 'package:transfusio/src/features/psl_requests/domain/repositories/psl_request_repository.dart';

class GetPslRequestsUseCase implements UseCase<PslRequestsResponse, NoParams> {
  final PslRequestRepository pslRequestRepository;
  const GetPslRequestsUseCase(this.pslRequestRepository);

  @override
  Future<DataState<PslRequestsResponse>> call(NoParams params) async {
    return await pslRequestRepository.getPslRequests();
  }
}
