import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:misiontic_template/domain/use_case/notification_management.dart';

class NotificationController extends GetxController {
  // Observables
  final _manager = NotificationManager();
  late NotificationDetails  _channel;

  // TODO
  //Inicializa el pluggin de notificaciones
  initialize() async {
    await _manager.initialize();
  }

  // TODO
  //Crea el canal para notificaciones
  createChannel(
    {required String id, required String name, required String description}
  ){
    _channel = _manager.createChannel(id: id, name: name, description: description);
  }
  

  show({required String title, required String body}) =>
      _manager.showNotification(channel: _channel, title: title, body: body);
}
