// ignore_for_file: use_null_aware_elements

import 'package:url_launcher/url_launcher.dart';

final class AppLauncher {
  AppLauncher._();

  // =========================================================
  // CORE
  // =========================================================

  static Future<bool> launchUrlString(
    String url, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    try {
      final uri = Uri.parse(url);

      if (!await canLaunchUrl(uri)) {
        return false;
      }

      return await launchUrl(uri, mode: mode);
    } catch (_) {
      return false;
    }
  }

  // =========================================================
  // WEB
  // =========================================================

  static Future<bool> openWebsite(String url) async {
    final formatted = url.startsWith('http') ? url : 'https://$url';

    return launchUrlString(formatted, mode: LaunchMode.externalApplication);
  }

  // =========================================================
  // EMAIL
  // =========================================================

  static Future<bool> sendEmail({
    required String email,
    String? subject,
    String? body,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email.isEmpty ? null : email,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );

    return launchUrl(uri);
  }

  // =========================================================
  // PHONE
  // =========================================================

  static Future<bool> callPhone(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);

    return launchUrl(uri);
  }

  // =========================================================
  // SMS
  // =========================================================

  static Future<bool> sendSms(String phoneNumber, {String? message}) async {
    final uri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {if (message != null) 'body': message},
    );

    return launchUrl(uri);
  }

  // =========================================================
  // WHATSAPP
  // =========================================================

  static Future<bool> openWhatsApp({
    required String phone,
    String? message,
  }) async {
    final encodedMessage = Uri.encodeComponent(message ?? '');

    final url = 'https://wa.me/$phone?text=$encodedMessage';

    return openWebsite(url);
  }

  // =========================================================
  // MAPS
  // =========================================================

  static Future<bool> openMaps({
    required double latitude,
    required double longitude,
  }) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    return openWebsite(url);
  }
}
