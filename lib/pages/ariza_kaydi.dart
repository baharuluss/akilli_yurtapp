import 'package:akilli_yurt/yanmenu.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';


class ArizaKaydi extends StatefulWidget {
  const ArizaKaydi({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ArizaKaydi createState() => _ArizaKaydi();

}

class _ArizaKaydi extends State<ArizaKaydi>{
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController odaYatakController = TextEditingController();
  TextEditingController arizaDetayiController = TextEditingController();
  String? selectedBlok;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd4c4e9),
      appBar: AppBar(
        title: const Text(
          "Arıza Kaydı",
          style: TextStyle(
              fontWeight: FontWeight.w900,),
        ),
      ),

      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ), //2/6
                    const Center(
                      child: Text(
                        "Arıza Kayıt Formu",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                          fontSize: 30,
                        ),
                      ),
                    ), // 1/6
                    const SizedBox(
                      height: 40,
                    ),
                    TextField(
                      inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-ZğüşıöçĞÜŞİÖÇ ]')),
                ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.deepPurple.shade200,
                        hintText: "Adınız Soyadınız",
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      controller: adSoyadController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    TextField(
                      inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9\\s-]')),
                ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.deepPurple.shade200,
                        hintText: "Oda Numaranız - Yatak Numaranız",
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      controller: odaYatakController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Blok Adı",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Center(
                                child: Radio<String>(
                                  value: "Ayşe Tok Bloğu",
                                  groupValue: selectedBlok,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedBlok = value;
                                    });
                                  },
                                ),
                              ),
                              const Text("Ayşe Tok Bloğu"),

                              Radio<String>(
                                value: "Murat Tok Bloğu",
                                groupValue: selectedBlok,
                                onChanged: (value) {
                                  setState(() {
                                    selectedBlok = value;
                                  });
                                },
                              ),
                              const Text("Murat Tok Bloğu"),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      maxLines: 5,
                      inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-ZğüşıöçĞÜŞİÖÇ 0-9\\s- ]')),
                ],
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Arızayı Detaylı Açıklayınız",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      controller: arizaDetayiController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Verileri al
                          String adSoyad = adSoyadController.text;
                          String odaYatak = odaYatakController.text;
                          String arizaDetayi = arizaDetayiController.text;

                          if (adSoyad.isNotEmpty && odaYatak.isNotEmpty && selectedBlok != null && arizaDetayi
                  .isNotEmpty) {
                            CollectionReference arizaKayitlarRef =
                            FirebaseFirestore.instance.collection('arizaKayitlar');

                            arizaKayitlarRef.doc(selectedBlok).collection('kayitlar').add({
                                'adSoyad': adSoyad,
                                'odaYatak': odaYatak,
                                'arizaDetayi': arizaDetayi,
                                'timestamp': FieldValue.serverTimestamp(),
                            })
                            .then((value){
                              adSoyadController.clear();
                              odaYatakController.clear();
                              arizaDetayiController.clear();
                              selectedBlok = null;

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Kayıt Gönderildi'),
                                    content: const Text('Arıza kaydınız başarıyla gönderildi.'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Tamam'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            })
                                .catchError((error) {
                              // ignore: avoid_print
                              print('Veri kaydedilirken bir hata oluştu: $error');
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Hata'),
                                  content: const Text('Lütfen tüm alanları doldurun.'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Tamam'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurple,
                            minimumSize: const Size(200, 45),
                          ),
                          child: const Text('Gönder'),
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const YanMenu(),
    );
  }
}