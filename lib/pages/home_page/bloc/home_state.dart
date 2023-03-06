// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:variacao_ativo/services/consult_value/consult_value_response.dart';

class HomePageState {
  final List<DaysProperty>? listDays;
  final String? action;
  final double? highValue;
  final double? lowValue;

  HomePageState({
    this.listDays,
    this.action = "PETR4",
    this.highValue,
    this.lowValue,
  });

  HomePageState copyWith({
    List<DaysProperty>? listDays,
    String? action,
    double? highValue,
    double? lowValue,
  }) {
    return HomePageState(
      listDays: listDays ?? this.listDays,
      action: action ?? this.action,
      highValue: highValue ?? this.highValue,
      lowValue: lowValue ?? this.lowValue,
    );
  }
}

class LoadingHomePageState extends HomePageState {
  final String? action;

  LoadingHomePageState({
    this.action = "PETR4",
  });
}

class LoadingNewActionHomePageState extends HomePageState {
  LoadingNewActionHomePageState({
    List<DaysProperty>? listDays,
    String? action,
    double? highValue,
    double? lowValue,
  }) : super(
            action: action,
            listDays: listDays,
            highValue: highValue,
            lowValue: lowValue);
}

class ErrorPageState extends HomePageState {
  final String? message;

  ErrorPageState({
    this.message,
  });
}
