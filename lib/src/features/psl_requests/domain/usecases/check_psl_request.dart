import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/psl_requests/data/models/add_psl_request_response.dart';
import 'package:transfusio/src/features/psl_requests/domain/repositories/psl_request_repository.dart';

class CheckPslRequestUseCase
    implements UseCase<AddPslRequestResponse, CheckPslRequestParam> {
  final PslRequestRepository pslRequestRepository;
  const CheckPslRequestUseCase(this.pslRequestRepository);

  @override
  Future<DataState<AddPslRequestResponse>> call(
    CheckPslRequestParam params,
  ) async {
    return await pslRequestRepository.checkPslRequest(
      pslRequestId: params.pslRequestId!,
    );
  }
}

class CheckPslRequestParam {
  final int? pslRequestId;

  CheckPslRequestParam({this.pslRequestId});
}
