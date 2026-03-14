import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/psl_requests/presentation/pages/psl_requests_screen.dart';
import 'package:transfusio/src/features/dashboard/data/models/data_response.dart';
import 'package:transfusio/src/features/dashboard/domain/usecases/get_stats_use_case.dart';
import 'package:transfusio/src/features/dashboard/presentation/pages/home_screen.dart';
import 'package:transfusio/src/features/profile/presentation/pages/profile_screen.dart';
import 'package:transfusio/src/shared/data/models/psl_request_model.dart';

class DashboardViewModel extends GetxController {
  // UseCases
  final GetStatsUseCase getStatsUseCase;

  static RxInt currentIndex = 0.obs;
  RxBool isLoading = false.obs;

  Rx<List<PslRequestModel>> pslRequests = Rx<List<PslRequestModel>>([]);
  //  Home Stats
  RxInt totalRequests = 0.obs;
  RxInt paymentsCount = 0.obs;
  RxInt paymentsAmount = 0.obs;
  RxInt averageHours = 0.obs;

  static RxInt totalNotifications = 0.obs;

  DashboardViewModel({required this.getStatsUseCase});

  void setCurrentIndex(int value) => currentIndex.value = value;

  int getCurrentIndex() => currentIndex.value;

  int getTotalNotifications() => totalNotifications.value;

  void setIsLoading(bool value) => isLoading.value = value;

  Widget getCurrentWidget() {
    const List<Widget> widgetOptions = <Widget>[
      HomeScreen(),
      PslRequestsScreen(),
      ProfileScreen(),
    ];
    return widgetOptions[currentIndex.value];
  }

  Future<void> getHomeInfos() async {
    try {
      setIsLoading(true);
      final response = await getStatsUseCase.call(NoParams());

      if (response is DataSuccess<DataResponse>) {
        debugPrint("Good response => ${response.data!.toJson()}");
        pslRequests.value = response.data!.pslRequests!;
        totalRequests.value = response.data!.pslRequestsCount!;
        paymentsCount.value = response.data!.paymentsCount!;
        paymentsAmount.value = response.data!.paymentsAmount!;
        averageHours.value = response.data!.averageHours!;

        setIsLoading(false);
      } else if (response is DataFailed) {}
    } catch (error, stackTrace) {
      debugPrint("Error loading info: $error\nStack Trace: $stackTrace");
    }
  }
}
