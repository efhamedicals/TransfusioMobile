import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/auth/data/models/login_response.dart';
import 'package:transfusio/src/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements UseCase<LoginResponse, UserLoginParams> {
  final AuthRepository authRepository;
  const LoginUseCase(this.authRepository);

  @override
  Future<DataState<LoginResponse>> call(UserLoginParams params) async {
    return await authRepository.login(email: params.email, phone: params.phone);
  }
}

class UserLoginParams {
  final String? email;
  final String? phone;
  final int? userId;
  final bool? isNew;

  UserLoginParams({this.email, this.phone, this.isNew, this.userId});
}
