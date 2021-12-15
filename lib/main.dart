import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_template/domain/use_case/controllers/notifications.dart';
import 'package:misiontic_template/domain/use_case/location_management.dart';
import 'package:misiontic_template/domain/use_case/notification_management.dart';
import 'package:misiontic_template/ui/app.dart';
import 'package:workmanager/workmanager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 1. TO DO: Crea el controlador de notificaciones e inicializa el pluggin

  NotificationController notificationController = Get.put(NotificationController());

  await notificationController.initialize();

  // 2. TO DO: 
  // Crea el canal para notificaciones 
  notificationController.createChannel(
    id: 'user_location', 
    name: 'User Location',
    description: 'La ubicación actual es ...'
    );

  // 4. TO DO:
  // Inicializa el Workmanager con el metodo creado y registra la tarea periodica
  await Workmanager().initialize(
    updatePositionInBackground,
    isInDebugMode: true
  );
  
  await Workmanager().registerPeriodicTask(
    "1",
    "locationPeriodicTask",
    frequency: const Duration(seconds: 10)
  );

  runApp(const App());
}

// 3. TO DO:
// Crea un metodo que cree una tarea, obtenga la ubicación 
// y la muestre en una notificación
void updatePositionInBackground() async {
  // Crear variables de Manejador de Localización y Notificación
  final locationManager = LocationManager();
  final _notificationManager = NotificationManager();
  // Ejecutar tarea del workmanager
  Workmanager().executeTask((task, inputData) async {
    // Inicializar el natificador
    await _notificationManager.initialize();
    // Crear el canal del notificador
    final _channel = _notificationManager.createChannel(
      id: 'user_location', 
      name: 'User Location', 
      description: 'La ubicación actual es...');
    // Obtener la posición actual
    final position = await locationManager.getCurrentLocation();
    // Mostrar la notificación
    _notificationManager.showNotification(
      channel: _channel, 
      title: 'Tu ubicación es: ', 
      body: 'Latitud: ${position.latitude} - Longitud: ${position.longitude}');
      return Future.value(true);
  });
}
