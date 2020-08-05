import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splitb/constants.dart';
import 'package:splitb/providers.dart';
import 'package:splitb/router.dart';
import 'package:splitb/screens/splashscreens.dart';
import 'package:splitb/utils/theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    final navServiceProvider = useProvider(navService);
    return MaterialApp(
      navigatorKey: navServiceProvider.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: SPLASHSCREEN,
      title: 'Flutter Demo',
      theme: darkThemeData(context),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
