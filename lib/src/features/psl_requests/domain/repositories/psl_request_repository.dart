import 'package:dio/dio.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/features/psl_requests/data/models/add_psl_request_response.dart';
import 'package:transfusio/src/features/psl_requests/data/models/psl_requests_response.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

abstract interface class PslRequestRepository {
  Future<DataState<PslRequestsResponse>> getPslRequests();

  Future<DataState<AddPslRequestResponse>> addPslRequest({
    required FormData formData,
  });

  Future<DataState<AddPslRequestResponse>> checkPslRequest({
    required int pslRequestId,
  });

  Future<DataState<AddPslRequestResponse>> recheckPslRequest({
    required int pslRequestId,
  });

  Future<DataState<BasicResponse>> deletePslRequest({
    required int pslRequestId,
  });

  Future<DataState<BasicResponse>> getSinglePslRequest(int id);

  Future<DataState<BasicResponse>> payPslRequest({
    required int pslRequestId,
    required String phoneNumber,
    required String network,
    required int amount,
  });
}
