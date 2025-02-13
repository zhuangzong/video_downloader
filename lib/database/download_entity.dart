import 'package:drift/drift.dart';

class DownloadEntity extends Table {

  TextColumn get id => text().named('id')();

  TextColumn get title => text().named('title')();

  TextColumn get thumbnail => text().named('thumbnail')();

  TextColumn get url => text().unique().named('url')();

  IntColumn get status => integer().named('status')();

  TextColumn get path => text().named('path')();

  RealColumn get progress => real().nullable().named('progress')();

  TextColumn get totalSize => text().nullable().named('totalSize')();

  TextColumn get speed => text().nullable().named('speed')();

  TextColumn get eta => text().nullable().named('eta')();

  TextColumn get frag => text().nullable().named('frag')();

  TextColumn get totalFrag => text().nullable().named('totalFrag')();

  IntColumn get createdAt => integer().nullable().named('createdAt')();

  IntColumn get updatedAt => integer().nullable().named('updatedAt')();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
