import 'package:flutter/material.dart';

class CardDay extends StatelessWidget {
  String open;
  String date;
  String variationD0;
  String variationD1;

  CardDay({
    Key? key,
    required this.open,
    required this.date,
    required this.variationD0,
    required this.variationD1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(date,
                style: const TextStyle(color: Color(0xff4C4766), fontSize: 16)),
            Text(
              open,
              style: const TextStyle(color: Color(0xff4C4766), fontSize: 16),
            ),
            Text(variationD0,
                style: const TextStyle(color: Color(0xff4C4766), fontSize: 16)),
            Text(variationD1,
                style: const TextStyle(color: Color(0xff4C4766), fontSize: 16))
          ],
        ));
  }
}
