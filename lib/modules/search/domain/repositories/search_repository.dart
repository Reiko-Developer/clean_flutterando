import 'package:clean_flutterando/modules/search/domain/entities/result_search.dart';
import 'package:clean_flutterando/modules/search/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText);
}
