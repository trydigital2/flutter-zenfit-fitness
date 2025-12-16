import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'theme/app_theme.dart';
import 'bindings/initial_binding.dart';
import '../core/constants/app_constants.dart';
import '../core/services/storage_service.dart';

class ZenFitApp extends StatelessWidget {
  const ZenFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = Get.find<StorageService>();
    final isDark = storage.isDarkMode;

    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: InitialBinding(),
    );
  }
}
