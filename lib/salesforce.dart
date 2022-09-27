import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

class SalesforcePlugin {

  factory SalesforcePlugin() {
    _singleton ??= SalesforcePlugin._(const MethodChannel('com.salesforce.flutter.SalesforcePlugin'));
    return _singleton!;
  }

  SalesforcePlugin._(MethodChannel channel) : _channel = channel;

  static SalesforcePlugin? _singleton;

  static SalesforcePlugin get _platform => SalesforcePlugin.instance;

  static SalesforcePlugin _instance = SalesforcePlugin();
  static SalesforcePlugin get instance => _instance;

  final MethodChannel _channel;
  static String _apiVersion = 'v52.0';

  /*
   * Set apiVersion to be used
  */
  void setApiVersion(String apiVersion) => _apiVersion = apiVersion;

  /*
   * Return apiVersion used
  */
  static String get getApiVersion => _apiVersion;

  /*
   * Oauth methods
   */

  /*
   * Obtain authentication credentials.
   *   success - The success callback function to use.
   *   fail    - The failure/error callback function to use.
   * Returns a dictionary with:
   *   accessToken
   *   refreshToken
   *   clientId
   *   userId
   *   orgId
   *   loginUrl
   *   instanceUrl
   *   userAgent
   *   community id
   *   community url
   */
  static Future<Map> getAuthCredentials() async {
    final Object? response = await _platform._channel.invokeMethod(
        'oauth#getAuthCredentials'
    );
    return response is Map ? response : json.decode(response?.toString() ?? '');
  }

  static Future<Object> getClientInfo() async {
    final Object response = await _platform._channel.invokeMethod(
        'oauth#getClientInfo'
    );
    return response;
  }

  static Future<void> authenticate() async {
    await _platform._channel.invokeMethod('oauth#authenticate');
  }

  static Future<void> logoutCurrentUser() async {
    await _platform._channel.invokeMethod('oauth#logoutCurrentUser');
  }

}