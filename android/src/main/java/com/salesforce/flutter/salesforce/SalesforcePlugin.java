package com.salesforce.flutter.salesforce;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.salesforce.flutter.salesforce.bridge.SalesforceFlutterBridge;
import com.salesforce.flutter.salesforce.bridge.SalesforceNetFlutterBridge;
import com.salesforce.flutter.salesforce.bridge.SalesforceOauthFlutterBridge;
import com.salesforce.flutter.salesforce.bridge.SmartStoreFlutterBridge;
import com.salesforce.flutter.salesforce.bridge.SmartSyncFlutterBridge;
import com.salesforce.flutter.salesforce.ui.SalesforceFlutterActivity;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;

public class SalesforcePlugin implements FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {

    private MethodChannel channel;
    private Activity activity;

    private SalesforceOauthFlutterBridge oauthBridge;
    private SalesforceNetFlutterBridge networkBridge;
    private SmartStoreFlutterBridge smartStoreFlutterBridge;
    private SmartSyncFlutterBridge smartSyncFlutterBridge;

    public SalesforcePlugin() {}

    public SalesforcePlugin(Activity activity) {
        this.setActivity(activity);
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "salesforce");
        this.channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        final String prefix = call.method.substring(0, call.method.indexOf("#"));
        for (SalesforceFlutterBridge bridge : new SalesforceFlutterBridge[]{ this.oauthBridge, this.networkBridge, this.smartStoreFlutterBridge, this.smartSyncFlutterBridge }) {
            if (prefix.equals(bridge.getPrefix())) {
                bridge.onMethodCall(call, result);
                return;
            }
        }
        result.notImplemented();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }



    public void setActivity(Activity activity) {
        if (activity != null){
            this.activity = activity;
            this.networkBridge = new SalesforceNetFlutterBridge((SalesforceFlutterActivity) this.activity);
            this.oauthBridge = new SalesforceOauthFlutterBridge((SalesforceFlutterActivity) this.activity);
            this.smartStoreFlutterBridge = new SmartStoreFlutterBridge((SalesforceFlutterActivity) this.activity);
            this.smartSyncFlutterBridge = new SmartSyncFlutterBridge((SalesforceFlutterActivity) this.activity);
        }
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        this.setActivity(binding.getActivity());
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        this.activity = null;
        this.channel.setMethodCallHandler(null);
    }
}
