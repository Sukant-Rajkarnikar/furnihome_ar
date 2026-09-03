

// class AuthGuard extends AutoRouteGuard {
//   final AuthRepository repository = locator<AuthRepository>();
//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) async {
//     final SharedPreferencesService sharedPref = locator<SharedPreferencesService>();
//     bool isAuthenticated = sharedPref.hasAccessToken();
//     if (!isAuthenticated) {
//       router.push(const LoginRoute());
//     } else {
//       resolver.next(true);
//
//       debugPrint("isAuthenticated $isAuthenticated onnavigation");
//       if (true) {
//         debugPrint("before onnavigation app_route");
//         resolver.next(true);
//         debugPrint("after onnavigation app_route");
//       } else {
//       }
//     }
//   }
// }