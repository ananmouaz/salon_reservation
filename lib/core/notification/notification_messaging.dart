import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_fcm/flutter_fcm.dart';

class Messaging {
  static String? token;

  static deleteToken() {
    Messaging.token = null;
    FCM.deleteRefreshToken();
  }
  static subscribeToTopic(String topic) {
    FCM.subscribeToTopic(topic);
  }
  static unsubscribeFromTopic(String topic) {
    FCM.unsubscribeFromTopic(topic);
  }

  @pragma('vm:entry-point')
  static Future<void> onNotificationReceived(RemoteMessage message) async {
    await Firebase.initializeApp();
    //print('Handling a message ${message}');

  }

  @pragma('vm:entry-point')
  static initFCM() async {
    try {
      await Firebase.initializeApp();
      await FCM.initializeFCM(
        withLocalNotification: true,
        // navigatorKey: Keys.navigatorKey,
        onNotificationReceived: onNotificationReceived,
        onNotificationPressed: (Map<String, dynamic> data) {

        },
        onTokenChanged: (String? token) {
          if (token != null) {
            print('FCM token  $token');
            Messaging.token = token;


          }
        },
        icon: 'assets/icon.png',
      );
    } catch (e) {
      print(e);
    }
  }
}