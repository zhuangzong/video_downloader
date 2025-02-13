// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DownloadEntityTable extends DownloadEntity
    with TableInfo<$DownloadEntityTable, DownloadEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DownloadEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _thumbnailMeta =
      const VerificationMeta('thumbnail');
  @override
  late final GeneratedColumn<String> thumbnail = GeneratedColumn<String>(
      'thumbnail', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _progressMeta =
      const VerificationMeta('progress');
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
      'progress', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _totalSizeMeta =
      const VerificationMeta('totalSize');
  @override
  late final GeneratedColumn<String> totalSize = GeneratedColumn<String>(
      'totalSize', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<String> speed = GeneratedColumn<String>(
      'speed', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _etaMeta = const VerificationMeta('eta');
  @override
  late final GeneratedColumn<String> eta = GeneratedColumn<String>(
      'eta', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fragMeta = const VerificationMeta('frag');
  @override
  late final GeneratedColumn<String> frag = GeneratedColumn<String>(
      'frag', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalFragMeta =
      const VerificationMeta('totalFrag');
  @override
  late final GeneratedColumn<String> totalFrag = GeneratedColumn<String>(
      'totalFrag', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'createdAt', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updatedAt', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        thumbnail,
        url,
        status,
        path,
        progress,
        totalSize,
        speed,
        eta,
        frag,
        totalFrag,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'download_entity';
  @override
  VerificationContext validateIntegrity(Insertable<DownloadEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('thumbnail')) {
      context.handle(_thumbnailMeta,
          thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta));
    } else if (isInserting) {
      context.missing(_thumbnailMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress']!, _progressMeta));
    }
    if (data.containsKey('totalSize')) {
      context.handle(_totalSizeMeta,
          totalSize.isAcceptableOrUnknown(data['totalSize']!, _totalSizeMeta));
    }
    if (data.containsKey('speed')) {
      context.handle(
          _speedMeta, speed.isAcceptableOrUnknown(data['speed']!, _speedMeta));
    }
    if (data.containsKey('eta')) {
      context.handle(
          _etaMeta, eta.isAcceptableOrUnknown(data['eta']!, _etaMeta));
    }
    if (data.containsKey('frag')) {
      context.handle(
          _fragMeta, frag.isAcceptableOrUnknown(data['frag']!, _fragMeta));
    }
    if (data.containsKey('totalFrag')) {
      context.handle(_totalFragMeta,
          totalFrag.isAcceptableOrUnknown(data['totalFrag']!, _totalFragMeta));
    }
    if (data.containsKey('createdAt')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['createdAt']!, _createdAtMeta));
    }
    if (data.containsKey('updatedAt')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updatedAt']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DownloadEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DownloadEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      thumbnail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumbnail'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      progress: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}progress']),
      totalSize: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}totalSize']),
      speed: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}speed']),
      eta: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}eta']),
      frag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frag']),
      totalFrag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}totalFrag']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}createdAt']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updatedAt']),
    );
  }

  @override
  $DownloadEntityTable createAlias(String alias) {
    return $DownloadEntityTable(attachedDatabase, alias);
  }
}

