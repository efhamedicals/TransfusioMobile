import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

class SetNewPasswordUseCase
    implements UseCase<BasicResponse, SetNewPasswordParams> {
  final AuthRepository authRepository;
  const SetNewPasswordUseCase(this.authRepository);

  @override
  Future<DataState<BasicResponse>> call(SetNewPasswordParams params) async {
    return await authRepository.setNewPassword(
      email: params.email,
      phone: params.phone,
      password: params.password,
    );
  }
}

class SetNewPasswordParams {
  final String? email;
  final String? phone;
  final String? password;

  SetNewPasswordParams({this.email, this.phone, this.password});
}
