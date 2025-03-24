import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'icon_button.dart';

final class CustomScaffold extends Scaffold {
  const CustomScaffold({
    super.key,
    super.backgroundColor,
    super.extendBodyBehindAppBar = false,
    CustomAppBar? appBar,
    super.body,
    CustomIconButton? floatingActionButton,
    super.floatingActionButtonLocation,
    super.bottomNavigationBar,
  }) : super(
          resizeToAvoidBottomInset: false,
          appBar: appBar,
          floatingActionButton: floatingActionButton,
        );
}
