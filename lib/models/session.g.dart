// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
      name: json['name'] as String? ?? "",
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      mode: $enumDecodeNullable(_$FilterModeEnumMap, json['mode']) ??
          FilterMode.block,
      id: json['id'] as String?,
      lengthInMinutes: json['lengthInMinutes'] as int? ?? 60,
      websites: (json['websites'] as List<dynamic>?)
              ?.map((e) => WebsiteModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startTime': instance.startTime?.toIso8601String(),
      'lengthInMinutes': instance.lengthInMinutes,
      'mode': _$FilterModeEnumMap[instance.mode]!,
      'websites': instance.websites,
    };

const _$FilterModeEnumMap = {
  FilterMode.allow: 'allow',
  FilterMode.block: 'block',
};
