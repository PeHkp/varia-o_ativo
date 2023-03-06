import 'package:flutter/material.dart';

class DaysProperty {
  int? date;
  double? open;

  DaysProperty({required this.date, required this.open});

  DaysProperty.fromResponse({required Map data})
      : date = data["date"],
        open = data["open"] == null ? 0.0 : data["open"].toDouble();
}
