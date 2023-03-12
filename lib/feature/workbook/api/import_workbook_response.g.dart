// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_workbook_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportWorkbookResponse _$ImportWorkbookResponseFromJson(
        Map<String, dynamic> json) =>
    ImportWorkbookResponse(
      title: json['title'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map(
              (e) => ImportQuestionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImportWorkbookResponseToJson(
        ImportWorkbookResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'questions': instance.questions,
    };
