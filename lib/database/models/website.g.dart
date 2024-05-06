// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'website.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Website _$WebsiteFromJson(Map<String, dynamic> json) => Website(
      id: json['id'] as int?,
      name: json['name'] as String? ?? "",
      match: json['match'] as String? ?? "*",
    )..key = json['key'] as String;

Map<String, dynamic> _$WebsiteToJson(Website instance) => <String, dynamic>{
      'key': instance.key,
      'id': instance.id,
      'name': instance.name,
      'match': instance.match,
    };
