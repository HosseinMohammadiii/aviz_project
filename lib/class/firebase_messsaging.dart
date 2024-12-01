import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  static Future<void> initialize() async {
    //initialize Firebase
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDgQ8h1R_HNR367iZoBzo6q5HLYewMe3-M',
        appId: '1:807035455736:android:88644b4563303ad687530d',
        messagingSenderId: '807035455736',
        projectId: 'aviz-project',
        storageBucket: 'aviz-project.appspot.com',
      ),
    );
    // Management Message in Forground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showLocalNotification(
          message.notification!.title, message.notification?.body);
    });
  }
}

//Display Notification
Future<void> showLocalNotification(String? title, String? body) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // Initial Settings Local Notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    '0',
    'Aviz',
    importance: Importance.high,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
  );

  const NotificationDetails platformDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformDetails,
  );
}
