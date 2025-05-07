import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/features/dashboard/data/models/data_response.dart';

abstract interface class DashboardRepository {
  Future<DataState<DataResponse>> getStatsInfos();
}
