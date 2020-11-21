import 'package:flutter/cupertino.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationsVM extends ChangeNotifier{

  String currentUserId = "";

  initOneSignal() async{
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init(
        "d818aab2-b2e6-4c18-abf0-030ebe18694a",
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: false
        }
    );
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

    await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);
    var subscriptionStatus = await OneSignal.shared.getPermissionSubscriptionState();
    currentUserId = subscriptionStatus.subscriptionStatus.userId;
    notifyListeners();
  }
  postNotification(List<String> playerIds, String title, String content) async{
    var status = await OneSignal.shared.getPermissionSubscriptionState();
   
    await OneSignal.shared.postNotification(OSCreateNotification(
        playerIds: playerIds,
        content: content,
        heading: title,
        androidChannelId: "920f0531-29ca-47aa-8a25-24eca5587af9",
        iosSound: "order_notification_sound.wav",
    ));
  }

  postCampaignNotification(List<String> playerIds, String title, String content) async{
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    await OneSignal.shared.postNotification(OSCreateNotification(
      playerIds: playerIds,
      content: content,
      heading: title,
      androidChannelId: "de74b166-f90b-4519-b2d9-b54587b0418b",
    ));
  }
}