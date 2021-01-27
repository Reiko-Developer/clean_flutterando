import 'package:clean_flutterando/modules/search/domain/entities/result_search.dart';
import 'package:clean_flutterando/modules/search/domain/errors/errors.dart';
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
    //caminho feliz do mockito: thenAnswer()...
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    //The same as: final result = await useCase.call('Jacob');
    final result = await useCase('jacob');

    //Right é o retorno com uma lista, left é o quando é gerada uma exceção.
    //Poderia passar direto para a outra assertion
    expect(result, isA<Right>());

    /// Códigos ambíguos
    /// Expect(result | null, isA<List<ResultSearch>>());
    expect(result.getOrElse(() => null), isA<List<ResultSearch>>());
  });

  test('Deve retornar um InvalidTextError caso o texto seja inválido',
      () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    var result = await useCase(null);

    //Ambiguous code
    //expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await useCase('');

    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
