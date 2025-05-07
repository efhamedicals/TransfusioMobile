import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:transfusio/src/core/routers/app_routers.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/core/utils/helpers/shimmer_helper.dart';
import 'package:transfusio/src/features/dashboard/presentation/view_models/dashboard_view_model.dart';
import 'package:transfusio/src/features/dashboard/presentation/widgets/psl_request_widget.dart';
import 'package:transfusio/src/features/dashboard/presentation/widgets/small_stat_widget.dart';
import 'package:transfusio/src/shared/presentation/widgets/app_bars/dashboard_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DashboardViewModel dashboardViewModel = locator<DashboardViewModel>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dashboardViewModel.getHomeInfos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardAppBar(),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () {
            dashboardViewModel.getHomeInfos();
            return Future.value();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child:
                          dashboardViewModel.isLoading.isTrue
                              ? ShimmerHelper.homeSmallStatShimmer(context)
                              : SmallStatWidget(
                                title: 'Demandes',
                                value:
                                    dashboardViewModel.totalRequests.value
                                        .toString(),
                                icon: FontAwesomeIcons.hand,
                                bgColor: AppColors.primaryColor,
                              ),
                    ),
                    Dimensions.horizontalSpacer(10),
                    Expanded(
                      child:
                          dashboardViewModel.isLoading.isTrue
                              ? ShimmerHelper.homeSmallStatShimmer(context)
                              : SmallStatWidget(
                                title: 'Paiements',
                                value:
                                    dashboardViewModel.paymentsCount.value
                                        .toString(),
                                icon: FontAwesomeIcons.dollarSign,
                                bgColor: AppColors.secondaryColor,
                              ),
                    ),
                  ],
                ),
                Dimensions.verticalSpacer(10),
                Row(
                  children: [
                    Expanded(
                      child:
                          dashboardViewModel.isLoading.isTrue
                              ? ShimmerHelper.homeSmallStatShimmer(context)
                              : SmallStatWidget(
                                title: 'Montants payés',
                                value:
                                    dashboardViewModel.paymentsAmount.value
                                        .toString(),
                                icon: FontAwesomeIcons.dollarSign,
                                bgColor: AppColors.cofeeColor,
                              ),
                    ),
                    Dimensions.horizontalSpacer(10),
                    Expanded(
                      child:
                          dashboardViewModel.isLoading.isTrue
                              ? ShimmerHelper.homeSmallStatShimmer(context)
                              : SmallStatWidget(
                                title: 'Temps moyen Acqui',
                                value: dashboardViewModel.averageHours.value,
                                icon: FontAwesomeIcons.clock,
                                bgColor: AppColors.colorOrange,
                              ),
                    ),
                  ],
                ),
                Dimensions.verticalSpacer(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dernières demandes",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        dashboardViewModel.setCurrentIndex(1);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Voir tout",
                            style:
                                Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.copyWith(),
                          ),
                          const SizedBox(width: 5),
                          const FaIcon(FontAwesomeIcons.arrowRight, size: 15),
                        ],
                      ),
                    ),
                  ],
                ),
                Dimensions.verticalSpacer(10),
                dashboardViewModel.isLoading.isTrue
                    ? ShimmerHelper.homePslRequestShimmer(context, count: 4)
                    : dashboardViewModel.pslRequests.value.isEmpty
                    ? const Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            "Aucune demande. Cliquez sur le bouton noir sur le côté pour en ajouter.",
                          ),
                        ),
                      ),
                    )
                    : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dashboardViewModel.pslRequests.value.length,
                      separatorBuilder:
                          (context, index) => Dimensions.verticalSpacer(10),
                      itemBuilder:
                          (context, index) => PslRequestWidget(
                            isShowAction: false,
                            pslRequest:
                                dashboardViewModel.pslRequests.value[index],
                            onBack: () {
                              dashboardViewModel.getHomeInfos();
                            },
                          ),
                    ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRouter.addPSLRequest)
          /*.then((value) => dashboardViewModel.getParticularHomeInfos())*/;
        },
        backgroundColor: Colors.black,
        child: const FaIcon(Icons.add),
      ),
    );
  }
}
