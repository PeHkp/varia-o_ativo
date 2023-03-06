import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:variacao_ativo/pages/grafic_page/grafic_page.dart';
import 'package:variacao_ativo/pages/home_page/bloc/home_bloc.dart';
import 'package:variacao_ativo/pages/home_page/home_page.dart';
import 'package:variacao_ativo/services/consult_value/consult_value_service.dart';

class Routes {
  Routes._();

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  static const String home = "/home";
  static const String grafic = "/grafic";

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => BlocProvider(
          create: (_) =>
              HomePageBloc(consultValueService: ConsultValueService.instance),
          child: HomePage(),
        ),
    grafic: (context) => GraficPage(),
  };
}
