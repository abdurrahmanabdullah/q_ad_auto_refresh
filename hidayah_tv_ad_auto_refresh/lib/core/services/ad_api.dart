import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hidayah_tv_ad/core/models/ad_model.dart';
import 'package:hidayah_tv_ad/ui/route_navigation.dart';
import 'package:hidayah_tv_ad/ui/widgets/simple_notification_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdAPI {
  /// Sign In API
  Future<int?> signInAPI(
    String appId,
  ) async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      String domain = preferences.getString('domain')!;

      http.Response response = await http.post(
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        Uri.parse('$domain/v1/user/login'),
        body: jsonEncode({
          'app_id': appId,
        }),
      );

      log(response.body);

      if (response.statusCode == 201) {
        preferences.setString('token', jsonDecode(response.body)['token']);
        simpleNotificationWidget(
            statusCode: response.statusCode, message: 'Verified');
      } else {
        simpleNotificationWidget(
            statusCode: response.statusCode,
            message: jsonDecode(response.body)['message']);
      }

      return response.statusCode;
    } on TimeoutException {
      simpleNotificationWidget(message: 'Connection timeout');
    } on SocketException {
      simpleNotificationWidget(message: 'Please check your connection');
    } on Error {
      simpleNotificationWidget(message: 'Unexpected error occurred');
    } on FormatException {
      simpleNotificationWidget(message: 'Server is under maintenance');
    } catch (e) {
      simpleNotificationWidget(message: 'Something went wrong');
    }
    return null;
  }

  /// Get all ADs API
  Future<AdModel?> getAdsAPI() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String domain = preferences.getString('domain')!;
      String? token = preferences.getString('token');

      http.Response response = await http.get(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token!}',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        Uri.parse('${domain}v1/tv/info/all'),
      );

      log(response.body);

      if (response.statusCode == 200) {
        AdModel ad = adModelFromJson(response.body);

        return ad;
      } else if (response.statusCode == 401 || response.statusCode == 401) {
        await globalSignOut(
          response.statusCode,
          jsonDecode(response.body)['description'],
        );
      }
    } on TimeoutException {
      simpleNotificationWidget(message: 'Connection timeout');
    } on SocketException {
      simpleNotificationWidget(message: 'Please check your connection');
    } on Error {
      simpleNotificationWidget(message: 'Unexpected error occurred');
    } on FormatException {
      simpleNotificationWidget(message: 'Server is under maintenance');
    } catch (e) {
      simpleNotificationWidget(message: 'Something went wrong');
    }
    return null;
  }
}
