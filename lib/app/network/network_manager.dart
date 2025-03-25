import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import '../services/cache_service.dart';
import '../utils/consts.dart';
import '../utils/get_it_injection.dart';
import '../utils/navigation_helper.dart';

class NetworkManager {
  NetworkManager._();

  factory NetworkManager() => NetworkManager._();

  final https = InterceptedHttp.build(interceptors: [LoggingInterceptor()]);

  Uri? _uri;
  final Map<String, String> requestHeaders = Map.from(apiHeaders);

  Future<http.Response> request<T>({
    RequestMethod method = RequestMethod.post,
    String baseUrl = kBaseUrl,
    String baseVersion = kBaseVersion,
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    _uri = Uri.https(baseUrl, '$baseVersion$endPoint', queryParameters);
    log(_uri.toString(), name: "url");

    final requestHeaders = Map<String, String>.from(apiHeaders);
    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    switch (method) {
      case RequestMethod.get:
        return await https.get(_uri!, headers: requestHeaders);
      case RequestMethod.post:
        return await https.post(_uri!,
            headers: requestHeaders, body: jsonEncode(body));
      case RequestMethod.patch:
        return await https.patch(_uri!,
            headers: requestHeaders, body: jsonEncode(body));
      case RequestMethod.put:
        return await https.put(_uri!,
            headers: requestHeaders, body: jsonEncode(body));
      case RequestMethod.delete:
        return await https.delete(_uri!,
            headers: requestHeaders, body: jsonEncode(body));
      default:
        return await https.post(_uri!,
            headers: requestHeaders, body: jsonEncode(body));
    }
  }

  Future<http.StreamedResponse> requestWithFormData<T>({
    RequestMethod method = RequestMethod.post,
    String baseUrl = kBaseUrl,
    String baseVersion = kBaseVersion,
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    _uri = Uri.https(baseUrl, '$baseVersion$endPoint', queryParameters);

    var request = http.Request(method.name.toUpperCase(), _uri!);
    request.body = jsonEncode(body);

    final requestHeaders = Map<String, String>.from(apiHeaders);
    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    request.headers.addAll(requestHeaders);

    log(_uri.toString(), name: "url");
    log(request.body, name: "body");
    log(request.headers.toString(), name: "headers");

    return await request.send();
  }

  Future<http.StreamedResponse> requestWithFile({
    String baseUrl = kBaseUrl,
    String baseVersion = kBaseVersion,
    required String endPoint,
    Map<String, File>? files,
    Map<String, String>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    _uri = Uri.https(baseUrl, '$baseVersion$endPoint', queryParameters);
    log(_uri.toString(), name: "url");

    var request = http.MultipartRequest('POST', _uri!);

    if (body != null) {
      request.fields.addAll(body);
    }

    final requestHeaders = Map<String, String>.from(apiHeaders);
    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    request.headers.addAll(requestHeaders);

    if (files != null) {
      for (var entry in files.entries) {
        request.files.add(
            await http.MultipartFile.fromPath(entry.key, entry.value.path));
      }
    }

    return await request.send();
  }
}

enum RequestMethod {
  get,
  post,
  put,
  delete,
  patch,
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    request.headers.addAll({
      "Authorization": getIt<CacheService>().getUserToken() ?? "",
      "lang": getIt<NavHelper>()
              .navigatorKey
              .currentState
              ?.context
              .locale
              .languageCode ??
          "en",
    });

    debugPrint("Request URL: ${request.url}");
    debugPrint("Headers: ${request.headers}");
    if (request is http.Request) {
      debugPrint("Body: ${request.body}");
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    debugPrint("Response: ${response.statusCode}");
    debugPrint("Headers: ${response.headers}");
    if (response is http.StreamedResponse) {
      debugPrint("Body: ${await response.stream.bytesToString()}");
    }
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async => true;

  @override
  Future<bool> shouldInterceptResponse() async => true;
}
