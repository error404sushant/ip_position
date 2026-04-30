import 'package:flutter/material.dart';
import 'package:ip_position/ip_position.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IP Position Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const IpPositionExampleScreen(),
    );
  }
}

class IpPositionExampleScreen extends StatefulWidget {
  const IpPositionExampleScreen({super.key});

  @override
  State<IpPositionExampleScreen> createState() =>
      _IpPositionExampleScreenState();
}

class _IpPositionExampleScreenState extends State<IpPositionExampleScreen> {
  IpDnsInfo? _dnsInfo;
  IpGeolocationInfo? _geolocationInfo;
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // 1. Fetch DNS Info
      final dnsInfo = await IpPosition.getDnsInfo();
      setState(() {
        _dnsInfo = dnsInfo;
      });

      // 2. Fetch Geolocation Info using the IP from DNS info (or caller IP)
      // If dnsInfo.dns?.ip is available, you can pass it to getGeolocationInfo(ip)
      // Wait, the API `getGeolocationInfo` returns caller info if called without param
      // We will use the caller IP by leaving it empty or passing null
      final String? ipToLookup = dnsInfo.dns?.ip ?? dnsInfo.edns?.ip;
      final geoInfo = await IpPosition.getGeolocationInfo(ipToLookup);

      setState(() {
        _geolocationInfo = geoInfo;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IP Position Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (_error != null)
                      Text(
                        'Error: $_error',
                        style: const TextStyle(color: Colors.red),
                      ),
                    if (_dnsInfo == null &&
                        _geolocationInfo == null &&
                        _error == null)
                      const Text(
                        'Press the button to fetch IP and Location data.',
                        textAlign: TextAlign.center,
                      ),
                    if (_dnsInfo != null) ...[
                      const Text(
                        'DNS Info',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('DNS IP: ${_dnsInfo!.dns?.ip ?? 'N/A'}'),
                      Text('DNS Geo: ${_dnsInfo!.dns?.geo ?? 'N/A'}'),
                      const SizedBox(height: 8),
                      Text('EDNS IP: ${_dnsInfo!.edns?.ip ?? 'N/A'}'),
                      Text('EDNS Geo: ${_dnsInfo!.edns?.geo ?? 'N/A'}'),
                      const Divider(height: 32),
                    ],
                    if (_geolocationInfo != null) ...[
                      const Text(
                        'Geolocation Info',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Query IP: ${_geolocationInfo!.query ?? 'N/A'}'),
                      Text(
                        'Country: ${_geolocationInfo!.country ?? 'N/A'} (${_geolocationInfo!.countryCode ?? ''})',
                      ),
                      Text(
                        'Region: ${_geolocationInfo!.regionName ?? 'N/A'} (${_geolocationInfo!.region ?? ''})',
                      ),
                      Text('City: ${_geolocationInfo!.city ?? 'N/A'}'),
                      Text('Zip: ${_geolocationInfo!.zip ?? 'N/A'}'),
                      Text('Timezone: ${_geolocationInfo!.timezone ?? 'N/A'}'),
                      Text('ISP: ${_geolocationInfo!.isp ?? 'N/A'}'),
                      Text(
                        'Coordinates: ${_geolocationInfo!.lat ?? 'N/A'}, ${_geolocationInfo!.lon ?? 'N/A'}',
                      ),
                    ],
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLoading ? null : _fetchData,
        tooltip: 'Fetch Data',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
