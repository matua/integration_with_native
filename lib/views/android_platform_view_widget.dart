import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidPlatformViewWidget extends StatefulWidget {
  const AndroidPlatformViewWidget({Key? key, required this.creationParams}) : super(key: key);
  final Map<String, dynamic> creationParams;

  @override
  State<AndroidPlatformViewWidget> createState() => _AndroidPlatformViewWidgetState();
}

class _AndroidPlatformViewWidgetState extends State<AndroidPlatformViewWidget> {
  @override
  Widget build(BuildContext context) {
    final params = widget.creationParams;
    if (kDebugMode) {
      print("ANDROID VIEW $params");
    }
    const String viewType = '<platform-view-type>';

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: params,
          creationParamsCodec: const StandardMessageCodec(),
        );
      case TargetPlatform.iOS:
        Map<String, dynamic> params = {'text': widget.creationParams};
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: params,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError('Platform view not supported for this platform.');
    }
  }
}
