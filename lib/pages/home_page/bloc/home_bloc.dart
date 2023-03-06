import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:variacao_ativo/pages/home_page/bloc/home_event.dart';
import 'package:variacao_ativo/pages/home_page/bloc/home_state.dart';
import 'package:variacao_ativo/services/consult_value/consult_value_response.dart';
import 'package:variacao_ativo/services/consult_value/consult_value_service.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final ConsultValueService consultValueService;

  HomePageBloc({required this.consultValueService})
      : super(LoadingHomePageState()) {
    on<LoadingHomePageEvent>((event, emit) => loadHomePage(event, emit));
    on<ChangeActionEvent>((event, emit) => changeAction(event, emit));
  }

  void loadHomePage(
      LoadingHomePageEvent event, Emitter<HomePageState> emit) async {
    try {
      double maiorValor = 0.0;
      double menorValor = 100.0;

      List<DaysProperty> listDays =
          await consultValueService.getDaysValue(action: event.action);

      if (listDays.last.open == 0.0) {
        listDays.removeLast();
      }

      for (var element in listDays) {
        if (element.open! > maiorValor) {
          maiorValor = element.open!;
        }

        if (element.open! < menorValor) {
          menorValor = element.open!;
        }
      }

      emit(
        HomePageState(
            action: event.action,
            listDays: listDays.reversed.toList(),
            highValue: maiorValor.roundToDouble(),
            lowValue: menorValor.roundToDouble()),
      );
    } catch (e) {
      emit(ErrorPageState(message: e.toString()));
    }
  }

  void changeAction(
      ChangeActionEvent event, Emitter<HomePageState> emit) async {
    try {
      emit(LoadingNewActionHomePageState(
          action: event.action,
          listDays: state.listDays,
          highValue: state.highValue,
          lowValue: state.lowValue));
      double maiorValor = 0.0;
      double menorValor = 100.0;
      List<DaysProperty> listDays =
          await consultValueService.getDaysValue(action: event.action);

      if (listDays.last.open == 0.0) {
        listDays.removeLast();
      }

      for (var element in listDays) {
        if (element.open! > maiorValor) {
          maiorValor = element.open!;
        }

        if (element.open! < menorValor) {
          menorValor = element.open!;
        }
      }

      emit(
        HomePageState(
            action: event.action,
            listDays: listDays.reversed.toList(),
            highValue: maiorValor,
            lowValue: menorValor),
      );
    } catch (e) {
      emit(ErrorPageState(message: e.toString()));
    }
  }
}
