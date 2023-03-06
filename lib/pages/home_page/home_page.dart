import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:variacao_ativo/pages/grafic_page/grafic_page.dart';
import 'package:variacao_ativo/pages/home_page/bloc/home_bloc.dart';
import 'package:variacao_ativo/pages/home_page/bloc/home_event.dart';
import 'package:variacao_ativo/pages/home_page/bloc/home_state.dart';
import 'package:variacao_ativo/routes.dart';
import 'package:variacao_ativo/services/consult_value/consult_value_response.dart';
import 'package:variacao_ativo/widgets/card_day.dart';

class HomePage extends StatelessWidget {
  List<String> listAction = [
    "PETR4",
    "MGLU3",
    "B3SA3",
    "ABCB4",
    "BBDC3",
    "TOTS3"
  ];
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4C33CC),
      body: SafeArea(
        child: BlocConsumer<HomePageBloc, HomePageState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoadingHomePageState:
                context
                    .read<HomePageBloc>()
                    .add(LoadingHomePageEvent(action: "PETR4"));
                return Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(255, 255, 255, 0.8),
                    ),
                    child: const Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          color: Color(0xffFFC042),
                          strokeWidth: 5,
                        ),
                      ),
                    ),
                  ),
                );
              case HomePageState:
              case LoadingNewActionHomePageState:
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 40,
                            child: DropdownButton<String>(
                              value: state.action,
                              icon: const Icon(
                                Icons.arrow_downward,
                                color: Color(0xffFFC042),
                              ),
                              elevation: 16,
                              dropdownColor: const Color(0xff4C33CC),
                              isExpanded: true,
                              style: const TextStyle(
                                color: Color(0xffFFC042),
                              ),
                              underline: Container(
                                height: 2,
                                color: const Color(0xffFFC042),
                              ),
                              onChanged: (String? value) {
                                context
                                    .read<HomePageBloc>()
                                    .add(ChangeActionEvent(action: value!));
                              },
                              items: listAction.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 40,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xffFFC042)),
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.grafic,
                                    arguments: PageArguments(
                                        state.highValue!,
                                        state.lowValue!,
                                        state.listDays!,
                                        state.action!));
                              },
                              child: const Text(
                                'Gráfico',
                                style: TextStyle(color: Color(0xff4C33CC)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Data",
                                  style: TextStyle(
                                      color: Color(0xff4C4766), fontSize: 16)),
                              Text(
                                "Valor",
                                style: TextStyle(
                                    color: Color(0xff4C4766), fontSize: 16),
                              ),
                              Text("D-1",
                                  style: TextStyle(
                                      color: Color(0xff4C4766), fontSize: 16)),
                              Text("1 dia",
                                  style: TextStyle(
                                      color: Color(0xff4C4766), fontSize: 16))
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      state.runtimeType == LoadingNewActionHomePageState
                          ? const Center(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(
                                  color: Color(0xffFFC042),
                                  strokeWidth: 5,
                                ),
                              ),
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height - 320,
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    DaysProperty day = state.listDays![index];
                                    String vd0 = "-";
                                    String vd1 = "-";
                                    if (index != 0) {
                                      DaysProperty dayLast =
                                          state.listDays![index - 1];

                                      DaysProperty dayFirst =
                                          state.listDays![0];

                                      double vd0D =
                                          ((day.open! / dayFirst.open!) - 1) *
                                              100;

                                      vd0 = vd0D.toStringAsPrecision(2);

                                      double vd1D =
                                          ((day.open! / dayLast.open!) - 1) *
                                              100;

                                      vd1 = vd1D.toStringAsPrecision(2);
                                    }

                                    var dt =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            day.date! * 1000);
                                    var d24 = DateFormat('MM/yy').format(dt);

                                    return CardDay(
                                      date: d24,
                                      open:
                                          "R\$ ${day.open!.toStringAsPrecision(4).replaceAll(".", ",")}",
                                      variationD0: "$vd0%",
                                      variationD1: "$vd1%",
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 16,
                                    );
                                  },
                                  itemCount: state.listDays!.length),
                            )
                    ],
                  ),
                );
              default:
                return Container();
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
