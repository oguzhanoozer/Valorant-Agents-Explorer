import 'package:auto_route/auto_route.dart';

final class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // final String? agentAddress = await ServiceLocator.get<LocalStorageService>().read(Keys.baseUrl);
    // if (agentAddress != null) {
    //   resolver.next(true);
    // } else {
    //   router.push(LoginScreenRoute());
    // }
    /// TODO check authentication and navigation user

    resolver.next(true);
  }
}
