import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/auth/data/models/login_response.dart';
import 'package:transfusio/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:transfusio/src/features/auth/domain/usecases/login_usecase.dart';

class SendOtpUseCase implements UseCase<LoginResponse, UserLoginParams> {
  final AuthRepository authRepository;
  const SendOtpUseCase(this.authRepository);

  @override
  Future<DataState<LoginResponse>> call(UserLoginParams params) async {
    return await authRepository.sendOtp(
      email: params.email,
      phone: params.phone,
      isNew: params.isNew,
      userId: params.userId,
    );
  }
}
