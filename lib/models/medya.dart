// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Medya {
  String url;
  String ref;
  Medya({
    required this.url,
    required this.ref,
  });
  

  Medya copyWith({
    String? url,
    String? ref,
  }) {
    return Medya(
      url: url ?? this.url,
      ref: ref ?? this.ref,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'ref': ref,
    };
  }

  factory Medya.fromMap(Map<String, dynamic> map) {
    return Medya(
      url: map['url'] as String,
      ref: map['ref'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Medya.fromJson(String source) => Medya.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Medya(url: $url, ref: $ref)';

  @override
  bool operator ==(covariant Medya other) {
    if (identical(this, other)) return true;
  
    return 
      other.url == url &&
      other.ref == ref;
  }

  @override
  int get hashCode => url.hashCode ^ ref.hashCode;
}
