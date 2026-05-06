import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/hive_helper.dart';
import 'core/notifications/notification_helper.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  await NotificationHelper.init();
  runApp(const ProviderScope(child: MedicineApp()));
}
