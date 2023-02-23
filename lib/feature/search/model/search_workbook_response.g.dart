// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_workbook_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchWorkbookResponse _$SearchWorkbookResponseFromJson(
        Map<String, dynamic> json) =>
    SearchWorkbookResponse(
      documentId: json['document_id'] as String,
      name: json['name'] as String,
      color: json['color'] as int,
      size: json['size'] as int,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      createdAt: const EpochDateTimeConverter()
          .fromJson(json['created_at'] as Map<String, dynamic>),
      updatedAt: const EpochDateTimeConverter()
          .fromJson(json['updated_at'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchWorkbookResponseToJson(
        SearchWorkbookResponse instance) =>
    <String, dynamic>{
      'document_id': instance.documentId,
      'name': instance.name,
      'color': instance.color,
      'size': instance.size,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'created_at': const EpochDateTimeConverter().toJson(instance.createdAt),
      'updated_at': const EpochDateTimeConverter().toJson(instance.updatedAt),
    };
