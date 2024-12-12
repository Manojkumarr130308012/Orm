import 'package:dms_dealers/screens/drawer/drawer.dart';
import 'package:dms_dealers/screens/login_page/login_bloc.dart';
import 'package:dms_dealers/screens/login_page/login_event.dart';
import 'package:dms_dealers/screens/login_page/login_screen.dart';
import 'package:dms_dealers/screens/otp_screen/otp_bloc.dart';
import 'package:dms_dealers/screens/otp_screen/otp_event.dart';
import 'package:dms_dealers/screens/otp_screen/otp_screen.dart';
import 'package:dms_dealers/screens/profile/profile_details_event.dart';
import 'package:dms_dealers/screens/profile/profile_details_screen.dart';
import 'package:dms_dealers/screens/profile_view/profile_view_bloc.dart';
import 'package:dms_dealers/screens/profile_view/profile_view_event.dart';
import 'package:dms_dealers/screens/profile_view/profile_view_screen.dart';
import 'package:dms_dealers/screens/url_page/urlpage_bloc.dart';
import 'package:dms_dealers/screens/url_page/urlpage_event.dart';
import 'package:dms_dealers/screens/url_page/urlpage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authenticatiom/bloc/authentication_bloc.dart';
import 'authenticatiom/bloc/authentication_state.dart';
import 'screens/drawer/drawer_bloc.dart';
import 'screens/drawer/drawer_event.dart';
import 'screens/profile/profile_details_bloc.dart';

class AppRoutes {
  static const String dashboardScreen = 'dashboard_screen';
  static const String loginScreen = 'login_screen';
  static const String otpScreen = 'otp_screen';
  static const String drawerScreen = 'drawer_screen';
  static const String profile = 'profile_screen';
  static const String profile_details = 'profile_details_screen';
  static const String url = 'url_screen';
}

Route<dynamic>? getRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginScreen:
      return _buildLoginScreen();
    case AppRoutes.otpScreen:
      return _buildOtpScreen();
    case AppRoutes.drawerScreen:
      return _buildDrawerScreen();
    case AppRoutes.profile:
      return _buildProfileScreen();
    case AppRoutes.url:
      return _buildurlScreen();
  }
  return null;
}

Route<dynamic> _buildLoginScreen() {
  return MaterialPageRoute(
      builder: (BuildContext context) => PageBuilder.buildLoginScreen());
}

Route<dynamic> _buildOtpScreen() {
  return MaterialPageRoute(
      builder: (BuildContext context) => PageBuilder.buildOtpScreen());
}

Route<dynamic> _buildDrawerScreen() {
  return MaterialPageRoute(
      builder: (BuildContext context) => PageBuilder.buildDrawerScreen());
}

Route<dynamic> _buildProfileScreen() {
  return MaterialPageRoute(
      builder: (BuildContext context) => PageBuilder.buildProfileScreen());
}

Route<dynamic> _buildProfileDetailsScreen() {
  return MaterialPageRoute(
      builder: (BuildContext context) => PageBuilder.buildProfileDetailsScreen());
}

Route<dynamic> _buildurlScreen() {
  return MaterialPageRoute(
      builder: (BuildContext context) => PageBuilder.buildUrlScreen());
}


class PageBuilder {
  static Widget buildLoginScreen() {
    return BlocProvider(
        create: (BuildContext context) =>
            LoginBloc()..add(LoginInitialEvent(context: context)),
        child: const LoginScreen());
  }

  static Widget buildOtpScreen() {
    return BlocProvider(
        create: (BuildContext context) =>
            OTPBloc()..add(OTPInitialEvent(context: context)),
        child: const OTPScreen());
  }


  static Widget buildDrawerScreen() {
    return BlocProvider(
        create: (BuildContext context) =>
        DrawerBloc()..add(DrawerInitialEvent(context: context)),
        child: DmsDrawer());
  }


  static Widget buildProfileScreen() {
    return BlocProvider(
        create: (BuildContext context) =>
        ProfileDetailsBloc()..add(ProfileDetailsEventInitialEvent(context: context)),
        child: const ProfileDetailsScreen());
  }

  static Widget buildProfileDetailsScreen() {
    return BlocProvider(
        create: (BuildContext context) =>
        ProfileViewBloc()..add(ProfileViewEventInitialEvent(context: context)),
        child: const ProfileView());
  }

  static Widget buildUrlScreen() {
    return BlocProvider(
        create: (BuildContext context) =>
        UrlpageBloc()..add(UrlpageInitialEvent(context: context)),
        child: const UrlPage());
  }

}



Widget addAuthBloc(BuildContext context, Widget widget) {
  return BlocListener(
    bloc: BlocProvider.of<AuthenticationBloc>(context),
    listener: (BuildContext context, Object? state) async {
      if (state is AuthenticationUnAuthenticated) {
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        await Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
      }

      if (state is AuthenticationAuthenticated) {
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        await Navigator.pushReplacementNamed(context, AppRoutes.drawerScreen);
      }
    },
    child: BlocBuilder(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      builder: (BuildContext context, Object? state) {
        if (state is NoInternetConnectionState) {
          return Card(
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 1,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.no_accounts_sharp,
                    size: 34,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('No Internet Connection',
                      ),
                ],
              ),
            ),
          );
        } else {
          return widget;
        }
      },
    ),
  );
}
