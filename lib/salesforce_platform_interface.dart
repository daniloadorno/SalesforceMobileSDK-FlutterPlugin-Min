import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:salesforce/salesforce_method_channel.dart';

abstract class SalesforcePluginPlatform extends PlatformInterface {

  SalesforcePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static SalesforcePluginPlatform _instance = MethodChannelSalesforcePlugin();

  static SalesforcePluginPlatform get instance => _instance;

  static set instance(SalesforcePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map> sendRequest({String endPoint = '/services/data', String path = '', String method = 'GET', Map? payload, Map? headerParams, Map? fileParams, bool returnBinary = false}) =>
      _instance.sendRequest(endPoint: endPoint, path: path, method: method, payload: payload, headerParams: headerParams, fileParams: fileParams, returnBinary: returnBinary);

  Future<Map> getAuthCredentials() => _instance.getAuthCredentials();

  Future<Object> getClientInfo() => _instance.getClientInfo();

  Future<void> authenticate() => _instance.authenticate();

  Future<void> logoutCurrentUser() => _instance.logoutCurrentUser();

}