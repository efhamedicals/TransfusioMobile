import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/auth/data/models/login_response.dart';
import 'package:transfusio/src/features/auth/domain/repositories/auth_repository.dart';

class VerifyPasswordUseCase
    implements UseCase<LoginResponse, UserVerifyPasswordParams> {
  final AuthRepository authRepository;
  const VerifyPasswordUseCase(this.authRepository);

  @override
  Future<DataState<LoginResponse>> call(UserVerifyPasswordParams params) async {
    return await authRepository.verifyPassword(
      id: params.id,
      password: params.password,
    );
  }
}

class UserVerifyPasswordParams {
  final int? id;
  final String? password;

  UserVerifyPasswordParams({this.id, this.password});
}
