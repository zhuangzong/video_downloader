// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  List<DownloadEntityData> get downloadList =>
      throw _privateConstructorUsedError;
  List<DownloadEntityData> get downloadedList =>
      throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  int get selectedIndex => throw _privateConstructorUsedError;
  bool get expanded => throw _privateConstructorUsedError;
  bool get filter => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {List<DownloadEntityData> downloadList,
      List<DownloadEntityData> downloadedList,
      String version,
      int selectedIndex,
      bool expanded,
      bool filter});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadList = null,
    Object? downloadedList = null,
    Object? version = null,
    Object? selectedIndex = null,
    Object? expanded = null,
    Object? filter = null,
  }) {
    return _then(_value.copyWith(
      downloadList: null == downloadList
          ? _value.downloadList
          : downloadList // ignore: cast_nullable_to_non_nullable
              as List<DownloadEntityData>,
      downloadedList: null == downloadedList
          ? _value.downloadedList
          : downloadedList // ignore: cast_nullable_to_non_nullable
              as List<DownloadEntityData>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<DownloadEntityData> downloadList,
      List<DownloadEntityData> downloadedList,
      String version,
      int selectedIndex,
      bool expanded,
      bool filter});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadList = null,
    Object? downloadedList = null,
    Object? version = null,
    Object? selectedIndex = null,
    Object? expanded = null,
    Object? filter = null,
  }) {
    return _then(_$HomeStateImpl(
      downloadList: null == downloadList
          ? _value._downloadList
          : downloadList // ignore: cast_nullable_to_non_nullable
              as List<DownloadEntityData>,
      downloadedList: null == downloadedList
          ? _value._downloadedList
          : downloadedList // ignore: cast_nullable_to_non_nullable
              as List<DownloadEntityData>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl(
      {required final List<DownloadEntityData> downloadList,
      required final List<DownloadEntityData> downloadedList,
      required this.version,
      required this.selectedIndex,
      required this.expanded,
      required this.filter})
      : _downloadList = downloadList,
        _downloadedList = downloadedList;

  final List<DownloadEntityData> _downloadList;
  @override
  List<DownloadEntityData> get downloadList {
    if (_downloadList is EqualUnmodifiableListView) return _downloadList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_downloadList);
  }

  final List<DownloadEntityData> _downloadedList;
  @override
  List<DownloadEntityData> get downloadedList {
    if (_downloadedList is EqualUnmodifiableListView) return _downloadedList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_downloadedList);
  }

  @override
  final String version;
  @override
  final int selectedIndex;
  @override
  final bool expanded;
  @override
  final bool filter;

  @override
  String toString() {
    return 'HomeState(downloadList: $downloadList, downloadedList: $downloadedList, version: $version, selectedIndex: $selectedIndex, expanded: $expanded, filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            const DeepCollectionEquality()
                .equals(other._downloadList, _downloadList) &&
            const DeepCollectionEquality()
                .equals(other._downloadedList, _downloadedList) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex) &&
            (identical(other.expanded, expanded) ||
                other.expanded == expanded) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_downloadList),
      const DeepCollectionEquality().hash(_downloadedList),
      version,
      selectedIndex,
      expanded,
      filter);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {required final List<DownloadEntityData> downloadList,
      required final List<DownloadEntityData> downloadedList,
      required final String version,
      required final int selectedIndex,
      required final bool expanded,
      required final bool filter}) = _$HomeStateImpl;

  @override
  List<DownloadEntityData> get downloadList;
  @override
  List<DownloadEntityData> get downloadedList;
  @override
  String get version;
  @override
  int get selectedIndex;
  @override
  bool get expanded;
  @override
  bool get filter;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
