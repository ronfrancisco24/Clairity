import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants.dart' as constants;
import '../../models/sensor_data_model.dart';
import '../../providers/sensor_provider.dart';
import '../../utils/dashboard_utils.dart';
import '../../utils/navbar_utils.dart';
import 'aqi_card.dart';
import 'card_quality.dart';

class AirQualitySection extends StatefulWidget {
  final SensorDataModel? selectedReading;
  final String? selectedSensorId;

  const AirQualitySection({super.key, this.selectedReading, this.selectedSensorId});

  @override
  State<AirQualitySection> createState() => _AirQualitySectionState();
}

class _AirQualitySectionState extends State<AirQualitySection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Currents Card
        Expanded(
          child: Consumer<SensorProvider>(
            builder: (context, provider, _) {
              // You can adjust how you calculate these
              final value = (widget.selectedReading?.aqi ?? 0);
              final status =
                  widget.selectedReading?.aqiCategory ?? 'Unknown';
              return AqiCard(
                value: value,
                status: status,
              );
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<SensorProvider>(
                builder: (context, provider, _) {
                  final highest = widget.selectedReading != null
                      ? getHighestPollutant(widget.selectedReading!)
                      : null;
                  final level = highest != null
                      ? getPollutantLevel(highest.value)
                      : null;
                  return CardQuality(
                    onTap: () async {
                      if (widget.selectedSensorId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No sensor selected"),
                          ),
                        );
                        return;
                      }
                      // await SensorReadingService()
                      //     .generateRawTestData(_selectedSensorId!);
                      NavController.of(context)?.onNavSelect(
                          constants.NavRoute.history,
                          initialIndex: 2);
                    },
                    trendLabel: 'Air Quality Trend',
                    trendValue: highest?.key ?? '--',
                    trendLevel: level ?? 'No Data',
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
