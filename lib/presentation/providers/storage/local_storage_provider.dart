import 'package:cinema_movie_new/infrastructure/datasources/isar_datasource.dart';
import 'package:cinema_movie_new/infrastructure/repositories/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});
