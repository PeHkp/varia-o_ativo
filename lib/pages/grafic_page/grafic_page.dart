// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:variacao_ativo/services/consult_value/consult_value_response.dart';

class PageArguments {
  final double hvalue;
  final double lvalue;
  final List<DaysProperty> daysList;
  final String action;

  PageArguments(
    this.hvalue,
    this.lvalue,
    this.daysList,
    this.action,
  );
}

class GraficPage extends StatelessWidget {
  List<Color> gradientColors = const [
    Color.fromRGBO(255, 192, 66, 1),
    Color.fromARGB(255, 255, 0, 0),
  ];

  double? hValue;
  double? lValue;
  List<DaysProperty>? days;

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as PageArguments;
    hValue = arguments.hvalue;
    lValue = arguments.lvalue - 1;
    days = arguments.daysList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4C33CC),
        centerTitle: true,
        title: Text(
          arguments.action,
          style: const TextStyle(color: Color(0xffFFC042)),
        ),
      ),
      backgroundColor: const Color(0xff4C33CC),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('01/02', style: style);
        break;
      case 1:
        text = const Text('10/02', style: style);
        break;
      case 2:
        text = const Text('20/02', style: style);
        break;
      case 3:
        text = const Text('30/02', style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white);
    String text;
    switch (value.toInt()) {
      case 24:
        text = lValue.toString();
        break;
      case 25:
        text = (lValue! + 1).toString();
        break;
      case 26:
        text = (hValue! - 1).toString();
        break;
      case 27:
        text = (hValue).toString();
        break;

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      maxX: 3,
      maxY: 27,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, days![0].open!),
            FlSpot(1, days![10].open!),
            FlSpot(2, days![20].open!),
            FlSpot(3, days![days!.length - 1].open!),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
