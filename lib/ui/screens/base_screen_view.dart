import 'package:flutter/material.dart';

import '../../core/configs/theme/app_colors.dart';
import '../../core/init/app_locator.dart';
import '../widgets/custom_widgets/create_adaptive_widgets.dart';
import '../widgets/scaffold.dart';
import 'base_screen_args.dart';
import 'base_screen_controller.dart';

const double _kProgressIndicatorBackgroundOpacity = 0.60;

abstract base class BaseScreenView<C extends BaseScreenController<A>, A extends BaseScreenArgs> extends StatefulWidget {
  final A args;
  final ScaffoldSafeArea safeArea;

  const BaseScreenView({
    super.key,
    required this.args,
    this.safeArea = const ScaffoldSafeArea(),
  });
}

abstract base class BaseScreenViewState<T extends BaseScreenView<C, A>, C extends BaseScreenController<A>, A extends BaseScreenArgs> extends State<T> {
  late final C controller;
  bool isControllerReady = false;

  @override
  void initState() {
    super.initState();
    controller = ControllerLocator.create<C, A>(hashCode, widget.args);
    WidgetsBinding.instance.addObserver(controller);

    controller.onInitState().then((_) {
      setState(() {
        isControllerReady = true;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(controller);
    ControllerLocator.dispose<C>(hashCode);
    super.dispose();
  }

  CustomScaffold builder(BuildContext context, C controller);

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);

    final Widget loadingIndicator = Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(_kProgressIndicatorBackgroundOpacity),
      child: CreateAdaptiveWidgets().adaptiveActivityIndicator(),
    );

    final Widget view = Container(
      color: AppColors.background,
      child: SafeArea(
        left: widget.safeArea.left,
        top: widget.safeArea.top,
        right: widget.safeArea.right,
        bottom: widget.safeArea.bottom,
        child: isControllerReady ? builder(context, controller) : loadingIndicator,
      ),
    );

    return AnimatedBuilder(
      animation: controller.viewState,
      builder: (context, _) {
        return Stack(
          children: <Widget>[
            view,
            if (controller.viewState.isBusy) loadingIndicator,
          ],
        );
      },
    );
  }
}

final class ScaffoldSafeArea {
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;

  const ScaffoldSafeArea({
    this.left = false,
    this.right = false,
    this.top = false,
    this.bottom = true,
  });
}

// import 'package:flutter/material.dart';

// import '../../core/configs/theme/app_colors.dart';
// import '../../core/init/app_locator.dart';
// import '../../core/models/rx.dart';
// import '../widgets/custom_widgets/create_adaptive_widgets.dart';
// import '../widgets/obx.dart';
// import '../widgets/scaffold.dart';
// import 'base_screen_args.dart';
// import 'base_screen_controller.dart';

// const double _kProgressIndicatorBackgroundOpacity = 0.60;

// abstract base class BaseScreenView<C extends BaseScreenController<A>, A extends BaseScreenArgs> extends StatefulWidget {
//   final A args;
//   final ScaffoldSafeArea safeArea;

//   const BaseScreenView({
//     super.key,
//     required this.args,
//     this.safeArea = const ScaffoldSafeArea(),
//   });
// }

// abstract base class BaseScreenViewState<T extends BaseScreenView<C, A>, C extends BaseScreenController<A>, A extends BaseScreenArgs> extends State<T> {
//   late final C controller;
//   final Rx<bool> isControllerReady = Rx<bool>(false);

//   @override
//   void initState() {
//     super.initState();
//     controller = ControllerLocator.create<C, A>(hashCode, widget.args);
//     WidgetsBinding.instance.addObserver(controller);
//     controller.onInitState().then((_) => isControllerReady(set: () => true));
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(controller);
//     ControllerLocator.dispose<C>(hashCode);
//     super.dispose();
//   }

//   CustomScaffold builder(BuildContext context, C controller);

//   @override
//   Widget build(BuildContext context) {
//     controller.context(set: () => context);

//     final Widget loadingIndicator = Container(
//       alignment: Alignment.center,
//       color: Colors.black.withOpacity(_kProgressIndicatorBackgroundOpacity),
//       child: CreateAdaptiveWidgets().adaptiveActivityIndicator(),
//     );

//     final Widget view = Container(
//       color: AppColors.background,
//       child: SafeArea(
//         left: widget.safeArea.left,
//         top: widget.safeArea.top,
//         right: widget.safeArea.right,
//         bottom: widget.safeArea.bottom,
//         child: Obx(
//           isControllerReady,
//           builder: (BuildContext context, Rx<bool> isControllerReady, _) {
//             if (isControllerReady()) {
//               return builder(context, controller);
//             }
//             return loadingIndicator;
//           },
//         ),
//       ),
//     );

//     final Widget busyViewIndicator = Obx(
//       controller.viewState.isBusy,
//       builder: (BuildContext context, Rx<bool> isBusy, _) {
//         return switch (isBusy()) {
//           true => loadingIndicator,
//           false => const SizedBox(),
//         };
//       },
//     );
//     return Stack(
//       children: <Widget>[
//         view,
//         busyViewIndicator,
//       ],
//     );
//   }
// }

// final class ScaffoldSafeArea {
//   final bool left;
//   final bool top;
//   final bool right;
//   final bool bottom;

//   const ScaffoldSafeArea({
//     this.left = false,
//     this.right = false,
//     this.top = false,
//     this.bottom = true,
//   });
// }
