import 'package:auto_route/auto_route.dart';

import '../../init/app_locator.dart';
import '../../services/local_storage/local_storage_service.dart';
import '../app_router.dart';

final class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // final String? movieAddress = await ServiceLocator.get<LocalStorageService>().read(Keys.baseUrl);
    // if (movieAddress != null) {
    //   resolver.next(true);
    // } else {
    //   router.push(LoginScreenRoute());
    // }

    resolver.next(true);
  }
}
