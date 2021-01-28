import 'dart:convert';

import 'package:clean_flutterando/modules/search/domain/errors/errors.dart';
import 'package:clean_flutterando/modules/search/external/datasources/github_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  //A gente não pode ficar acessando a internet para ficar testando as coisas.
  //Temos que mockar para não sobrecarregar o servidor CI/CD, então realize testes offline.
  final dio = DioMock();

  final datasource = GithubDatasource(dio);
  test('Deve retornar uma lista de ResultSearchModel', () async {
    when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final future = datasource.getSearch('searchText');

    //Utiliza o completes, pois não quer comparar o resultado
    //Se a future completar, então o resultado está correto.
    expect(future, completes);
  });

  test('Deve retornar um erro se o código não for 200', () async {
    when(dio.get(any))
        .thenAnswer((_) async => Response(data: null, statusCode: 401));

    final future = datasource.getSearch('searchText');

    expect(future, throwsA(isA<DataSourceError>()));
  });

  test('Deve retornar uma Exception se ocorrer erro no Dio', () async {
    when(dio.get(any)).thenThrow(Exception());

    final future = datasource.getSearch('searchText');

    expect(future, throwsA(isA<Exception>()));
  });
}
