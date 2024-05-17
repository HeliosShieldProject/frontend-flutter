import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helios/themes/theme.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

void main() {
  runApp(const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobilePlatform = Platform.isAndroid || Platform.isIOS;

    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      theme: myDarkTheme,
      home: isMobilePlatform || kDebugMode ? const HeliosMobile() : const HeliosDesktop(),
    );
  }
}

class HeliosMobile extends StatelessWidget {
  const HeliosMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helios Mobile'),
      ),
      body: const Center(
        child: Text('Welcome to Helios Mobile!'),
      ),
    );
  }
}

class HeliosDesktop extends StatelessWidget {
  const HeliosDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helios Desktop'),
      ),
      body: const Center(
        child: Placeholder(),
      ),
    );
  }
}