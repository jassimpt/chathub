// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/foundation.dart';

// class NotificationService {
//   static const notificationkey =
//       "AAAAm7k8ZGQ:APA91bEYioUvo2jUPnsk37c6Q4pre_kbL-vtqAIdjl_3yMKrueHdCgToeWC9DvsmM81k7QYNOmW9fm0KYUXLNCNBLaV_ActFeX7f1WktiqufeItZ8CTHjMsFKn8HhswG61hYrNy_of4V";

//   final flutternotificationplugin = FlutterLocalNotificationsPlugin();

//   void initLocalNotification() {
//     const androidSettings =
//         AndroidInitializationSettings("@mipmap/ic_launcher");
//     const iosSettings = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestCriticalPermission: true,
//       requestSoundPermission: true,
//     );
//     const initializationSettings =
//         InitializationSettings(android: androidSettings, iOS: iosSettings);
//     flutternotificationplugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (response) {
//         debugPrint(response.payload.toString());
//       },
//     );
//   }

//   Future<void> showNotification(RemoteMessage message)  async {
//     await flutternotificationplugin.show(0, message., message, notificationDetails);
//   }
// }
