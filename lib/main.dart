import 'package:agua/providers/drink_provider.dart';
import 'package:agua/screens/dashboard/dashboar_screen.dart';
import 'package:agua/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => DrinkProvider())],
      child: MaterialApp(
        title: 'Beber Água',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: primaryColor,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.grey,
            accentColor: primaryColor,
          ).copyWith(primary: primaryColor, secondary: fillColor),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: fillColor,
            foregroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            centerTitle: false,
            shadowColor: Colors.transparent,
          ),
          tabBarTheme: TabBarTheme(
            labelColor: fillColor,
            indicatorColor: fillColor,
            unselectedLabelColor: const Color.fromARGB(255, 190, 194, 206),
            dividerColor: Colors.transparent,
          ),
          bottomAppBarTheme: BottomAppBarTheme(color: primaryColor),
          cardTheme: CardTheme(color: backgroundColor),
        ),
        home: DashboarScreen(),
      ),
    );
  }
}
