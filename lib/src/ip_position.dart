import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'models/ip_dns_info.dart';
import 'models/ip_geolocation_info.dart';

class IpPosition {
  /// Generates a random alphanumeric string of [len] length.
  static String _generateRandomString(int len) {
    var r = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  /// Fetches DNS and EDNS information.
  static Future<IpDnsInfo> getDnsInfo() async {
    final randomSubdomain = _generateRandomString(32);
    final url = 'https://$randomSubdomain.edns.ip-api.com/json?lang=en';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': '*/*',
        'Accept-Language': 'en-GB,en;q=0.9',
        'Connection': 'keep-alive',
        'Origin': 'https://ip-api.com',
        'Referer': 'https://ip-api.com/',
        'Sec-Fetch-Dest': 'empty',
        'Sec-Fetch-Mode': 'cors',
        'Sec-Fetch-Site': 'same-site',
        'Sec-GPC': '1',
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36',
        'sec-ch-ua': '"Brave";v="147", "Not.A/Brand";v="8", "Chromium";v="147"',
        'sec-ch-ua-mobile': '?0',
        'sec-ch-ua-platform': '"macOS"',
      },
    );

    if (response.statusCode == 200) {
      return IpDnsInfo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load DNS info: ${response.statusCode}');
    }
  }

  /// Fetches Geolocation info for a specific IP or current IP if not provided.
  static Future<IpGeolocationInfo> getGeolocationInfo([String? ip]) async {
    final url = ip != null && ip.isNotEmpty
        ? 'https://demo.ip-api.com/json/$ip?fields=66842623&lang=en'
        : 'https://demo.ip-api.com/json/?fields=66842623&lang=en';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': '*/*',
        'Accept-Language': 'en-GB,en;q=0.9',
        'Connection': 'keep-alive',
        'Origin': 'https://ip-api.com',
        'Referer': 'https://ip-api.com/',
        'Sec-Fetch-Dest': 'empty',
        'Sec-Fetch-Mode': 'cors',
        'Sec-Fetch-Site': 'same-site',
        'Sec-GPC': '1',
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36',
        'sec-ch-ua': '"Brave";v="147", "Not.A/Brand";v="8", "Chromium";v="147"',
        'sec-ch-ua-mobile': '?0',
        'sec-ch-ua-platform': '"macOS"',
      },
    );

    if (response.statusCode == 200) {
      return IpGeolocationInfo.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Failed to load geolocation info: ${response.statusCode}',
      );
    }
  }
}
