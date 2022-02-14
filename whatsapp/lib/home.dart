import 'package:flutter/material.dart';
import 'package:whatsapp/screens/call_screen.dart';
import 'package:whatsapp/screens/chat_screen.dart';
import 'package:whatsapp/screens/status_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, initialIndex: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp"),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "Sohbetler",
            ),
            Tab(
              text: "Durum",
            ),
            Tab(
              text: "Aramalar",
            ),
          ],
        ),
        actions: const <Widget>[Icon(Icons.search), Icon(Icons.more_vert)],
      ),
      body: TabBarView(
        controller: _tabController,
        children:  <Widget>[
          Text("Kamera"),
          ChatScreen(),
          StatusScreen(),
          CallScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: const Icon(
          Icons.message,
          color: Colors.white,
        ),
        onPressed: () => print("SOhbet Ekranı"),
      ),
    );
  }
}
