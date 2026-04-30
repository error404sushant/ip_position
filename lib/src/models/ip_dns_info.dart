class IpDnsInfo {
  final DnsInfo? dns;
  final DnsInfo? edns;

  IpDnsInfo({this.dns, this.edns});

  factory IpDnsInfo.fromJson(Map<String, dynamic> json) {
    return IpDnsInfo(
      dns: json['dns'] != null ? DnsInfo.fromJson(json['dns']) : null,
      edns: json['edns'] != null ? DnsInfo.fromJson(json['edns']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'dns': dns?.toJson(), 'edns': edns?.toJson()};
  }
}

class DnsInfo {
  final String? geo;
  final String? ip;

  DnsInfo({this.geo, this.ip});

  factory DnsInfo.fromJson(Map<String, dynamic> json) {
    return DnsInfo(geo: json['geo'], ip: json['ip']);
  }

  Map<String, dynamic> toJson() {
    return {'geo': geo, 'ip': ip};
  }
}
