import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lex_core/app/initialize_app.dart';
import 'package:lex_core/core/database/hive_service.dart';
import 'package:lex_core/services/notification_services/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:lex_core/di/injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:lex_core/core/utils/firestore_seeder.dart';

Future<void> _requestNotificationPermissions() async {
  try {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;
      await Permission.notification.request();
      if (sdkInt >= 30) {
        await Permission.manageExternalStorage.request();
      } else {
        await Permission.storage.request();
      }
    } else if (Platform.isIOS) {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    }
  } catch (e) {
    log('Error requesting permissions: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise local database
  await HiveService.init();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    log('Firebase initialization error (ignored): $e');
  }

  await _requestNotificationPermissions();
  await NotificationService().init();
  await di.init();

  // SAFETY: Never seed automatically in production.
  const bool enableFirestoreSeed = true;
  if (enableFirestoreSeed) {
    await FirestoreSeeder.seedAll();
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style for premium feel
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0D1117),
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(
    ProviderScope(
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return const MyApp();
        },
      ),
    ),
  );
}
