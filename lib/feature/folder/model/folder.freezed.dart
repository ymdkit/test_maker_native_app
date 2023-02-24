// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'folder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Folder {
  String get folderId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  AppThemeColor get color => throw _privateConstructorUsedError;
  int get workbookCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  AppDataLocation get location => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FolderCopyWith<Folder> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FolderCopyWith<$Res> {
  factory $FolderCopyWith(Folder value, $Res Function(Folder) then) =
      _$FolderCopyWithImpl<$Res, Folder>;
  @useResult
  $Res call(
      {String folderId,
      String title,
      int order,
      AppThemeColor color,
      int workbookCount,
      DateTime createdAt,
      DateTime updatedAt,
      AppDataLocation location});
}

/// @nodoc
class _$FolderCopyWithImpl<$Res, $Val extends Folder>
    implements $FolderCopyWith<$Res> {
  _$FolderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? folderId = null,
    Object? title = null,
    Object? order = null,
    Object? color = null,
    Object? workbookCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? location = null,
  }) {
    return _then(_value.copyWith(
      folderId: null == folderId
          ? _value.folderId
          : folderId // ignore: cast_nullable_to_non_nullable
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
              as AppThemeColor,
      workbookCount: null == workbookCount
          ? _value.workbookCount
          : workbookCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AppDataLocation,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FolderCopyWith<$Res> implements $FolderCopyWith<$Res> {
  factory _$$_FolderCopyWith(_$_Folder value, $Res Function(_$_Folder) then) =
      __$$_FolderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String folderId,
      String title,
      int order,
      AppThemeColor color,
      int workbookCount,
      DateTime createdAt,
      DateTime updatedAt,
      AppDataLocation location});
}

/// @nodoc
class __$$_FolderCopyWithImpl<$Res>
    extends _$FolderCopyWithImpl<$Res, _$_Folder>
    implements _$$_FolderCopyWith<$Res> {
  __$$_FolderCopyWithImpl(_$_Folder _value, $Res Function(_$_Folder) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? folderId = null,
    Object? title = null,
    Object? order = null,
    Object? color = null,
    Object? workbookCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? location = null,
  }) {
    return _then(_$_Folder(
      folderId: null == folderId
          ? _value.folderId
          : folderId // ignore: cast_nullable_to_non_nullable
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
              as AppThemeColor,
      workbookCount: null == workbookCount
          ? _value.workbookCount
          : workbookCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AppDataLocation,
    ));
  }
}

/// @nodoc

class _$_Folder extends _Folder {
  const _$_Folder(
      {required this.folderId,
      required this.title,
      required this.order,
      required this.color,
      required this.workbookCount,
      required this.createdAt,
      required this.updatedAt,
      required this.location})
      : super._();

  @override
  final String folderId;
  @override
  final String title;
  @override
  final int order;
  @override
  final AppThemeColor color;
  @override
  final int workbookCount;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final AppDataLocation location;

  @override
  String toString() {
    return 'Folder(folderId: $folderId, title: $title, order: $order, color: $color, workbookCount: $workbookCount, createdAt: $createdAt, updatedAt: $updatedAt, location: $location)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Folder &&
            (identical(other.folderId, folderId) ||
                other.folderId == folderId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.workbookCount, workbookCount) ||
                other.workbookCount == workbookCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, folderId, title, order, color,
      workbookCount, createdAt, updatedAt, location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FolderCopyWith<_$_Folder> get copyWith =>
      __$$_FolderCopyWithImpl<_$_Folder>(this, _$identity);
}

abstract class _Folder extends Folder {
  const factory _Folder(
      {required final String folderId,
      required final String title,
      required final int order,
      required final AppThemeColor color,
      required final int workbookCount,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final AppDataLocation location}) = _$_Folder;
  const _Folder._() : super._();

  @override
  String get folderId;
  @override
  String get title;
  @override
  int get order;
  @override
  AppThemeColor get color;
  @override
  int get workbookCount;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  AppDataLocation get location;
  @override
  @JsonKey(ignore: true)
  _$$_FolderCopyWith<_$_Folder> get copyWith =>
      throw _privateConstructorUsedError;
}
