import 'dart:convert';
import 'dart:io';
import 'package:dio/io.dart';
import 'package:dms_dealers/http/httpurls.dart';
import 'package:dms_dealers/http/logging.dart';
import 'package:dms_dealers/utils/widgets_utlis.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import '../utils/perference_helper.dart';

class DioClient {
  static dynamic dioConfig({String? token}) async {
    var dynHeader = {'contentType': 'application/json'};

    print("token$token");
    if (token != null && token.isNotEmpty) {
      dynHeader['Authorization'] = 'Bearer $token';
    }

    String BaseUrl = await PreferenceHelper.getUrl();

    print(BaseUrl);

    Dio dio = Dio(
      BaseOptions(
          baseUrl: BaseUrl,
          connectTimeout: const Duration(milliseconds: 70000),
          receiveTimeout: const Duration(milliseconds: 70000),
          followRedirects: true,
          headers: dynHeader),
    )..interceptors.add(Logging());
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }

  static dynamic errorHandling(DioException e) {
    debugPrint('dio exception ${e.message}');

    if (e.type == DioExceptionType.unknown) {
      debugPrint('responseData${DioExceptionType.values}');
      return e.response;
    }
    if (e.type == DioExceptionType.connectionTimeout) {
      return showToast('Please check your internet connection');
    }
    if (e.type == DioExceptionType.receiveTimeout) {
      return showToast('Unable to connect to the server');
    }
    if (e.type == DioExceptionType.badResponse) {
      return 'Something went wrong';
    }

    if (e.type == DioExceptionType.cancel) {
      return 'Something went wrong';
    }
  }

  static List<dynamic>? listOfMultiPart(List<File>? file) {
    final List<dynamic> multiPartValues = [];
    for (File element in file!) {
      multiPartValues.add(MultipartFile.fromFile(
        element.path,
        filename: element.path.split('/').last,
      ));
    }
    return multiPartValues;
  }
}

class JsonTransformer extends BackgroundTransformer {
}

Map<String, dynamic> _parseAndDecode(String response) {
  return jsonDecode(response) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> _parseJson(String text) {
  return compute(_parseAndDecode, text);
}
