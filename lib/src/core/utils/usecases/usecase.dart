import 'package:transfusio/src/core/ressources/data_state.dart';

abstract interface class UseCase<ResponseType, Params> {
  Future<DataState<ResponseType>> call(Params params);
}

class NoParams {}
