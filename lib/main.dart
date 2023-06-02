import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/controller/theme.controller.dart';
import 'package:portfolio/shared/colors.dart';

import 'widgets/termux.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  themeProd.read(themeProvider.notifier).init().then((_) {
    runApp(
      ProviderScope(
        child: MyApp(themeContainer: themeProd),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  final ProviderContainer themeContainer;

  MyApp({Key? key, required this.themeContainer}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    KColor? _activeColor =
        widget.themeContainer.read(themeProvider.notifier).themeColor;

    widget.themeContainer.listen<ThemeNotifier>(
      themeProvider,
      (previous, next) {
        setState(() {
          _activeColor = next.themeColor;
        });
      },
    );

    dynamic themeData = ThemeData(
      useMaterial3: true,
      primaryColor: _activeColor!.primaryColor.toColor(),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: _activeColor!.accentColor.toColor(),
        backgroundColor: _activeColor!.backgroundColor.toColor(),
      ),
      highlightColor: _activeColor!.secondaryColor.toColor(),
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.sourceCodePro(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
          color: _activeColor!.primaryColor.toColor(),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: _activeColor!.primaryColor.toColor(),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 0.0),
        isCollapsed: true,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: themeData,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 2.0,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: const Termux(),
      ),
    );
  }
}
