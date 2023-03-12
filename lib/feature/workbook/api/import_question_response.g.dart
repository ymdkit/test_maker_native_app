// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_question_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportQuestionResponse _$ImportQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    ImportQuestionResponse(
      question: json['question'] as String,
      answer: json['answer'] as String,
      explanation: json['explanation'] as String,
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
      others:
          (json['others'] as List<dynamic>).map((e) => e as String).toList(),
      type: json['type'] as int,
      isAutoGenerateOthers: json['isAutoGenerateOthers'] as bool,
      order: json['order'] as int,
      isCheckOrder: json['isCheckOrder'] as bool,
      imagePath: json['imagePath'] as String,
    );

Map<String, dynamic> _$ImportQuestionResponseToJson(
        ImportQuestionResponse instance) =>
    <String, dynamic>{
      'question': instance.question,
      'answer': instance.answer,
      'explanation': instance.explanation,
      'answers': instance.answers,
      'others': instance.others,
      'type': instance.type,
      'isAutoGenerateOthers': instance.isAutoGenerateOthers,
      'order': instance.order,
      'isCheckOrder': instance.isCheckOrder,
      'imagePath': instance.imagePath,
    };
