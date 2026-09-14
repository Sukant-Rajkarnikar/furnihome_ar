// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RoomDao? _roomDaoInstance;

  CategoryDao? _categoryDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `rooms` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `image` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `categories` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `image` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RoomDao get roomDao {
    return _roomDaoInstance ??= _$RoomDao(database, changeListener);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }
}

class _$RoomDao extends RoomDao {
  _$RoomDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _roomEntityInsertionAdapter = InsertionAdapter(
            database,
            'rooms',
            (RoomEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'image': item.image
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RoomEntity> _roomEntityInsertionAdapter;

  @override
  Future<List<RoomEntity>?> fetchAllRooms() async {
    return _queryAdapter.queryList('select * from rooms',
        mapper: (Map<String, Object?> row) => RoomEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            image: row['image'] as String));
  }

  @override
  Future<int> insert(RoomEntity entity) {
    return _roomEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllData(List<RoomEntity> items) {
    return _roomEntityInsertionAdapter.insertListAndReturnIds(
        items, OnConflictStrategy.replace);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _categoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'categories',
            (CategoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'image': item.image
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CategoryEntity> _categoryEntityInsertionAdapter;

  @override
  Future<List<CategoryEntity>?> fetchAllCategories() async {
    return _queryAdapter.queryList('select * from categories',
        mapper: (Map<String, Object?> row) => CategoryEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            image: row['image'] as String));
  }

  @override
  Future<void> insert(CategoryEntity entity) async {
    await _categoryEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<CategoryEntity> items) async {
    await _categoryEntityInsertionAdapter.insertList(
        items, OnConflictStrategy.replace);
  }
}
