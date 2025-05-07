import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/psl_requests/domain/repositories/psl_request_repository.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

class DeletePslRequestUseCase
    implements UseCase<BasicResponse, DeletePslRequestParam> {
  final PslRequestRepository pslRequestRepository;
  const DeletePslRequestUseCase(this.pslRequestRepository);

  @override
  Future<DataState<BasicResponse>> call(DeletePslRequestParam params) async {
    return await pslRequestRepository.deletePslRequest(
      pslRequestId: params.pslRequestId!,
    );
  }
}

class DeletePslRequestParam {
  final int? pslRequestId;

  DeletePslRequestParam({this.pslRequestId});
}
