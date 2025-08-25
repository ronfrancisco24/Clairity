import '../models/sensor_model_details.dart';
import '../providers/log_provider.dart';
import '../services/notification_reading_service.dart';
import 'sensor_manager.dart';
import '../providers/sensor_provider.dart';

class DashboardService {
  SensorManager? _sensorManager;

  void setSensor(
      String sensorId,
      SensorProvider sensorProvider,
      LogProvider logProvider,
      ) {
    // Update provider state
    sensorProvider.setSensorId(sensorId);

    // Save the device token for this sensor
    NotificationReadingService().saveDeviceToken(sensorId);

    // Dispose old manager
    _sensorManager?.dispose();

    // Create new manager
    _sensorManager = SensorManager(provider: sensorProvider, sensorId: sensorId);

    // Start listening
    _sensorManager?.startListening(sensorId);

    // Update logs
    logProvider.listenToLatestCleanedTime(sensorId);
  }

  void dispose() {
    _sensorManager?.dispose();
  }

  SensorDetails? getSelectedReading(SensorProvider provider, int selectedTimeIndex) {
    if (selectedTimeIndex == 0) return provider.currentData;
    final forecastList = provider.forecastReadingData;
    if (selectedTimeIndex - 1 < forecastList.length) {
      return forecastList[selectedTimeIndex - 1];
    }
    return null;
  }

}