import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_library/db/preferences.dart';
import 'package:univ_library/shared/styles/themes.dart';
import 'package:univ_library/widgets/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => ThemeNotifier()),
        ),
        ChangeNotifierProvider(
          create: ((context) => Preferences()),
        ),
      ],
      child: Consumer<ThemeNotifier>(builder: (context, value, child) {
        return MaterialApp(
          title: 'Univ Library',
          debugShowCheckedModeBanner: false,
          theme: value.darkTheme ? Themes.darkTheme : Themes.lightTheme,
          home: const Navigation(),
        );
      }),
    );
  }
}
