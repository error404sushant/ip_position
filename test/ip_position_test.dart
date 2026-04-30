import 'package:flutter_test/flutter_test.dart';
import 'package:ip_position/ip_position.dart';

void main() {
  // Test can be written here. Due to network dependencies, we might need to mock http client for unit tests.
  // For now, we just ensure models are instantiated properly.
  test('Instantiate IpDnsInfo', () {
    final dnsInfo = IpDnsInfo(dns: DnsInfo(ip: '1.1.1.1', geo: 'US'), edns: DnsInfo(ip: '8.8.8.8', geo: 'US'));
    expect(dnsInfo.dns?.ip, '1.1.1.1');
  });

  test('Instantiate IpGeolocationInfo', () {
    final geoInfo = IpGeolocationInfo(query: '1.1.1.1', country: 'US');
    expect(geoInfo.query, '1.1.1.1');
    expect(geoInfo.country, 'US');
  });
}
