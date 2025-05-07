import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/psl_requests/data/models/add_psl_request_response.dart';
import 'package:transfusio/src/features/psl_requests/domain/repositories/psl_request_repository.dart';

class ReCheckPslRequestUseCase
    implements UseCase<AddPslRequestResponse, ReCheckPslRequestParam> {
  final PslRequestRepository pslRequestRepository;
  const ReCheckPslRequestUseCase(this.pslRequestRepository);

  @override
  Future<DataState<AddPslRequestResponse>> call(
    ReCheckPslRequestParam params,
  ) async {
    return await pslRequestRepository.recheckPslRequest(
      pslRequestId: params.pslRequestId!,
    );
  }
}

class ReCheckPslRequestParam {
  final int? pslRequestId;

  ReCheckPslRequestParam({this.pslRequestId});
}
