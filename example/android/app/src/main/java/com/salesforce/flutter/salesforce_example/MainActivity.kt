package com.salesforce.flutter.salesforce_example

import com.salesforce.flutter.salesforce.ui.SalesforceFlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : SalesforceFlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}