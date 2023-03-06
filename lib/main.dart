import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:variacao_ativo/config/config.dart';
import 'package:variacao_ativo/routes.dart';
import 'package:variacao_ativo/services/consult_value/consult_value_repository.dart';
import 'package:variacao_ativo/services/consult_value/consult_value_service.dart';

void main() async {
  Dio dioConfig = Dio(BaseOptions(
    baseUrl: Config.URL,
  ));

  ConsultValueRepository consultValueRepository =
      ConsultValueRepository(dio: dioConfig);

  ConsultValueService(repository: consultValueRepository);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Variação dos Ativos',
      routes: Routes.routes,
      initialRoute: Routes.home,
    );
  }
}
