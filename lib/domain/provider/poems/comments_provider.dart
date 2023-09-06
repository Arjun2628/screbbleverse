import 'package:flutter/material.dart';

class CommentsProvider extends ChangeNotifier {
  TextEditingController commentController = TextEditingController();

  String commentDifference(Duration duration) {
    if (duration.inHours < 1) {
      // Within 1 hour, show minutes
      return '${duration.inMinutes} minutes ago';
    } else if (duration.inHours < 24) {
      // Within 24 hours, show hours
      if (duration.inHours < 2) {
        return '${duration.inHours} hour ago';
      }
      return '${duration.inHours} hours ago';
    } else {
      // More than 24 hours, show days
      return '${duration.inDays} days ago';
    }
  }
}
