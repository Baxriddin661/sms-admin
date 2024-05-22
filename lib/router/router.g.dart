// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $loginScreenRoute,
      $applicationListingRoute,
      $usersListingRoute,
      $myProfileListingRoute,
      $templateListingRoute,
      $applicationCreateRoute,
    ];

RouteBase get $loginScreenRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginScreenRouteExtension._fromState,
    );

extension $LoginScreenRouteExtension on LoginScreenRoute {
  static LoginScreenRoute _fromState(GoRouterState state) =>
      const LoginScreenRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $applicationListingRoute => GoRouteData.$route(
      path: '/dashboard/applications',
      factory: $ApplicationListingRouteExtension._fromState,
    );

extension $ApplicationListingRouteExtension on ApplicationListingRoute {
  static ApplicationListingRoute _fromState(GoRouterState state) =>
      const ApplicationListingRoute();

  String get location => GoRouteData.$location(
        '/dashboard/applications',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $usersListingRoute => GoRouteData.$route(
      path: '/dashboard/users',
      factory: $UsersListingRouteExtension._fromState,
    );

extension $UsersListingRouteExtension on UsersListingRoute {
  static UsersListingRoute _fromState(GoRouterState state) =>
      const UsersListingRoute();

  String get location => GoRouteData.$location(
        '/dashboard/users',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $myProfileListingRoute => GoRouteData.$route(
      path: '/dashboard/my_profile',
      factory: $MyProfileListingRouteExtension._fromState,
    );

extension $MyProfileListingRouteExtension on MyProfileListingRoute {
  static MyProfileListingRoute _fromState(GoRouterState state) =>
      const MyProfileListingRoute();

  String get location => GoRouteData.$location(
        '/dashboard/my_profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $templateListingRoute => GoRouteData.$route(
      path: '/dashboard/applications/templates',
      factory: $TemplateListingRouteExtension._fromState,
    );

extension $TemplateListingRouteExtension on TemplateListingRoute {
  static TemplateListingRoute _fromState(GoRouterState state) =>
      TemplateListingRoute(
        int.parse(state.uri.queryParameters['application-id']!),
      );

  String get location => GoRouteData.$location(
        '/dashboard/applications/templates',
        queryParams: {
          'application-id': applicationId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $applicationCreateRoute => GoRouteData.$route(
      path: '/dashboard/applications/create',
      factory: $ApplicationCreateRouteExtension._fromState,
    );

extension $ApplicationCreateRouteExtension on ApplicationCreateRoute {
  static ApplicationCreateRoute _fromState(GoRouterState state) =>
      const ApplicationCreateRoute();

  String get location => GoRouteData.$location(
        '/dashboard/applications/create',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
