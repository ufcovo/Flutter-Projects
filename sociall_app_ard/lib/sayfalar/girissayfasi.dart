// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociall_app_ard/modeller/kullanici.dart';
import 'package:sociall_app_ard/sayfalar/hesapolustur.dart';
import 'package:sociall_app_ard/sayfalar/sifremiunuttum.dart';
import 'package:sociall_app_ard/servisler/firestoreservisi.dart';
import 'package:sociall_app_ard/servisler/yetkilendirmeservisi.dart';

class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({Key? key}) : super(key: key);

  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  final _formAnahtari = GlobalKey<FormState>();
  final _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  bool yukleniyor = false;
  String? email;
  String? sifre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldAnahtari,
      body: Stack(
        children: <Widget>[
          _sayfaElemanlari(),
          _yuklemeAnimasyonu(),
        ],
      ),
    );
  }

  Widget _yuklemeAnimasyonu() {
    if (yukleniyor) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Center();
    }
  }

  Widget _sayfaElemanlari() {
    return Form(
      key: _formAnahtari,
      child: ListView(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
        children: <Widget>[
          const FlutterLogo(size: 90.0),
          const SizedBox(
            height: 80.0,
          ),
          TextFormField(
            autocorrect: true,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Email adresinizi girin.",
              errorStyle: TextStyle(fontSize: 16.0),
              prefixIcon: Icon(Icons.mail),
            ),
            validator: (girilenDeger) {
              if (girilenDeger!.isEmpty) {
                return "Email alanı boş bırakılamaz.";
              } else if (!girilenDeger.contains("@")) {
                return "Girilen değer mail formatı ile olmalı.";
              }
              return null;
            },
            onSaved: (girilenDeger) => email = girilenDeger,
          ),
          const SizedBox(
            height: 40.0,
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Şifrenizi girin.",
              errorStyle: TextStyle(fontSize: 16.0),
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (girilenDeger) {
              if (girilenDeger!.isEmpty) {
                return "Şifre alanı boş bırakılamaz.";
              } else if (girilenDeger.trim().length < 4) {
                return "Şifre 4 karakterden küçük olamaz.";
              }
              return null;
            },
            onSaved: (girilenDeger) => sifre = girilenDeger,
          ),
          const SizedBox(
            height: 40.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HesapOlustur()));
                  },
                  child: const Text(
                    "Hesap Oluştur",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: FlatButton(
                  onPressed: _girisYap,
                  child: const Text(
                    "Giriş yap",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Center(child: Text("Veya")),
          const SizedBox(
            height: 20.0,
          ),
          Center(
              child: InkWell(
            onTap: _googleIleGiris,
            child: Text(
              "Google ile giriş yap.",
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          )),
          const SizedBox(
            height: 20.0,
          ),
           Center(child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SifremiUnuttum()));
            },
            child: const Text("Şifremi Unuttum")
            
            )),
        ],
      ),
    );
  }

  void _girisYap() async {
    final _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);

    if (_formAnahtari.currentState!.validate()) {
      _formAnahtari.currentState!.save();
      setState(() {
        yukleniyor = true;
      });

      try {
        await _yetkilendirmeServisi.mailIleGiris(email!, sifre!);
      } catch (hata) {
        setState(() {
          yukleniyor = false;
        });
        uyariGoster(hataKodu: hata.toString());
      }
    }
  }

  void _googleIleGiris() async {
    var _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);
    setState(() {
      yukleniyor = true;
    });
    try {
      Kullanici? kullanici = await _yetkilendirmeServisi.googleIleGiris();
      if (Kullanici != null) {
        Kullanici? firestoreKullanici =
            await FireStoreServisi().kullaniciGetir(kullanici!.id);
        if (firestoreKullanici == null) {
          FireStoreServisi().kullaniciOlustur(
              id: kullanici.id,
              email: kullanici.email,
              kullaniciAdi: kullanici.kullaniciAdi,
              fotoUrl: kullanici.fotoUrl);
        }
      }
    } catch (hata) {
      setState(() {
        yukleniyor = false;
      });
      uyariGoster(hataKodu: hata.toString());
    }
  }

  uyariGoster({hataKodu}) {
    String hataMesaji;

    if (hataKodu == "user-not-found") {
      hataMesaji = "Böyle bir kullanıcı bulunmuyor";
    } else if (hataKodu == "invalid-email") {
      hataMesaji = "Girdiğiniz mail adresi geçersizdir";
    } else if (hataKodu == "wrong-password") {
      hataMesaji = "Girilen şifre hatalı";
    } else if (hataKodu == "user-disabled") {
      hataMesaji = "Kullanıcı engellenmiş";
    } else {
      hataMesaji = "Tanımlanamayan bir hata oluştu $hataKodu";
    }

    var snackBar = SnackBar(content: Text(hataMesaji));
    _scaffoldAnahtari.currentState!.showSnackBar(snackBar);
  }
}
