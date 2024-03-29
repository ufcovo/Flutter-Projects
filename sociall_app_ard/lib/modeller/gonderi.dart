import 'package:cloud_firestore/cloud_firestore.dart';

class Gonderi {
  final String? id;
  final String? gonderiResmiUrl;
  final String? aciklama;
  final String? yayinlayanId;
  final String? konum;
  final int? begeniSayisi;

  Gonderi({this.id, this.gonderiResmiUrl, this.aciklama, this.yayinlayanId, this.begeniSayisi, this.konum});

  factory Gonderi.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc;
    return Gonderi(
      id : doc.id,
      gonderiResmiUrl: docData['gonderiResmiUrl'],
      aciklama: docData['aciklama'],
      yayinlayanId: docData['yayinlayanId'],
      begeniSayisi: docData['begeniSayisi'],
      konum: docData['konum'],
    );
  }

}