import 'package:clean_flutterando/modules/search/domain/entities/result_search.dart';
import 'package:clean_flutterando/modules/search/domain/errors/errors.dart';

import 'package:clean_flutterando/modules/search/infra/datasources/search_datasource.dart';
import 'package:clean_flutterando/modules/search/infra/models/result_search_model.dart';
import 'package:clean_flutterando/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

class SearchDatasourceMock extends Mock implements SearchDataSource {}

main() {
  final datasource = SearchDatasourceMock();

  final repository = SearchRepositoryImpl(datasource);

  test('Deve retornar uma lista de ResultSearch', () async {
    when(datasource.getSearch(any))
        .thenAnswer((_) async => <ResultSearchModel>[]);

    final result = await repository.search('jacob');

    expect(result | null, isA<List<ResultSearch>>());
  });

  test('Deve retornar um erro se o datasource falhar', () async {
    when(datasource.getSearch(any)).thenThrow(Exception());

    final result = await repository.search('jacob');

    expect(result.fold(id, id), isA<DataSourceError>());
  });
}
