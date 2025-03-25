import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:graduation_project/app/utils/helper.dart';
import 'package:graduation_project/features/auth_feature/presentation/presentation_logic_holder/auth_cubit.dart';
import 'package:graduation_project/features/bottom_navigation_feature/presentation/presentation_logic_holder/bottom_navigation_cubit.dart';
import 'package:graduation_project/features/bottom_navigation_feature/presentation/screens/bottom_navigation_screen.dart';
import 'package:graduation_project/features/categories_feature/presentation/PLH/category_cubit.dart';
import 'package:graduation_project/features/categories_feature/presentation/screens/categories_screen.dart';
import 'package:graduation_project/features/chat_feature/presentation/presentation_logic_holder/chat_cubit.dart';
import 'package:graduation_project/features/intro_feature/presentation/screens/splash_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app/themes/get_theme.dart';
import 'app/utils/bloc_observer.dart';
import 'app/utils/consts.dart';
import 'app/utils/get_it_injection.dart';
import 'app/utils/language_manager.dart';
import 'app/utils/navigation_helper.dart';
import 'app/utils/notification_helper.dart';
import 'app/widgets/carousel_widget/carousel_cubit/carousel_cubit.dart';
import 'firebase_options.dart';


FlutterTts flutterTts = FlutterTts();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await init();
  Stripe.publishableKey = kPublishKey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print(await FirebaseMessaging.instance.getToken(),);
  print("=========================");
  // preparationFCM();
  //
  // /// Set up  message handler
  // _onMessagingOpenAppFCM();
  // _onMessagingFCM();
  //FirebaseMessaging.onBackgroundMessage(_onMessagingBackgroundHandler);
  await [
    Permission.location,
    Permission.storage,
    Permission.camera,
    Permission.mediaLibrary,
    Permission.notification,
    Permission.photos,
  ].request();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CarouselCubit>(
          create: (BuildContext context) => CarouselCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
        BlocProvider<ChatCubit>(
          create: (BuildContext context) => ChatCubit(),
        ),
        BlocProvider<CategoryCubit>(
          create: (BuildContext context) => CategoryCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key,});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    NotificationHelper();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        english_local,
        arabic_local,
      ],
      saveLocale: true,
      startLocale:arabic_local ,
      path: assets_path_localisations,
      fallbackLocale: arabic_local,
      //
      //* OverlaySupport
      //
      child: OverlaySupport.global(
        //
        //* ScreenUtilInit
        //
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          //
          //* MaterialApp
          //
          builder: (context, child) => MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              // locale: CookieManagerService.getLocale,
              locale: context.locale,
              title: 'Grow.AI',
              theme: graduationProjectTheme(),
              debugShowCheckedModeBanner: false,
              navigatorKey: getIt<NavHelper>().navigatorKey,
              //
              //* EasyLoading
              //
              builder: EasyLoading.init(
                builder: (context, widget) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                    child: widget!,
                  );
                },
              ),
              home:
              SplashScreen()
              //getIt<CacheService>().getUserData()
          ),
        ),
      ),
    );
  }
}


Future<void> _onMessagingBackgroundHandler(RemoteMessage message) async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: "@mipmap/ic_launcher",
            // other properties...
          ),
        ));
  }
}

Future<void> _onMessagingFCM() async {
  FirebaseMessaging.onMessage.listen((event) {
    print("on message FCM");
    print(
        event.notification!.title.toString()
            + event.notification!.body.toString()
    );
  });
}

Future<void> _onMessagingOpenAppFCM() async {
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    BottomNavigationCubit.get(getIt<NavHelper>().navigatorKey.currentState!.context).changeCurrent(2);
    navigateTo(BNBScreen());
    print("on message FCM");
    print(
      event.notification!.title.toString()+
          event.notification!.body.toString(),
    );
  });
}

Future<void> preparationFCM() async {
  final messaging = FirebaseMessaging.instance;

  requestPermission();

  String? token = await messaging.getToken();

  print('Registration Token=$token');
}

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
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
}