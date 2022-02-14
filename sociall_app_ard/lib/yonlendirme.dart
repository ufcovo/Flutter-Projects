import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociall_app_ard/modeller/kullanici.dart';
import 'package:sociall_app_ard/sayfalar/anasayfa.dart';
import 'package:sociall_app_ard/sayfalar/girissayfasi.dart';
import 'package:sociall_app_ard/servisler/yetkilendirmeservisi.dart';

class Yonlendirme extends StatelessWidget {
  const Yonlendirme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _yetkilendirmeServisi = Provider.of<YetkilendirmeServisi>(context, listen: false);
    

    return StreamBuilder(
      stream: YetkilendirmeServisi().durumTakipcisi,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasData) {
          Kullanici aktifKullanici = snapshot.data as Kullanici;
          _yetkilendirmeServisi.aktifKullaniciId = aktifKullanici.id;
          return const AnaSayfa();
        } else {
          return const GirisSayfasi();
        }
      },
    );
  }
}
