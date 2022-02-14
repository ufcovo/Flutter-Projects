// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociall_app_ard/modeller/kullanici.dart';
import 'package:sociall_app_ard/servisler/firestoreservisi.dart';
import 'package:sociall_app_ard/servisler/yetkilendirmeservisi.dart';

class HesapOlustur extends StatefulWidget {
  const HesapOlustur({Key? key}) : super(key: key);

  @override
  _HesapOlusturState createState() => _HesapOlusturState();
}

class _HesapOlusturState extends State<HesapOlustur> {
  bool yukleniyor = false;
  final _formAnahtari = GlobalKey<FormState>();
  late String kullaniciAdi, email, sifre;
  final _scaffoldAnahtari = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldAnahtari,
      appBar: AppBar(
        title: const Text("Hesap Oluştur"),
      ),
      body: ListView(
        children: <Widget>[
          yukleniyor
              ? const LinearProgressIndicator()
              : const SizedBox(
                  height: 0.0,
                ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formAnahtari,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autocorrect: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Kullanıcı adınızı girin.",
                      labelText: "Kullanıcı Adı: ",
                      errorStyle: TextStyle(fontSize: 16.0),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger!.isEmpty) {
                        return "Kullanıcı adı boş bırakılamaz.";
                      } else if (girilenDeger.trim().length < 4 ||
                          girilenDeger.trim().length > 10) {
                        return "En az 4 en fazla 10 karakter olabilir.";
                      }
                      return null;
                    },
                    onSaved: (girilenDeger) => kullaniciAdi = girilenDeger!,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email adresinizi girin.",
                      labelText: "Email: ",
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
                    onSaved: (girilenDeger) => email = girilenDeger!,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Şifrenizi girin.",
                      labelText: "Şifre: ",
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
                    onSaved: (girilenDeger) => sifre = girilenDeger!,
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: _kullaniciOlustur,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _kullaniciOlustur() async {
    var _formState = _formAnahtari.currentState!;
    final _yetkilendirmeServisi = Provider.of<YetkilendirmeServisi>(context, listen: false);


    if (_formState.validate()) {
      _formState.save();
      setState(() {
        yukleniyor = true;
      });

      try {
        Kullanici? kullanici = await _yetkilendirmeServisi.mailIleKayit(email, sifre);
        if(kullanici != null) {
          FireStoreServisi().kullaniciOlustur(id: kullanici.id, email: email, kullaniciAdi: kullaniciAdi);
        }
        Navigator.pop(context);
      }
      catch(hata) {
        setState(() {
          yukleniyor = false;
        });

        var snackBar = SnackBar(content: Text(hata.toString()));
        _scaffoldAnahtari.currentState!.showSnackBar(snackBar);
        // uyariGoster(hata.toString());
      }

      
    }
  }

  // uyariGoster(hataKodu){
  //   String? hataMesaji;

  //   if(hataKodu == "invalid-email"){
  //     hataMesaji = "Girdiğiniz mail adresi geçersizdir";
  //   } else if (hataKodu == "email-already-in-use") {
  //     hataMesaji = "Girdiğiniz mail kayıtlıdır";
  //   } else if (hataKodu == "weak-password") {
  //     hataMesaji = "Daha zor bir şifre tercih edin";
  //   }

  //   var snackBar = SnackBar(content: Text(hataMesaji!));
  //   _scaffoldAnahtari.currentState!.showSnackBar(snackBar);

  // }

}
