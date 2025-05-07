import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

class UpdatePasswordUseCase
    implements UseCase<BasicResponse, UpdatePasswordParams> {
  final ProfileRepository profileRepository;
  const UpdatePasswordUseCase(this.profileRepository);

  @override
  Future<DataState<BasicResponse>> call(UpdatePasswordParams params) async {
    return await profileRepository.updatePassword(
      oldPassword: params.oldPassword,
      newPassword: params.newPassword,
    );
  }
}

class UpdatePasswordParams {
  final String oldPassword;
  final String newPassword;

  UpdatePasswordParams({required this.oldPassword, required this.newPassword});
}
