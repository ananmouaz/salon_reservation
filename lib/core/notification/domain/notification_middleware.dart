import '../../constants/enums.dart';
import '../data/fcm_notification_model.dart';

class NotificationMiddleware {
  static forward(FCMNotificationModel notification) async {
    switch(notification.type){

      case NotificationType.NULL:
        break;

      case null:
        // TODO: Handle this case.
      case NotificationType.DelegationGranted:
        // TODO: Handle this case.
      case NotificationType.DelegationEnded:
        // TODO: Handle this case.
      case NotificationType.ApprovalRequestAdded:
        // TODO: Handle this case.
      case NotificationType.ApprovalRequestRejected:
        // TODO: Handle this case.
      case NotificationType.ApprovalRequestApproved:
        // TODO: Handle this case.
      case NotificationType.ItemMinQuantityReached:
        // TODO: Handle this case.
      case NotificationType.TaskAssigned:
        // TODO: Handle this case.
      case NotificationType.TaskLateFirstReminder:
        // TODO: Handle this case.
      case NotificationType.TaskLateSecondReminder:
        // TODO: Handle this case.
      case NotificationType.TaskLateEscalation:
        // TODO: Handle this case.
    }
  }

  static onReceived(FCMNotificationModel notification) async {}
}
