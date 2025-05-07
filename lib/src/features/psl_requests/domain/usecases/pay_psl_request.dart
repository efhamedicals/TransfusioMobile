import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/psl_requests/domain/repositories/psl_request_repository.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

class PayPslRequestUseCase implements UseCase<BasicResponse, PayPslParams> {
  final PslRequestRepository pslRequestRepository;
  const PayPslRequestUseCase(this.pslRequestRepository);

  @override
  Future<DataState<BasicResponse>> call(PayPslParams params) async {
    return await pslRequestRepository.payPslRequest(
      phoneNumber: params.phoneNumber,
      network: params.network,
      amount: params.amount,
      pslRequestId: params.pslRequestId,
    );
  }
}

class PayPslParams {
  final int pslRequestId;
  final String phoneNumber;
  final String network;
  final int amount;

  PayPslParams({
    required this.phoneNumber,
    required this.network,
    required this.amount,
    required this.pslRequestId,
  });
}
