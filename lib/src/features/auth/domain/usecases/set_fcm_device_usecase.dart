import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

class SetFcmDeviceUseCase implements UseCase<BasicResponse, String> {
  final AuthRepository authRepository;
  const SetFcmDeviceUseCase(this.authRepository);

  @override
  Future<DataState<BasicResponse>> call(String deviceToken) async {
    return await authRepository.setFcmDeviceToken(deviceToken: deviceToken);
  }
}
