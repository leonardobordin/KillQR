import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/scan_models.dart';

class ExternalActionService {
  const ExternalActionService();

  Future<bool> openApplicationSettings() => _launchIntent(
    const AndroidIntent(
      action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
      data: 'package:com.killstreak.killqr',
    ),
  );

  Future<bool> execute(ExternalAction action) async {
    try {
      switch (action.type) {
        case ExternalActionType.openUrl:
        case ExternalActionType.productSearch:
        case ExternalActionType.composeEmail:
        case ExternalActionType.openGeo:
          return await launchUrl(
            Uri.parse(action.payload['uri']!),
            mode: LaunchMode.externalApplication,
          );
        case ExternalActionType.dial:
          return await _launchIntent(
            AndroidIntent(
              action: 'android.intent.action.DIAL',
              data: 'tel:${action.payload['phone']}',
            ),
          );
        case ExternalActionType.composeSms:
          final phone = Uri.encodeComponent(action.payload['phone'] ?? '');
          final body = Uri.encodeComponent(action.payload['body'] ?? '');
          return await launchUrl(
            Uri.parse('sms:$phone?body=$body'),
            mode: LaunchMode.externalApplication,
          );
        case ExternalActionType.insertContact:
          return await _launchIntent(
            AndroidIntent(
              action: 'android.intent.action.INSERT',
              type: 'vnd.android.cursor.dir/contact',
              arguments: <String, dynamic>{
                'name': action.payload['name'] ?? '',
                'phone': action.payload['phone'] ?? '',
              },
            ),
          );
        case ExternalActionType.insertEvent:
          return await _launchIntent(
            AndroidIntent(
              action: 'android.intent.action.INSERT',
              type: 'vnd.android.cursor.item/event',
              arguments: <String, dynamic>{
                'title': action.payload['title'] ?? '',
                if ((action.payload['start'] ?? '').isNotEmpty)
                  'beginTime': action.payload['start'],
                if ((action.payload['end'] ?? '').isNotEmpty)
                  'endTime': action.payload['end'],
              },
            ),
          );
        case ExternalActionType.openWifiSettings:
          return await _launchIntent(
            const AndroidIntent(action: 'android.settings.WIFI_SETTINGS'),
          );
      }
    } on PlatformException catch (_) {
      return false;
    } on FormatException catch (_) {
      return false;
    }
  }

  Future<bool> _launchIntent(AndroidIntent intent) async {
    if (!Platform.isAndroid) return false;
    final canResolve = await intent.canResolveActivity();
    if (canResolve != true) return false;
    await intent.launch();
    return true;
  }
}
