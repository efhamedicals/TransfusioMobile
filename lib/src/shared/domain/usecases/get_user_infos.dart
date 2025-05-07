import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/auth/data/models/user_model.dart';
import 'package:transfusio/src/shared/domain/repositories/user_repository.dart';

class GetUserInfosUseCase implements UseCase<UserModel, NoParams> {
  final UserRepository userRepository;
  const GetUserInfosUseCase(this.userRepository);

  @override
  Future<DataState<UserModel>> call(NoParams params) async {
    return await userRepository.getUserInfos();
  }
}
