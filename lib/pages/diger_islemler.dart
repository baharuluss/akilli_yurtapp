import 'package:akilli_yurt/yanmenu.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DigerIslemler extends StatefulWidget {
  const DigerIslemler({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DigerIslemlerState createState() => _DigerIslemlerState();
}

final Uri _url1 = Uri.parse('https://kyk.ziraatbank.com.tr/?tip=y');
final Uri _url2 = Uri.parse('https://play.google.com/store/apps/details?id=com.gsb.genciz.biz&hl=tr&gl=US&pli=1');
final Uri _url3 = Uri.parse('https://www.instagram.com/etkinlikyurdu2021/#');

class _DigerIslemlerState extends State<DigerIslemler> {
  Future<void> _launchUrl1() async{
    if(!await launchUrl(_url1)) {
      throw Exception('Linke yönlendirme yapılamadı $_url1');
    }
  }
  Future<void> _launchUrl2() async{
    if(!await launchUrl(_url2)) {
      throw Exception('Linke yönlendirme yapılamadı $_url2');
    }
  }
  Future<void> _launchUrl3() async{
    if(!await launchUrl(_url3)) {
      throw Exception('Linke yönlendirme yapılamadı $_url3');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd4c4e9),
      appBar: AppBar(
        title: const Text(
          "Diğer İşlemler",
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Center(
                  child: Text(
                    "Yurt Aidatı Ödeme",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: CardButton(
                    onPressed: () => _launchUrl1(),
                    label: "Ziraat Uygulamasına Yönlendiriliyorsun",
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Center(
                  child: Text(
                    "Yurt İzin Alma Sistemi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: CardButton(
                    onPressed: () => _launchUrl2(),
                    label: "GencizBiz'e Yönlendiriliyorsun",
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Center(
                  child: Text(
                    "Güncel Duyurular",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: CardButton(
                    onPressed: () => _launchUrl3(),
                    label: "İnstagram'a Yönlendiriliyorsun",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const YanMenu(),
    );
  }
}

class CardButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const CardButton({super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(

          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}
