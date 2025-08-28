// import 'package:flutter/material.dart';
// import '../../utils/dashboard_utils.dart';
// import 'forecast_card.dart';
//
// class ForecastCards extends StatefulWidget {
//   const ForecastCards(
//       {super.key,
//       required this.aqiCategory30,
//       required this.aqiCategory60,
//       required this.aqi30,
//       required this.aqi60,});
//
//   final String aqiCategory30;
//   final String aqiCategory60;
//   final double? aqi30;
//   final double? aqi60;
//
//   @override
//   State<ForecastCards> createState() => _ForecastCardsState();
// }
//
// class _ForecastCardsState extends State<ForecastCards> {
//   final min30 = DateTime.now().toUtc().add(const Duration(hours: 8, minutes: 30));
//   final min60 = DateTime.now().toUtc().add(const Duration(hours: 9));
//
//   late final String formatted30 = getFormattedTime(min30);
//   late final String formatted60 = getFormattedTime(min60);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         ForecastCard(
//           time: formatted30,
//           value: widget.aqi30,
//           category: widget.aqiCategory30,
//         ),
//         const SizedBox(width: 20),
//         ForecastCard(
//           time: formatted60,
//           value: widget.aqi60,
//           category: widget.aqiCategory60,
//         ),
//       ],
//     );
//   }
// }