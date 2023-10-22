import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessageing = FirebaseMessaging.instance;

  Future<void> initNotifications() async{
    await _firebaseMessageing.requestPermission();

    // final token = await _firebaseMessageing.getToken();

    // print('$token');

    // initPushNotifications();
  }

  // void handleMessage(RemoteMessage? message){
  //   if(message == null) return;

    
  // }

  // Future initPushNotifications() async{
  //   FirebaseMessaging.instance.getInitialMessage().then((value) => handleMessage);

  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  // }
}
