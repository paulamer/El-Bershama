import 'package:el_bershama/app.dart';
import 'package:el_bershama/features/medicines/data/repositories/medicine_repository.dart';
import 'package:el_bershama/features/notifications/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  
  // Initialize Repositories and Services
  final medicineRepo = MedicineRepository();
  await medicineRepo.init();
  
  final notificationService = NotificationService();
  await notificationService.init();

  runApp(
    ProviderScope(
      overrides: [
        medicineRepositoryProvider.overrideWithValue(medicineRepo),
      ],
      child: const MedicineApp(),
    ),
  );
}
