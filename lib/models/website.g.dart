// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'website.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebsiteModel _$WebsiteModelFromJson(Map<String, dynamic> json) => WebsiteModel(
      id: json['id'] as int?,
      name: json['name'] as String? ?? "",
      match: json['match'] as String? ?? "*",
    );

Map<String, dynamic> _$WebsiteModelToJson(WebsiteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'match': instance.match,
    };
