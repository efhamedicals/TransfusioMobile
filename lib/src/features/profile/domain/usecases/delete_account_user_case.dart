import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

class DeleteAccountUserCase implements UseCase<BasicResponse, NoParams> {
  final ProfileRepository profileRepository;
  const DeleteAccountUserCase(this.profileRepository);

  @override
  Future<DataState<BasicResponse>> call(NoParams params) async {
    return await profileRepository.deleteAccount();
  }
}
