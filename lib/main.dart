import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/init/notifier/theme_notifier.dart';
import 'viewmodel/song_view_model.dart';
import 'views/home_screen.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
      ),
      ChangeNotifierProvider(create: (context) => SongViewModel())
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeNotifier>(context, listen: true).currentTheme,
      home: HomeScreen(),
    );
  }
}