class DownloadEntityData extends DataClass
    implements Insertable<DownloadEntityData> {
  final String id;
  final String title;
  final String thumbnail;
  final String url;
  final int status;
  final String path;
  final double? progress;
  final String? totalSize;
  final String? speed;
  final String? eta;
  final String? frag;
  final String? totalFrag;
  final int? createdAt;
  final int? updatedAt;
  const DownloadEntityData(
      {required this.id,
      required this.title,
      required this.thumbnail,
      required this.url,
      required this.status,
      required this.path,
      this.progress,
      this.totalSize,
      this.speed,
      this.eta,
      this.frag,
      this.totalFrag,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['thumbnail'] = Variable<String>(thumbnail);
    map['url'] = Variable<String>(url);
    map['status'] = Variable<int>(status);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || progress != null) {
      map['progress'] = Variable<double>(progress);
    }
    if (!nullToAbsent || totalSize != null) {
      map['totalSize'] = Variable<String>(totalSize);
    }
    if (!nullToAbsent || speed != null) {
      map['speed'] = Variable<String>(speed);
    }
    if (!nullToAbsent || eta != null) {
      map['eta'] = Variable<String>(eta);
    }
    if (!nullToAbsent || frag != null) {
      map['frag'] = Variable<String>(frag);
    }
    if (!nullToAbsent || totalFrag != null) {
      map['totalFrag'] = Variable<String>(totalFrag);
    }
    if (!nullToAbsent || createdAt != null) {
      map['createdAt'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updatedAt'] = Variable<int>(updatedAt);
    }
    return map;
  }

  DownloadEntityCompanion toCompanion(bool nullToAbsent) {
    return DownloadEntityCompanion(
      id: Value(id),
      title: Value(title),
      thumbnail: Value(thumbnail),
      url: Value(url),
      status: Value(status),
      path: Value(path),
      progress: progress == null && nullToAbsent
          ? const Value.absent()
          : Value(progress),
      totalSize: totalSize == null && nullToAbsent
          ? const Value.absent()
          : Value(totalSize),
      speed:
          speed == null && nullToAbsent ? const Value.absent() : Value(speed),
      eta: eta == null && nullToAbsent ? const Value.absent() : Value(eta),
      frag: frag == null && nullToAbsent ? const Value.absent() : Value(frag),
      totalFrag: totalFrag == null && nullToAbsent
          ? const Value.absent()
          : Value(totalFrag),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory DownloadEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DownloadEntityData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      thumbnail: serializer.fromJson<String>(json['thumbnail']),
      url: serializer.fromJson<String>(json['url']),
      status: serializer.fromJson<int>(json['status']),
      path: serializer.fromJson<String>(json['path']),
      progress: serializer.fromJson<double?>(json['progress']),
      totalSize: serializer.fromJson<String?>(json['totalSize']),
      speed: serializer.fromJson<String?>(json['speed']),
      eta: serializer.fromJson<String?>(json['eta']),
      frag: serializer.fromJson<String?>(json['frag']),
      totalFrag: serializer.fromJson<String?>(json['totalFrag']),
      createdAt: serializer.fromJson<int?>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'thumbnail': serializer.toJson<String>(thumbnail),
      'url': serializer.toJson<String>(url),
      'status': serializer.toJson<int>(status),
      'path': serializer.toJson<String>(path),
      'progress': serializer.toJson<double?>(progress),
      'totalSize': serializer.toJson<String?>(totalSize),
      'speed': serializer.toJson<String?>(speed),
      'eta': serializer.toJson<String?>(eta),
      'frag': serializer.toJson<String?>(frag),
      'totalFrag': serializer.toJson<String?>(totalFrag),
      'createdAt': serializer.toJson<int?>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  DownloadEntityData copyWith(
          {String? id,
          String? title,
          String? thumbnail,
          String? url,
          int? status,
          String? path,
          Value<double?> progress = const Value.absent(),
          Value<String?> totalSize = const Value.absent(),
          Value<String?> speed = const Value.absent(),
          Value<String?> eta = const Value.absent(),
          Value<String?> frag = const Value.absent(),
          Value<String?> totalFrag = const Value.absent(),
          Value<int?> createdAt = const Value.absent(),
          Value<int?> updatedAt = const Value.absent()}) =>
      DownloadEntityData(
        id: id ?? this.id,
        title: title ?? this.title,
        thumbnail: thumbnail ?? this.thumbnail,
        url: url ?? this.url,
        status: status ?? this.status,
        path: path ?? this.path,
        progress: progress.present ? progress.value : this.progress,
        totalSize: totalSize.present ? totalSize.value : this.totalSize,
        speed: speed.present ? speed.value : this.speed,
        eta: eta.present ? eta.value : this.eta,
        frag: frag.present ? frag.value : this.frag,
        totalFrag: totalFrag.present ? totalFrag.value : this.totalFrag,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  DownloadEntityData copyWithCompanion(DownloadEntityCompanion data) {
    return DownloadEntityData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      thumbnail: data.thumbnail.present ? data.thumbnail.value : this.thumbnail,
      url: data.url.present ? data.url.value : this.url,
      status: data.status.present ? data.status.value : this.status,
      path: data.path.present ? data.path.value : this.path,
      progress: data.progress.present ? data.progress.value : this.progress,
      totalSize: data.totalSize.present ? data.totalSize.value : this.totalSize,
      speed: data.speed.present ? data.speed.value : this.speed,
      eta: data.eta.present ? data.eta.value : this.eta,
      frag: data.frag.present ? data.frag.value : this.frag,
      totalFrag: data.totalFrag.present ? data.totalFrag.value : this.totalFrag,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DownloadEntityData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('url: $url, ')
          ..write('status: $status, ')
          ..write('path: $path, ')
          ..write('progress: $progress, ')
          ..write('totalSize: $totalSize, ')
          ..write('speed: $speed, ')
          ..write('eta: $eta, ')
          ..write('frag: $frag, ')
          ..write('totalFrag: $totalFrag, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, thumbnail, url, status, path,
      progress, totalSize, speed, eta, frag, totalFrag, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadEntityData &&
          other.id == this.id &&
          other.title == this.title &&
          other.thumbnail == this.thumbnail &&
          other.url == this.url &&
          other.status == this.status &&
          other.path == this.path &&
          other.progress == this.progress &&
          other.totalSize == this.totalSize &&
          other.speed == this.speed &&
          other.eta == this.eta &&
          other.frag == this.frag &&
          other.totalFrag == this.totalFrag &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DownloadEntityCompanion extends UpdateCompanion<DownloadEntityData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> thumbnail;
  final Value<String> url;
  final Value<int> status;
  final Value<String> path;
  final Value<double?> progress;
  final Value<String?> totalSize;
  final Value<String?> speed;
  final Value<String?> eta;
  final Value<String?> frag;
  final Value<String?> totalFrag;
  final Value<int?> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const DownloadEntityCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.url = const Value.absent(),
    this.status = const Value.absent(),
    this.path = const Value.absent(),
    this.progress = const Value.absent(),
    this.totalSize = const Value.absent(),
    this.speed = const Value.absent(),
    this.eta = const Value.absent(),
    this.frag = const Value.absent(),
    this.totalFrag = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DownloadEntityCompanion.insert({
    required String id,
    required String title,
    required String thumbnail,
    required String url,
    required int status,
    required String path,
    this.progress = const Value.absent(),
    this.totalSize = const Value.absent(),
    this.speed = const Value.absent(),
    this.eta = const Value.absent(),
    this.frag = const Value.absent(),
    this.totalFrag = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        thumbnail = Value(thumbnail),
        url = Value(url),
        status = Value(status),
        path = Value(path);
  static Insertable<DownloadEntityData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? thumbnail,
    Expression<String>? url,
    Expression<int>? status,
    Expression<String>? path,
    Expression<double>? progress,
    Expression<String>? totalSize,
    Expression<String>? speed,
    Expression<String>? eta,
    Expression<String>? frag,
    Expression<String>? totalFrag,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (url != null) 'url': url,
      if (status != null) 'status': status,
      if (path != null) 'path': path,
      if (progress != null) 'progress': progress,
      if (totalSize != null) 'totalSize': totalSize,
      if (speed != null) 'speed': speed,
      if (eta != null) 'eta': eta,
      if (frag != null) 'frag': frag,
      if (totalFrag != null) 'totalFrag': totalFrag,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DownloadEntityCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? thumbnail,
      Value<String>? url,
      Value<int>? status,
      Value<String>? path,
      Value<double?>? progress,
      Value<String?>? totalSize,
      Value<String?>? speed,
      Value<String?>? eta,
      Value<String?>? frag,
      Value<String?>? totalFrag,
      Value<int?>? createdAt,
      Value<int?>? updatedAt,
      Value<int>? rowid}) {
    return DownloadEntityCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      url: url ?? this.url,
      status: status ?? this.status,
      path: path ?? this.path,
      progress: progress ?? this.progress,
      totalSize: totalSize ?? this.totalSize,
      speed: speed ?? this.speed,
      eta: eta ?? this.eta,
      frag: frag ?? this.frag,
      totalFrag: totalFrag ?? this.totalFrag,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String>(thumbnail.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (totalSize.present) {
      map['totalSize'] = Variable<String>(totalSize.value);
    }
    if (speed.present) {
      map['speed'] = Variable<String>(speed.value);
    }
    if (eta.present) {
      map['eta'] = Variable<String>(eta.value);
    }
    if (frag.present) {
      map['frag'] = Variable<String>(frag.value);
    }
    if (totalFrag.present) {
      map['totalFrag'] = Variable<String>(totalFrag.value);
    }
    if (createdAt.present) {
      map['createdAt'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updatedAt'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadEntityCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('url: $url, ')
          ..write('status: $status, ')
          ..write('path: $path, ')
          ..write('progress: $progress, ')
          ..write('totalSize: $totalSize, ')
          ..write('speed: $speed, ')
          ..write('eta: $eta, ')
          ..write('frag: $frag, ')
          ..write('totalFrag: $totalFrag, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DownloadEntityTable downloadEntity = $DownloadEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [downloadEntity];
}

typedef $$DownloadEntityTableCreateCompanionBuilder = DownloadEntityCompanion
    Function({
  required String id,
  required String title,
  required String thumbnail,
  required String url,
  required int status,
  required String path,
  Value<double?> progress,
  Value<String?> totalSize,
  Value<String?> speed,
  Value<String?> eta,
  Value<String?> frag,
  Value<String?> totalFrag,
  Value<int?> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});
typedef $$DownloadEntityTableUpdateCompanionBuilder = DownloadEntityCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String> thumbnail,
  Value<String> url,
  Value<int> status,
  Value<String> path,
  Value<double?> progress,
  Value<String?> totalSize,
  Value<String?> speed,
  Value<String?> eta,
  Value<String?> frag,
  Value<String?> totalFrag,
  Value<int?> createdAt,
  Value<int?> updatedAt,
  Value<int> rowid,
});

class $$DownloadEntityTableFilterComposer
    extends Composer<_$AppDatabase, $DownloadEntityTable> {
  $$DownloadEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get thumbnail => $composableBuilder(
      column: $table.thumbnail, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get totalSize => $composableBuilder(
      column: $table.totalSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get speed => $composableBuilder(
      column: $table.speed, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eta => $composableBuilder(
      column: $table.eta, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frag => $composableBuilder(
      column: $table.frag, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get totalFrag => $composableBuilder(
      column: $table.totalFrag, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$DownloadEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $DownloadEntityTable> {
  $$DownloadEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get thumbnail => $composableBuilder(
      column: $table.thumbnail, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get totalSize => $composableBuilder(
      column: $table.totalSize, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get speed => $composableBuilder(
      column: $table.speed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eta => $composableBuilder(
      column: $table.eta, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frag => $composableBuilder(
      column: $table.frag, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get totalFrag => $composableBuilder(
      column: $table.totalFrag, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$DownloadEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $DownloadEntityTable> {
  $$DownloadEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get thumbnail =>
      $composableBuilder(column: $table.thumbnail, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<String> get totalSize =>
      $composableBuilder(column: $table.totalSize, builder: (column) => column);

  GeneratedColumn<String> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumn<String> get eta =>
      $composableBuilder(column: $table.eta, builder: (column) => column);

  GeneratedColumn<String> get frag =>
      $composableBuilder(column: $table.frag, builder: (column) => column);

  GeneratedColumn<String> get totalFrag =>
      $composableBuilder(column: $table.totalFrag, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DownloadEntityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DownloadEntityTable,
    DownloadEntityData,
    $$DownloadEntityTableFilterComposer,
    $$DownloadEntityTableOrderingComposer,
    $$DownloadEntityTableAnnotationComposer,
    $$DownloadEntityTableCreateCompanionBuilder,
    $$DownloadEntityTableUpdateCompanionBuilder,
    (
      DownloadEntityData,
      BaseReferences<_$AppDatabase, $DownloadEntityTable, DownloadEntityData>
    ),
    DownloadEntityData,
    PrefetchHooks Function()> {
  $$DownloadEntityTableTableManager(
      _$AppDatabase db, $DownloadEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DownloadEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DownloadEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DownloadEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> thumbnail = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<int> status = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<double?> progress = const Value.absent(),
            Value<String?> totalSize = const Value.absent(),
            Value<String?> speed = const Value.absent(),
            Value<String?> eta = const Value.absent(),
            Value<String?> frag = const Value.absent(),
            Value<String?> totalFrag = const Value.absent(),
            Value<int?> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DownloadEntityCompanion(
            id: id,
            title: title,
            thumbnail: thumbnail,
            url: url,
            status: status,
            path: path,
            progress: progress,
            totalSize: totalSize,
            speed: speed,
            eta: eta,
            frag: frag,
            totalFrag: totalFrag,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String thumbnail,
            required String url,
            required int status,
            required String path,
            Value<double?> progress = const Value.absent(),
            Value<String?> totalSize = const Value.absent(),
            Value<String?> speed = const Value.absent(),
            Value<String?> eta = const Value.absent(),
            Value<String?> frag = const Value.absent(),
            Value<String?> totalFrag = const Value.absent(),
            Value<int?> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DownloadEntityCompanion.insert(
            id: id,
            title: title,
            thumbnail: thumbnail,
            url: url,
            status: status,
            path: path,
            progress: progress,
            totalSize: totalSize,
            speed: speed,
            eta: eta,
            frag: frag,
            totalFrag: totalFrag,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DownloadEntityTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DownloadEntityTable,
    DownloadEntityData,
    $$DownloadEntityTableFilterComposer,
    $$DownloadEntityTableOrderingComposer,
    $$DownloadEntityTableAnnotationComposer,
    $$DownloadEntityTableCreateCompanionBuilder,
    $$DownloadEntityTableUpdateCompanionBuilder,
    (
      DownloadEntityData,
      BaseReferences<_$AppDatabase, $DownloadEntityTable, DownloadEntityData>
    ),
    DownloadEntityData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DownloadEntityTableTableManager get downloadEntity =>
      $$DownloadEntityTableTableManager(_db, _db.downloadEntity);
}
