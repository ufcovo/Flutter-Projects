import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociall_app_ard/servisler/yetkilendirmeservisi.dart';
import 'package:sociall_app_ard/yonlendirme.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<YetkilendirmeServisi>(
      create: (_) => YetkilendirmeServisi(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Yonlendirme(),
      ),
    );
  }
}
