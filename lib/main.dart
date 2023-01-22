import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/cache/app_shared_pref.dart';
import 'core/init/notifier/theme_notifier.dart';
import 'viewmodel/song_view_model.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.initPref();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => SongViewModel(),
      )
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeNotifier>(context, listen: true).currentTheme,
      home: const HomeScreen(),
    );
  }
}
