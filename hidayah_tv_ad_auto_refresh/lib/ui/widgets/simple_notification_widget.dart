import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hidayah_tv_ad/ui/shared/app_colors.dart';

void simpleNotificationWidget({
  int? statusCode,
  required String message,
}) {
  Color color = Colors.transparent;
  int timeInSecond = 4;
  if (statusCode == null) {
    color = kYellowSignalColor;
  } else if (200 <= statusCode && statusCode < 300) {
    color = kGreenSignalColor;
  } else if (400 <= statusCode && statusCode < 500) {
    color = kRedSignalColor;
  } else if (500 <= statusCode && statusCode < 600) {
    color = kYellowSignalColor;
  }

  if (message.length <= 50) {
    timeInSecond = 4;
  } else if (50 < message.length && message.length <= 100) {
    timeInSecond = 6;
  } else if (100 < message.length && message.length <= 200) {
    timeInSecond = 8;
  } else {
    timeInSecond = 1;
  }

  BotToast.showSimpleNotification(
    crossPage: true,
    title: message,
    backgroundColor: color,
    titleStyle: const TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    closeIcon: const Icon(
      Icons.cancel,
      color: Colors.white,
    ),
    duration: Duration(seconds: timeInSecond),
    borderRadius: 12.0,
  );
}
