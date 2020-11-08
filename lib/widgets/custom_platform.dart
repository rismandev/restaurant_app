import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PlatformWidget extends StatelessWidget {
  final WidgetBuilder androidBuilder;
  final WidgetBuilder iosBuilder;

  PlatformWidget({@required this.androidBuilder, @required this.iosBuilder});

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return this.androidBuilder(context);
      case TargetPlatform.iOS:
        return this.iosBuilder(context);
      default:
        return this.androidBuilder(context);
    }
  }
}
