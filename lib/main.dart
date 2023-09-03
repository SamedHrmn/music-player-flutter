import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/cache/app_shared_pref.dart';
import 'viewmodel/song_view_model.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.initPref();

  runApp(
    ChangeNotifierProvider(
      create: (context) => SongViewModel(),
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
