import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/core/utils/helpers/bottom_sheet_helper.dart';
import 'package:transfusio/src/core/utils/helpers/snack_bar_helper.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/psl_requests/data/models/add_psl_request_response.dart';
import 'package:transfusio/src/features/psl_requests/data/models/psl_requests_response.dart';
import 'package:transfusio/src/features/psl_requests/data/models/verification_response.dart';
import 'package:transfusio/src/features/psl_requests/domain/usecases/add_psl_request.dart';
import 'package:transfusio/src/features/psl_requests/domain/usecases/check_psl_request.dart';
import 'package:transfusio/src/features/psl_requests/domain/usecases/delete_psl_request.dart';
import 'package:transfusio/src/features/psl_requests/domain/usecases/get_psl_requests.dart';
import 'package:transfusio/src/features/psl_requests/domain/usecases/pay_psl_request.dart';
import 'package:transfusio/src/features/psl_requests/domain/usecases/recheck_psl_request.dart';
import 'package:transfusio/src/features/psl_requests/presentation/widgets/products_full_available.dart';
import 'package:transfusio/src/features/psl_requests/presentation/widgets/products_partial_available.dart';
import 'package:transfusio/src/features/psl_requests/presentation/widgets/products_unavailable.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';
import 'package:transfusio/src/shared/data/models/psl_request_model.dart';

class PslRequestViewModel extends GetxController {
  // UseCases
  final GetPslRequestsUseCase getPslRequestsUseCase;
  final AddPslRequestUseCase addPslRequestUseCase;
  final CheckPslRequestUseCase checkPslRequestUseCase;
  final ReCheckPslRequestUseCase recheckPslRequestUseCase;
  final DeletePslRequestUseCase deletePslRequestUseCase;
  final PayPslRequestUseCase payPslRequestUseCase;

  RxBool isLoading = false.obs;
  RxBool isSubmitted = false.obs;
  var pslRequests = <PslRequestModel>[].obs;
  var filteredPslRequests = <PslRequestModel>[].obs;

  static Rx<BuildContext?> context = Rx<BuildContext?>(null);

  Rx<TextEditingController> lastNameController = Rx<TextEditingController>(
    TextEditingController(),
  );

  Rx<TextEditingController> firstNameController = Rx<TextEditingController>(
    TextEditingController(),
  );

  Rx<TextEditingController> hospitalNameController = Rx<TextEditingController>(
    TextEditingController(),
  );

  Rx<TextEditingController> filterFieldController = Rx<TextEditingController>(
    TextEditingController(),
  );

  Rx<TextEditingController> phoneNumberController = Rx<TextEditingController>(
    TextEditingController(),
  );
  RxBool isYas = true.obs;
  Rx<GlobalKey<FormState>> paymentKeyForm = GlobalKey<FormState>().obs;

  Rx<GlobalKey<FormState>> step1KeyForm = GlobalKey<FormState>().obs;
  Rx<GlobalKey<FormState>> step2KeyForm = GlobalKey<FormState>().obs;
  Rx<GlobalKey<FormState>> step3KeyForm = GlobalKey<FormState>().obs;
  Rx<GlobalKey<FormState>> step4KeyForm = GlobalKey<FormState>().obs;

  Rx<File?> prescriptionFile = Rx<File?>(null);
  Rx<File?> bloodReportFile = Rx<File?>(null);

  Rx<PslRequestModel?> pslRequestModel = Rx<PslRequestModel?>(null);
  Rx<VerificationResponse?> verificationResponse = Rx<VerificationResponse?>(
    null,
  );

  PslRequestViewModel({
    required this.getPslRequestsUseCase,
    required this.addPslRequestUseCase,
    required this.checkPslRequestUseCase,
    required this.payPslRequestUseCase,
    required this.recheckPslRequestUseCase,
    required this.deletePslRequestUseCase,
  });

  void setIsLoading(bool value) => isLoading.value = value;

  void setIsSubmitted(bool value) => isSubmitted.value = value;

  void setIsYas(bool value) => isYas.value = value;

  void changeContext(BuildContext context) => context = context;

  Future<void> getPslRequests() async {
    try {
      setIsLoading(true);
      final response = await getPslRequestsUseCase.call(NoParams());

      if (response is DataSuccess<PslRequestsResponse>) {
        debugPrint("Good response => ${response.data!.toJson()}");
        pslRequests.assignAll(response.data!.pslRequests ?? []);
        pslRequests.sort((a, b) => b.id!.compareTo(a.id!));
        filteredPslRequests.assignAll(pslRequests);
        setIsLoading(false);
      } else if (response is DataFailed) {}
    } catch (error, stackTrace) {
      debugPrint("Error loading info: $error\nStack Trace: $stackTrace");
    }
  }

  Future<void> addPslRequest(context) async {
    setIsLoading(true);

    Map<String, dynamic> data = {
      "last_name": lastNameController.value.text,
      "first_name": firstNameController.value.text,
      "hospital_name": hospitalNameController.value.text,
      "prescription": await dio.MultipartFile.fromFile(
        prescriptionFile.value!.path,
        filename: prescriptionFile.value!.path.split('/').last,
      ),
      "blood_report": await dio.MultipartFile.fromFile(
        bloodReportFile.value!.path,
        filename: bloodReportFile.value!.path.split('/').last,
      ),
    };

    dio.FormData formData = dio.FormData.fromMap(data);

    final DataState<AddPslRequestResponse> result = await addPslRequestUseCase
        .call(AddPslRequestParam(formData: formData));

    if (result is DataSuccess<AddPslRequestResponse>) {
      debugPrint("Good response => ${result.data!.toJson()}");
      if (result.data!.status!) {
        setIsLoading(false);
        setIsSubmitted(true);
        pslRequestModel.value = result.data!.pslRequest!;
      } else {
        SnackBarHelper.showCustomSnackBar(context, result.data!.message!);
        setIsLoading(false);
      }
    } else if (result is DataFailed<AddPslRequestResponse>) {
      setIsLoading(false);
      SnackBarHelper.showCustomSnackBar(context, result.error!.message);
    }
  }

