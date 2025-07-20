import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/sensor_model.dart';

class SensorLineChart extends StatelessWidget {
  final String label;
  final Color color;
  final List<SensorDetails> data;
  final double Function(SensorDetails) valueSelector;

  const SensorLineChart({
    super.key,
    required this.label,
    required this.color,
    required this.data,
    required this.valueSelector,
  });

  static const Map<String, List<double>> _thresholds = {
    'NH3': [0, 8, 17, 35],
    'H2S': [0, 5, 10, 20],
    'CH4': [0, 250, 500, 1000],
    'CO2': [0, 2250, 4500, 9000],
    'PM2.5': [0, 35, 55, 150],
    'CO': [0, 9, 12, 15],
    'TVOC': [0, 660, 1430, 2200],
  };

  List<double> get _xValues => _thresholds[label] ?? [0, 25, 50, 75, 100];
  double get _maxY => _xValues.last;

  List<FlSpot> get _spots => data.map((sample) {
    final minutes = sample.timestamp.hour * 60 + sample.timestamp.minute;
    return FlSpot(minutes.toDouble(), valueSelector(sample));
  }).toList();

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: _buildTitlesData(),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 1440,
        minY: 0,
        maxY: _maxY,
        lineBarsData: [_buildLine()],
        lineTouchData: _buildTouchData(),
      ),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          interval: _maxY / 4,
          getTitlesWidget: (value, _) => Text(
            value.toInt().toString(),
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 20.h,
          interval: 240,
          getTitlesWidget: _bottomTimeFormatter,
        ),
      ),
    );
  }

  Widget _bottomTimeFormatter(double minutes, _) {
    final hour = (minutes / 60).floor();
    const hoursToShow = [0, 4, 8, 12, 16, 20, 24];
    if (hoursToShow.contains(hour)) {
      return Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Text(
          '${hour}hr',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  LineChartBarData _buildLine() {
    return LineChartBarData(
      spots: _spots,
      isCurved: true,
      curveSmoothness: 0.4,
      color: color,
      barWidth: 2.5,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(
        show: true,
        color: color.withOpacity(0.2),
      ),
      dotData: FlDotData(show: false),
    );
  }

  LineTouchData _buildTouchData() {
    return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: color,
        tooltipRoundedRadius: 8,
        tooltipPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((spot) {
            final minutes = spot.x.toInt();
            final hours = (minutes / 60).floor();
            final mins = minutes % 60;
            return LineTooltipItem(
              '${spot.y.toStringAsFixed(1)}\n${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}',
              TextStyle(
                fontSize: 11.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            );
          }).toList();
        },
      ),
      getTouchedSpotIndicator: (_, spotIndexes) {
        return spotIndexes.map((index) {
          return TouchedSpotIndicatorData(
            FlLine(color: Colors.transparent, strokeWidth: 0),
            FlDotData(
              show: true,
              getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                radius: 4.r,
                color: color,
                strokeWidth: 2,
                strokeColor: Colors.white,
              ),
            ),
          );
        }).toList();
      },
    );
  }
}