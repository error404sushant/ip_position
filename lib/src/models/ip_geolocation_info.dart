class IpGeolocationInfo {
  final String? status;
  final String? continent;
  final String? continentCode;
  final String? country;
  final String? countryCode;
  final String? region;
  final String? regionName;
  final String? city;
  final String? district;
  final String? zip;
  final double? lat;
  final double? lon;
  final String? timezone;
  final int? offset;
  final String? currency;
  final String? isp;
  final String? org;
  final String? asString;
  final String? asname;
  final bool? mobile;
  final bool? proxy;
  final bool? hosting;
  final String? query;

  IpGeolocationInfo({
    this.status,
    this.continent,
    this.continentCode,
    this.country,
    this.countryCode,
    this.region,
    this.regionName,
    this.city,
    this.district,
    this.zip,
    this.lat,
    this.lon,
    this.timezone,
    this.offset,
    this.currency,
    this.isp,
    this.org,
    this.asString,
    this.asname,
    this.mobile,
    this.proxy,
    this.hosting,
    this.query,
  });

  factory IpGeolocationInfo.fromJson(Map<String, dynamic> json) {
    return IpGeolocationInfo(
      status: json['status'],
      continent: json['continent'],
      continentCode: json['continentCode'],
      country: json['country'],
      countryCode: json['countryCode'],
      region: json['region'],
      regionName: json['regionName'],
      city: json['city'],
      district: json['district'],
      zip: json['zip'],
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      timezone: json['timezone'],
      offset: json['offset'],
      currency: json['currency'],
      isp: json['isp'],
      org: json['org'],
      asString: json['as'],
      asname: json['asname'],
      mobile: json['mobile'],
      proxy: json['proxy'],
      hosting: json['hosting'],
      query: json['query'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'continent': continent,
      'continentCode': continentCode,
      'country': country,
      'countryCode': countryCode,
      'region': region,
      'regionName': regionName,
      'city': city,
      'district': district,
      'zip': zip,
      'lat': lat,
      'lon': lon,
      'timezone': timezone,
      'offset': offset,
      'currency': currency,
      'isp': isp,
      'org': org,
      'as': asString,
      'asname': asname,
      'mobile': mobile,
      'proxy': proxy,
      'hosting': hosting,
      'query': query,
    };
  }
}
