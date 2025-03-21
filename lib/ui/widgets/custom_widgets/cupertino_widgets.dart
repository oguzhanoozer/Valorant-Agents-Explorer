import 'custom_base_widgets.dart';
import 'widgets/custom_activity_indicator.dart';

class CupertinoWidgets extends CustomBaseWidgets {
  @override
  CustomActivityIndicator createActivityIndicator() => IOSActivityIndicator();
}
