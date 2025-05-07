import 'package:dio/dio.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/psl_requests/data/models/add_psl_request_response.dart';
import 'package:transfusio/src/features/psl_requests/domain/repositories/psl_request_repository.dart';

class AddPslRequestUseCase
    implements UseCase<AddPslRequestResponse, AddPslRequestParam> {
  final PslRequestRepository pslRequestRepository;
  const AddPslRequestUseCase(this.pslRequestRepository);

  @override
  Future<DataState<AddPslRequestResponse>> call(
    AddPslRequestParam params,
  ) async {
    return await pslRequestRepository.addPslRequest(formData: params.formData!);
  }
}

class AddPslRequestParam {
  final FormData? formData;

  AddPslRequestParam({this.formData});
}
