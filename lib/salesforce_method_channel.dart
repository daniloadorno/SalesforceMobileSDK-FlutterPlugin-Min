import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:salesforce/salesforce_platform_interface.dart';

class MethodChannelSalesforcePlugin extends SalesforcePluginPlatform {

  @visibleForTesting
  final methodChannel = const MethodChannel('salesforce');

  /*
   * Send arbitrary force.com request
   * @param endPoint
   * @param path
   * @param method
   * @param payload
   * @param headerParams
   * @param fileParams  Expected to be of the form: {<fileParamNameInPost>: {fileMimeType:<someMimeType>, fileUrl:<fileUrl>, fileName:<fileNameForPost>}}
   * @param returnBinary When true response returned as {encodedBody:"base64-encoded-response", contentType:"content-type"}
  */

  @override
  Future<Map> sendRequest({String endPoint = '/services/data', String path = '', String method = 'GET', Map? payload, Map? headerParams, Map? fileParams, bool returnBinary = false}) async {
    final Object? response = await methodChannel.invokeMethod(
        'network#sendRequest',
        <String, dynamic>{
          'endPoint': endPoint,
          'path': path,
          'method': method,
          'queryParams': payload,
          'headerParams': headerParams,
          'fileParams': fileParams,
          'returnBinary': returnBinary}
    );
    final responseBody = response is Map ? response : json.decode(response.toString());
    return responseBody is List ? Map.fromIterable(responseBody) : responseBody;
  }

  @override
  Future<Map> getAuthCredentials() async {
    final Object? response = await methodChannel.invokeMethod(
        'oauth#getAuthCredentials'
    );
    return response is Map ? response : json.decode(response?.toString() ?? '');
  }

  @override
  Future<Object> getClientInfo() async {
    final Object? response = await methodChannel.invokeMethod(
        'oauth#getClientInfo'
    );
    return response ?? Object();
  }

  @override
  Future<void> authenticate() async {
    await methodChannel.invokeMethod('oauth#authenticate');
  }

  @override
  Future<void> logoutCurrentUser() async {
    await methodChannel.invokeMethod('oauth#logoutCurrentUser');
  }

}