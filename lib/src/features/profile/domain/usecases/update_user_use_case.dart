import 'package:dio/dio.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/auth/data/models/login_response.dart';
import 'package:transfusio/src/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserUseCase implements UseCase<LoginResponse, UpdateParams> {
  final ProfileRepository profileRepository;
  const UpdateUserUseCase(this.profileRepository);

  @override
  Future<DataState<LoginResponse>> call(UpdateParams params) async {
    return await profileRepository.updateUser(formData: params.formData);
  }
}

class UpdateParams {
  final FormData formData;

  UpdateParams({required this.formData});
}
