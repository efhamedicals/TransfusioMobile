import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/features/auth/data/models/user_model.dart';

abstract interface class UserRepository {
  Future<DataState<UserModel>> getUserInfos();
}
