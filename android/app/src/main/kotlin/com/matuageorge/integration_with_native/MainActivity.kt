package com.matuageorge.integration_with_native

import AndroidEditTextViewFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val messageChannelId = "com.matuageorge/native_demo"
    private val intentMessageId = "textfieldFromFlutter"
    private val androidViewId = "<platform-view-type>"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(androidViewId, AndroidEditTextViewFactory())

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            messageChannelId
        ).setMethodCallHandler { call, result ->
            if (call.method == intentMessageId) {
                val text = call.arguments<String>()
                result.success(text)
                print("ANDROID TEXT:$text")
            } else {
                result.notImplemented()
            }
        }
    }
}
