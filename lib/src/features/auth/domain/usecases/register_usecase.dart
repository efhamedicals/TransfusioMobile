import 'package:dio/dio.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/auth/data/models/login_response.dart';
import 'package:transfusio/src/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<LoginResponse, UserRegisterParams> {
  final AuthRepository authRepository;
  const RegisterUseCase(this.authRepository);

  @override
  Future<DataState<LoginResponse>> call(UserRegisterParams params) async {
    return await authRepository.register(formData: params.formData);
  }
}

class UserRegisterParams {
  final FormData formData;

  UserRegisterParams({required this.formData});
}
