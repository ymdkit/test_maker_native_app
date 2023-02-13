// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workbook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Workbook {
  String get workbookId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  ColorTheme get color => throw _privateConstructorUsedError;
  String? get folderId => throw _privateConstructorUsedError;
  int get questionCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WorkbookCopyWith<Workbook> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkbookCopyWith<$Res> {
  factory $WorkbookCopyWith(Workbook value, $Res Function(Workbook) then) =
      _$WorkbookCopyWithImpl<$Res, Workbook>;
  @useResult
  $Res call(
      {String workbookId,
      String title,
      int order,
      ColorTheme color,
      String? folderId,
      int questionCount});
}

/// @nodoc
class _$WorkbookCopyWithImpl<$Res, $Val extends Workbook>
    implements $WorkbookCopyWith<$Res> {
  _$WorkbookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workbookId = null,
    Object? title = null,
    Object? order = null,
    Object? color = null,
    Object? folderId = freezed,
    Object? questionCount = null,
  }) {
    return _then(_value.copyWith(
      workbookId: null == workbookId
          ? _value.workbookId
          : workbookId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as ColorTheme,
      folderId: freezed == folderId
          ? _value.folderId
          : folderId // ignore: cast_nullable_to_non_nullable
              as String?,
      questionCount: null == questionCount
          ? _value.questionCount
          : questionCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WorkbookCopyWith<$Res> implements $WorkbookCopyWith<$Res> {
  factory _$$_WorkbookCopyWith(
          _$_Workbook value, $Res Function(_$_Workbook) then) =
      __$$_WorkbookCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String workbookId,
      String title,
      int order,
      ColorTheme color,
      String? folderId,
      int questionCount});
}

/// @nodoc
class __$$_WorkbookCopyWithImpl<$Res>
    extends _$WorkbookCopyWithImpl<$Res, _$_Workbook>
    implements _$$_WorkbookCopyWith<$Res> {
  __$$_WorkbookCopyWithImpl(
      _$_Workbook _value, $Res Function(_$_Workbook) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workbookId = null,
    Object? title = null,
    Object? order = null,
    Object? color = null,
    Object? folderId = freezed,
    Object? questionCount = null,
  }) {
    return _then(_$_Workbook(
      workbookId: null == workbookId
          ? _value.workbookId
          : workbookId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as ColorTheme,
      folderId: freezed == folderId
          ? _value.folderId
          : folderId // ignore: cast_nullable_to_non_nullable
              as String?,
      questionCount: null == questionCount
          ? _value.questionCount
          : questionCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Workbook implements _Workbook {
  const _$_Workbook(
      {required this.workbookId,
      required this.title,
      required this.order,
      required this.color,
      required this.folderId,
      required this.questionCount});

  @override
  final String workbookId;
  @override
  final String title;
  @override
  final int order;
  @override
  final ColorTheme color;
  @override
  final String? folderId;
  @override
  final int questionCount;

  @override
  String toString() {
    return 'Workbook(workbookId: $workbookId, title: $title, order: $order, color: $color, folderId: $folderId, questionCount: $questionCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Workbook &&
            (identical(other.workbookId, workbookId) ||
                other.workbookId == workbookId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.folderId, folderId) ||
                other.folderId == folderId) &&
            (identical(other.questionCount, questionCount) ||
                other.questionCount == questionCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, workbookId, title, order, color, folderId, questionCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WorkbookCopyWith<_$_Workbook> get copyWith =>
      __$$_WorkbookCopyWithImpl<_$_Workbook>(this, _$identity);
}

abstract class _Workbook implements Workbook {
  const factory _Workbook(
      {required final String workbookId,
      required final String title,
      required final int order,
      required final ColorTheme color,
      required final String? folderId,
      required final int questionCount}) = _$_Workbook;

  @override
  String get workbookId;
  @override
  String get title;
  @override
  int get order;
  @override
  ColorTheme get color;
  @override
  String? get folderId;
  @override
  int get questionCount;
  @override
  @JsonKey(ignore: true)
  _$$_WorkbookCopyWith<_$_Workbook> get copyWith =>
      throw _privateConstructorUsedError;
}
