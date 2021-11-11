import 'package:flutter/material.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MusicManagementApp());
}

class MusicManagementApp extends StatefulWidget {
  @override
  State<MusicManagementApp> createState() => _MusicManagementAppState();
}

class _MusicManagementAppState extends State<MusicManagementApp> {
  Future<void> getArtistsByName() async {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