  Future<void> checkPslRequest(context, int idPslRequest) async {
    setIsLoading(true);

    final DataState<AddPslRequestResponse> result = await checkPslRequestUseCase
        .call(CheckPslRequestParam(pslRequestId: idPslRequest));

    if (result is DataSuccess<AddPslRequestResponse>) {
      debugPrint("Good response => ${result.data!.toJson()}");
      if (result.data!.status!) {
        pslRequestModel.value = result.data!.pslRequest!;
        verificationResponse.value = result.data!.verification!;

        changeContext(context);
        setIsLoading(false);
        BottomSheetHelper.showWidgetBottomSheet(
          context,
          child:
              verificationResponse.value!.found!
                  ? verificationResponse.value!.isAll!
                      ? ProductsFullAvailable(
                        pslRequestModel: pslRequestModel.value!,
                        verificationResponse: verificationResponse.value!,
                        parentContext: context,
                      )
                      : ProductsPartialAvailable(
                        pslRequestModel: pslRequestModel.value!,
                        verificationResponse: verificationResponse.value!,
                        parentContext: context,
                      )
                  : ProductsUnavailable(
                    pslRequestModel: pslRequestModel.value!,
                  ),
          height: Dimensions.getScreenHeight(context) * 0.7,
        );
      } else {
        SnackBarHelper.showCustomSnackBar(context, result.data!.message!);
        setIsLoading(false);
      }
    } else if (result is DataFailed<AddPslRequestResponse>) {
      setIsLoading(false);
      SnackBarHelper.showCustomSnackBar(context, result.error!.message);
    }
  }

  Future<void> recheckPslRequest(context, int idPslRequest) async {
    setIsLoading(true);

    final DataState<AddPslRequestResponse> result =
        await recheckPslRequestUseCase.call(
          ReCheckPslRequestParam(pslRequestId: idPslRequest),
        );

    if (result is DataSuccess<AddPslRequestResponse>) {
      debugPrint("Good response => ${result.data!.toJson()}");
      if (result.data!.status!) {
        pslRequestModel.value = result.data!.pslRequest!;
        verificationResponse.value = result.data!.verification!;

        changeContext(context);
        setIsLoading(false);
        BottomSheetHelper.showWidgetBottomSheet(
          context,
          child:
              verificationResponse.value!.found!
                  ? verificationResponse.value!.isAll!
                      ? ProductsFullAvailable(
                        pslRequestModel: pslRequestModel.value!,
                        verificationResponse: verificationResponse.value!,
                        parentContext: context,
                      )
                      : ProductsPartialAvailable(
                        pslRequestModel: pslRequestModel.value!,
                        verificationResponse: verificationResponse.value!,
                        parentContext: context,
                      )
                  : ProductsUnavailable(
                    pslRequestModel: pslRequestModel.value!,
                  ),
          height: Dimensions.getScreenHeight(context) * 0.7,
        );
      } else {
        SnackBarHelper.showCustomSnackBar(context, result.data!.message!);
        setIsLoading(false);
      }
    } else if (result is DataFailed<AddPslRequestResponse>) {
      setIsLoading(false);
      SnackBarHelper.showCustomSnackBar(context, result.error!.message);
    }
  }

  Future<void> payPslRequest(context, int idPslRequest, int amount) async {
    BottomSheetHelper.showPersistentLoadingBottomSheet(
      context,
      title: "Paiement",
      message: "Traitement en cours...",
    );

    final DataState<BasicResponse> result = await payPslRequestUseCase.call(
      PayPslParams(
        phoneNumber: phoneNumberController.value.text,
        network: isYas.value ? "TMONEY" : "FLOOZ",
        amount: amount,
        pslRequestId: idPslRequest,
      ),
    );

    Navigator.pop(context);
    if (result is DataSuccess<BasicResponse>) {
      debugPrint("Good response => ${result.data!.toJson()}");
      if (result.data!.status!) {
        Navigator.pop(context);
        SnackBarHelper.showCustomSnackBar(
          context,
          "Paiement initié avec succès! Veuillez attendre la confirmation.",
          backgroundColor: Colors.green,
        );
      } else {
        SnackBarHelper.showCustomSnackBar(context, result.data!.message!);
      }
    } else if (result is DataFailed<BasicResponse>) {
      SnackBarHelper.showCustomSnackBar(context, result.error!.message);
    }
  }

  void filterPslRequests() {
    if (filterFieldController.value.text.isNotEmpty) {
      filteredPslRequests.value =
          pslRequests
              .where(
                (element) =>
                    element.prescriptionFullname!.toString().contains(
                      filterFieldController.value.text,
                    ) ||
                    element.reference!.toString().contains(
                      filterFieldController.value.text,
                    ) ||
                    element.prescriptionBloodType!.toString().contains(
                      filterFieldController.value.text,
                    ) ||
                    element.prescriptionDiagnostic!.toString().contains(
                      filterFieldController.value.text,
                    ),
              )
              .toList();
    } else {
      filteredPslRequests.value = pslRequests;
    }
  }
}
