import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/features/psl_requests/presentation/view_models/psl_request_view_model.dart';
import 'package:transfusio/src/shared/data/models/psl_request_model.dart';
import 'package:transfusio/src/shared/presentation/widgets/app_bars/simple_app_bar.dart';

class EditPslRequestScreen extends StatefulWidget {
  final PslRequestModel pslRequestModel;
  const EditPslRequestScreen({super.key, required this.pslRequestModel});

  @override
  State<EditPslRequestScreen> createState() => _EditPslRequestScreenState();
}

class _EditPslRequestScreenState extends State<EditPslRequestScreen> {
  PslRequestViewModel pslRequestViewModel = locator<PslRequestViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /*reviewViewModel.setCurrentIcon(
        EmojiHelper.getEmojiFromEnum(widget.pslRequestModel.rating!),
      );
      reviewViewModel.descriptionController.value.text =
          widget.pslRequestModel.comment ?? "";*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: const SimpleAppBar(title: "Modification"),
        body: Container(
          width: Dimensions.getScreenWidth(context),
          padding: const EdgeInsets.all(10),
          child: const SingleChildScrollView(),
        ),
      ),
    );
  }
}
