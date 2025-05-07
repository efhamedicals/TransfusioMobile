import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/assets/app_assets.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/core/utils/helpers/shimmer_helper.dart';
import 'package:transfusio/src/features/dashboard/presentation/widgets/psl_request_widget.dart';
import 'package:transfusio/src/features/psl_requests/presentation/view_models/psl_request_view_model.dart';
import 'package:transfusio/src/shared/presentation/widgets/app_bars/dashboard_app_bar.dart';

class PslRequestsScreen extends StatefulWidget {
  const PslRequestsScreen({super.key});

  @override
  State<PslRequestsScreen> createState() => _PslRequestsScreenState();
}

class _PslRequestsScreenState extends State<PslRequestsScreen> {
  PslRequestViewModel pslRequestViewModel = locator<PslRequestViewModel>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pslRequestViewModel.getPslRequests();
      pslRequestViewModel.filterFieldController.value.addListener(() {
        pslRequestViewModel.filterPslRequests();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardAppBar(),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () {
            pslRequestViewModel.getPslRequests();
            return Future.value();
          },
          child:
              pslRequestViewModel.isLoading.isTrue
                  ? ShimmerHelper.homePslRequestShimmer(context, count: 10)
                  : ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  color: Colors.transparent,
                                  child: TextFormField(
                                    controller:
                                        pslRequestViewModel
                                            .filterFieldController
                                            .value,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      hintText: "Rechercher une demande",
                                      hintStyle: const TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                      ),
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Icon(
                                          FontAwesomeIcons.magnifyingGlass,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.all(5),
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              AppColors.placeholderBg2,
                                          child: Image(
                                            image: AssetImage(
                                              AppAssets.logoSquare,
                                            ),
                                            width: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      pslRequestViewModel.filteredPslRequests.isNotEmpty
                          ? ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                pslRequestViewModel.filteredPslRequests.length,
                            separatorBuilder:
                                (context, index) =>
                                    Dimensions.verticalSpacer(10),
                            itemBuilder:
                                (context, index) => PslRequestWidget(
                                  pslRequest:
                                      pslRequestViewModel
                                          .filteredPslRequests[index],
                                  onBack: () {
                                    pslRequestViewModel.getPslRequests();
                                  },
                                ),
                          )
                          : const Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Aucune demande"),
                            ),
                          ),
                    ],
                  ),
        ),
      ),
    );
  }
}
