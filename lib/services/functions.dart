// общие функции

import 'package:url_launcher/url_launcher.dart';


// позвонить
Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  await launchUrl(launchUri);
}

// написать email
Future<void> goEmail(String email) async {
  final Uri launchUri = Uri(scheme: 'mailto', path: email);
  await launchUrl(launchUri);
}

// перейти по url
Future<void> goUrl(String url, {LaunchMode mode = LaunchMode.platformDefault}) async {
  final launch = await launchUrl(Uri.parse(url), mode: mode);
  if (!launch) {
    throw Exception('Не удалось перейти по ссылке');
  }
}
