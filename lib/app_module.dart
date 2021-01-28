import 'package:clean_flutterando/modules/search/presenter/search/search_page.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:clean_flutterando/app_widget.dart';
import 'package:clean_flutterando/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_flutterando/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_flutterando/modules/search/infra/repositories/search_repository_impl.dart';

//Módulo responsável por realizar a injeção de dependências
class AppModule extends MainModule {
  //A injeção de dependências pode ser feita usando o code generation(or)
  //Ou pode ser feita à mão, como segue abaixo.
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => GithubDatasource(i())),
      ];

  ///Rotas nomeadas
  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => SearchPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
