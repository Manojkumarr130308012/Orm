import 'package:dms_dealers/router.dart';
import 'package:dms_dealers/utils/app_themes.dart';
import 'package:dms_dealers/utils/preference_manager.dart';
import 'package:dms_dealers/widgets/bloc.dart';
import 'package:dms_dealers/widgets/flutter_core_widgets.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'authenticatiom/bloc/authentication_bloc.dart';
import 'authenticatiom/bloc/authentication_event.dart';
import 'screens/splash/splash_screen.dart';

// FLUTTER NOTIFICATION INSTANCE
FlutterLocalNotificationsPlugin notificationsPlugin =
FlutterLocalNotificationsPlugin();

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

String fcmToken = "Getting Firebase Token";

Future<void> myBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  return _showNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  requestingPermissionForIOS();
  FirebaseMessaging.onBackgroundMessage(myBackgroundHandler);

  await SharedPreferenceUtils.init();
  AndroidInitializationSettings androidSettings =
  const AndroidInitializationSettings("@mipmap/ic_launcher");

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = EchoBlocDelegate();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) {
        return AuthenticationBloc()..add(AppStarted(context: context));
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends CoreWidgets {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends CoreWidgetsState<MyApp> {
  Locale? _locale;
  AuthenticationBloc? bloc;
  String? generateTokes;

  @override
  void initState() {
    bloc = BlocProvider.of<AuthenticationBloc>(context);
    //toCheckInternetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    return DynamicTheme(
      themeCollection: AppThemes().getThemeCollections(),
      builder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          title: 'dms',
          locale: _locale,
          theme: theme,
          supportedLocales: const [
            Locale('en', ''),
            Locale('ar', ''),
            Locale('hi', '')
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            for (Locale supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          onGenerateRoute: getRoute,
          debugShowCheckedModeBanner: false,
          home: addAuthBloc(
            context,
            const Splash(),
          ),
        );
      },
    );
  }
}

Future _showNotification(RemoteMessage message) async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  await notificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  print("message.data${message.notification}");

  Map<String, dynamic> data = message.data;
  AndroidNotification? android = message.notification?.android!;
  if (message.notification != null) {
    notificationsPlugin.show(
      0,
      message.notification?.title!,
      message.notification?.body!,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          icon: android?.smallIcon,
          // other properties...
        ),
        // iOS: IOSNotificationDetails(presentAlert: true, presentSound: true),
      ),
      payload: 'Default_Sound',
    );
  }
}

requestingPermissionForIOS() async {
  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
}

getTokenz() async {
  String? token = await _firebaseMessaging.getToken();
  fcmToken = token!;
  print("fcmToken $fcmToken");
}

Future selectNotification(String payload) async {
  await notificationsPlugin.cancelAll();
}
