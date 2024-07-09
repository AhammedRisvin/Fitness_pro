import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olympic/app/env.dart';
import 'package:provider/provider.dart';

import 'app/core/app_router.dart';
import 'app/core/firebase_api/notification_service.dart';
import 'app/modules/pharma/view/order_history_screen.dart';
import 'app/utils/app_constants.dart';
import 'app/utils/extensions.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = Environments.stripePublishableKey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await NotificationService().initMessaging();
  await NotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return OrientationBuilder(
              builder: (context, orientation) {
                Responsive().init(constraints, orientation);
                return MaterialApp(
                  scaffoldMessengerKey: Routes.ctx,
                  navigatorKey: Routes.key,
                  title: 'Olympic',
                  theme: ThemeData(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    primarySwatch: Colors.amber,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  debugShowCheckedModeBanner: false,
                  home: const PharmacyOrderHistoryScreen(),
                );
              },
            );
          },
        );
      },
    );
  }
}
