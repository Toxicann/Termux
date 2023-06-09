import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static urlLauncher(String url, {bool addHead = true}) async {
    String urlHead = addHead ? "https://www." : "";

    final Uri _url = Uri.parse('$urlHead${prepareUrl(url)}');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  static String prepareUrl(String url) {
    if (url.startsWith('-')) {
      return url.substring(2).trim();
    }

    return url.trim();
  }
}
