import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/landing/splash_screen.dart';
import 'package:furnihome_ar/routes/app_route.dart';
import 'package:furnihome_ar/utils/app_theme.dart';
import 'package:furnihome_ar/utils/strings.dart';

import 'di/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setUpServiceLocator();
  runApp(const ProviderScope(child: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final appRoute = locator<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: Strings.appName,
        theme: AppTheme.define(),
        routerConfig: appRoute.config(),
      ),
    );
  }
}
