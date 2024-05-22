import 'package:etcsms/screen/create_application/create_application_view.dart';
import 'package:etcsms/screen/login/login_view.dart';
import 'package:etcsms/screen/templates/templates_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screen/my_profile/my_profile_page.dart';
import '../screen/users/users_view.dart';
import '../screen/applications/applications_view.dart';

part 'router.g.dart';

@TypedGoRoute<LoginScreenRoute>(
  path: '/login',
)
class LoginScreenRoute extends GoRouteData {
  const LoginScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => LoginPage();
}

@TypedGoRoute<ApplicationListingRoute>(path: '/dashboard/applications')
class ApplicationListingRoute extends GoRouteData {
  const ApplicationListingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => ApplicationsPage();
}

@TypedGoRoute<UsersListingRoute>(path: '/dashboard/users')
class UsersListingRoute extends GoRouteData {
  const UsersListingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => UsersPage();
}

@TypedGoRoute<MyProfileListingRoute>(path: '/dashboard/my_profile')
class MyProfileListingRoute extends GoRouteData {
  const MyProfileListingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => MyProfilePage();
}

@TypedGoRoute<TemplateListingRoute>(path: '/dashboard/applications/templates')
class TemplateListingRoute extends GoRouteData {
  final int applicationId;

  const TemplateListingRoute(this.applicationId);

  @override
  Widget build(BuildContext context, GoRouterState state) => TemplatesPage(
        applicationId: applicationId,
      );
}

@TypedGoRoute<ApplicationCreateRoute>(path: '/dashboard/applications/create')
class ApplicationCreateRoute extends GoRouteData {
  const ApplicationCreateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CreateApplicationPage();
}
