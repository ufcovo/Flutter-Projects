// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociall_app_ard/sayfalar/akis.dart';
import 'package:sociall_app_ard/sayfalar/ara.dart';
import 'package:sociall_app_ard/sayfalar/duyurular.dart';
import 'package:sociall_app_ard/sayfalar/profil.dart';
import 'package:sociall_app_ard/sayfalar/yukle.dart';
import 'package:sociall_app_ard/servisler/yetkilendirmeservisi.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _aktifSayfaNo = 0;
  PageController? sayfaKumandasi;

  @override
  void initState() {
    super.initState();
    sayfaKumandasi = PageController();
  }

  @override
  void dispose() {
    sayfaKumandasi!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    String? aktifKullaniciId = Provider.of<YetkilendirmeServisi>(context, listen: false).aktifKullaniciId;

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (acilanSayfaNo) {
          setState(() {
            _aktifSayfaNo = acilanSayfaNo;
          });
        },
        controller: sayfaKumandasi,
        children:  <Widget>[
           Akis(),
          const Ara(),
          const Yukle(),
          const Duyurular(),
          Profil(profilSahibiId: aktifKullaniciId,)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _aktifSayfaNo,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Akış")),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore), title: Text("Keşfet")),
          BottomNavigationBarItem(
              icon: Icon(Icons.file_upload), title: Text("Yükle")),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), title: Text("Duyurular")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Profil")),
        ],
        onTap: (secilenSayfaNo) {
          setState(() {
            sayfaKumandasi!.jumpToPage(secilenSayfaNo);
          });
        },
      ),
    );
  }
}
