import 'package:clean_flutterando/modules/search/domain/entities/result_search.dart';
import 'package:clean_flutterando/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_flutterando/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

///Teste unitário
main() {
  final repository = SearchRepositoryMock();

  final useCase = SearchByTextImpl(repository);

  test('Deve retornar uma lista de ResultSearch', () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    final result = await useCase('jacob');

    //Right é o retorno com uma lista, left é o quando é gerada uma exceção.
    //Poderia passar direto para a outra assertion
    expect(result, isA<Right>());

    /// Códigos ambíguos
    /// Expect(result | null, isA<List<ResultSearch>>());
    expect(result.getOrElse(() => null), isA<List<ResultSearch>>());
  });
}
