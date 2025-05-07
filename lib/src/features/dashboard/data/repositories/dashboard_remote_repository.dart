import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/features/dashboard/data/datasources/remote/dashboard_api.dart';
import 'package:transfusio/src/features/dashboard/data/models/data_response.dart';
import 'package:transfusio/src/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRemoteRepository implements DashboardRepository {
  DashboardRemoteRepository({required this.dashboardApi});

  final DashboardApi dashboardApi;

  @override
  Future<DataState<DataResponse>> getStatsInfos() async {
    try {
      final httpResponse = await dashboardApi.getStatsInfos();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<DataResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<DataResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during getStatsInfos : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }
}
