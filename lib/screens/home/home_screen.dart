import 'package:akilli_yurt/yanmenu.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _currentIndex;
  String? selectedBlok;
  String? adSoyad;
  String? odaNumarasi;
  bool isButtonActive = true;
  bool hasBookedAppointment = false;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<void> checkExistingBooking() async {
    if (hasBookedAppointment) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Hata"),
            content: const Text("Lütfen randevu saatinizi seçiniz."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Tamam"),
              ),
            ],
          );
        },
      );
      return;
    }

    if (adSoyad == null || adSoyad!.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Hata"),
            content: const Text("Lütfen adınızı soyadınızı giriniz."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Tamam"),
              ),
            ],
          );
        },
      );
      return;
    }

    if (odaNumarasi == null || odaNumarasi!.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Hata"),
            content: const Text("Lütfen oda numaranızı ve yatak numaranızı giriniz."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Tamam"),
              ),
            ],
          );
        },
      );
      return;
    }

    // Check if the user already has an appointment for the current date
    final QuerySnapshot existingAppointments = await firestore
        .collection('camasirRandevusu')
        .doc(selectedBlok!)
        .collection('randevular')
        .where('randevuTarihi',
        isEqualTo: DateTime.now().toString().substring(0, 10))
        .where('adSoyad', isEqualTo: adSoyad)
        .get();

    if (existingAppointments.docs.isNotEmpty) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Hata"),
            content: const Text("Zaten bir randevunuz bulunmaktadır."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Tamam"),
              ),
            ],
          );
        },
      );
      return;
    }

    addBooking(firestore);
  }

  Future<void> addBooking(FirebaseFirestore firestore) async {
    String randevuSaati =
        '${_currentIndex! + 8}:00 ${_currentIndex! + 9 > 11 ? "PM" : "AM"}';

    try {
      final CollectionReference bookingCollection =
      firestore.collection('camasirRandevusu');
      final DocumentReference bookingDocument =
      bookingCollection.doc(selectedBlok!);

      await bookingDocument.collection('randevular').add({
        'randevuSaati': randevuSaati,
        'adSoyad': adSoyad,
        'odaNumarasi': odaNumarasi,
        'randevuTarihi': DateTime.now().toString().substring(0, 10),
      });

      // Retrieve the newly added booking from Firestore
      final QuerySnapshot querySnapshot =
      await bookingDocument.collection('randevular').get();
      final List<QueryDocumentSnapshot> bookings = querySnapshot.docs;
      final newBooking = bookings.last;

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Başarılı"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Çamaşır randevunuz oluşturuldu."),
                const SizedBox(height: 10),
                Text('Randevu Saati: ${newBooking['randevuSaati']}'),
                Text('Ad Soyad: ${newBooking['adSoyad']}'),
                Text('Oda Numarası: ${newBooking['odaNumarasi']}'),

              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Tamam"),
              ),
            ],
          );
        },
      );

      setState(() {
        isButtonActive = false;
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd4c4e9),
      appBar: AppBar(
        title: const Text(
          "Çamaşır Randevusu",
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      'Randevu saatinizi seçiniz.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                        _currentIndex == index ? Colors.white : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      color: _currentIndex == index ? Colors.deepPurple : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 8}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _currentIndex == index ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
              childCount: 9,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
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
                onChanged: (value) {
                  setState(() {
                    adSoyad = value;
                  });
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
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
                onChanged: (value) {
                  setState(() {
                    odaNumarasi = value;
                  });
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
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
                      Radio<String>(
                        value: "Ayşe Tok Bloğu",
                        groupValue: selectedBlok,
                        onChanged: (value) {
                          setState(() {
                            selectedBlok = value;
                          });
                        },
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
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ElevatedButton(
                onPressed: isButtonActive ? checkExistingBooking : null,

                style: ElevatedButton.styleFrom(
                  backgroundColor: _currentIndex != null &&
                      adSoyad != null &&
                      adSoyad!.isNotEmpty &&
                      odaNumarasi != null &&
                      odaNumarasi!.isNotEmpty &&
                      isButtonActive
                      ? Colors.deepPurple
                      : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Randevu Al"),
              ),
            ),
          ),
        ],
      ),
      drawer: const YanMenu(),
    );
  }
}
