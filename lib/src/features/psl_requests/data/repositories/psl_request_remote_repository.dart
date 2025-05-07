import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/features/psl_requests/data/datasources/remote/psl_request_api.dart';
import 'package:transfusio/src/features/psl_requests/data/models/add_psl_request_response.dart';
import 'package:transfusio/src/features/psl_requests/data/models/psl_requests_response.dart';
import 'package:transfusio/src/features/psl_requests/domain/repositories/psl_request_repository.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

class PslRequestRemoteRepository implements PslRequestRepository {
  PslRequestRemoteRepository({required this.pslRequestApi});

  final PslRequestApi pslRequestApi;

  @override
  Future<DataState<PslRequestsResponse>> getPslRequests() async {
    try {
      final httpResponse = await pslRequestApi.getPslRequests();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<PslRequestsResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<PslRequestsResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during getPslRequests : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }

  @override
  Future<DataState<AddPslRequestResponse>> addPslRequest({
    required FormData formData,
  }) async {
    try {
      final httpResponse = await pslRequestApi.addPslRequest(formData);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<AddPslRequestResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<AddPslRequestResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during adding review : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }

  @override
  Future<DataState<AddPslRequestResponse>> checkPslRequest({
    required int pslRequestId,
  }) async {
    try {
      final httpResponse = await pslRequestApi.checkPslRequest(pslRequestId);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<AddPslRequestResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<AddPslRequestResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during editing review : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }

  @override
  Future<DataState<BasicResponse>> payPslRequest({
    required int pslRequestId,
    required String phoneNumber,
    required String network,
    required int amount,
  }) async {
    try {
      final httpResponse = await pslRequestApi.payPslRequest({
        "phone_number": phoneNumber,
        "network": network,
        "amount": amount,
      }, pslRequestId);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<BasicResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<BasicResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during editing review : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }

  @override
  Future<DataState<BasicResponse>> getSinglePslRequest(int id) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<AddPslRequestResponse>> recheckPslRequest({
    required int pslRequestId,
  }) async {
    try {
      final httpResponse = await pslRequestApi.recheckPslRequest(pslRequestId);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<AddPslRequestResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<AddPslRequestResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during editing review : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }

  @override
  Future<DataState<BasicResponse>> deletePslRequest({
    required int pslRequestId,
  }) async {
    try {
      final httpResponse = await pslRequestApi.deletePslRequest(pslRequestId);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<BasicResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<BasicResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during editing review : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }
}
