# ip_position

A Flutter package to fetch client IP addresses, DNS information, and precise geolocation data seamlessly. 

It queries reliable endpoints to provide details about the network connection, including continent, country, region, city, ISP, and coordinates.

## Features

- **Fetch DNS Info:** Retrieve both primary DNS and EDNS geographic locations and IP addresses.
- **Fetch Geolocation Info:** Get in-depth network details like country, region, city, zip, timezone, ISP, coordinates (lat/lon), and more.
- Built with Dart `http` and utilizes well-known ip-api.com endpoints.

## Getting started

Add `ip_position` to your `pubspec.yaml` file:

```yaml
dependencies:
  ip_position: ^1.0.0
```

Run `flutter pub get` to install the package.

## Usage

Import the package where needed:

```dart
import 'package:ip_position/ip_position.dart';
```

### Fetch DNS Information

This provides the user's DNS and EDNS routing IPs and locations.

```dart
try {
  IpDnsInfo dnsInfo = await IpPosition.getDnsInfo();
  print('DNS IP: ${dnsInfo.dns?.ip}');
  print('DNS Geo: ${dnsInfo.dns?.geo}');
  print('EDNS IP: ${dnsInfo.edns?.ip}');
  print('EDNS Geo: ${dnsInfo.edns?.geo}');
} catch (e) {
  print('Error fetching DNS info: $e');
}
```

### Fetch Geolocation Information

You can fetch geolocation for the current device's IP (by passing no arguments) or pass a specific IP address to look it up.

```dart
try {
  // Fetch for the current device
  IpGeolocationInfo geoInfo = await IpPosition.getGeolocationInfo();
  
  // Or fetch for a specific IP
  // IpGeolocationInfo geoInfo = await IpPosition.getGeolocationInfo('103.77.1.132');

  print('IP Address: ${geoInfo.query}');
  print('Country: ${geoInfo.country}');
  print('Region: ${geoInfo.regionName}');
  print('City: ${geoInfo.city}');
  print('Coordinates: ${geoInfo.lat}, ${geoInfo.lon}');
  print('ISP: ${geoInfo.isp}');
} catch (e) {
  print('Error fetching Geolocation: $e');
}
```

## Example

Check out the `example` folder for a fully working Flutter app demonstrating how to use this package.

## Additional information

This package relies on [ip-api.com](https://ip-api.com/). Ensure you comply with their terms of service regarding usage limits.
