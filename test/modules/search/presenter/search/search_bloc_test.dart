import 'package:clean_flutterando/modules/search/domain/entities/result_search.dart';
import 'package:clean_flutterando/modules/search/domain/errors/errors.dart';
import 'package:clean_flutterando/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_flutterando/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_flutterando/modules/search/presenter/search/states/state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchByTextMoc extends Mock implements SearchByText {}

main() {
  final usecase = SearchByTextMoc();

  final bloc = SearchBloc(usecase);

  test('Deve retornar os estados na ordem correta.', () {
    //Bloc é uma stream e tem uma forma diferente de ser testada.
    //O bloc deve ter um fim aqui no teste, o que ocorre utilizando o timeout.
    when(usecase.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]));

    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchSuccess>(),
        ]));

    bloc.add('jacob');
  });

  test('Deve retornar error.', () {
    //Bloc é uma stream e tem uma forma diferente de ser testada.
    //O bloc deve ter um fim aqui no teste, o que ocorre utilizando o timeout.
    when(usecase.call(any)).thenAnswer((_) async => Left(InvalidTextError()));

    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchError>(),
        ]));

    bloc.add('jacob');
  });
}
