import 'package:akilli_yurt/pages/ariza_kaydi.dart';
import 'package:akilli_yurt/pages/diger_islemler.dart';
import 'package:akilli_yurt/pages/yemek_listesi.dart';
import 'package:akilli_yurt/screens/home/home_screen.dart';
import 'package:akilli_yurt/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

class YanMenu extends StatelessWidget {
  const YanMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: Drawer(
        
        backgroundColor: Colors.white,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/logoo.png'),
            Expanded(
              child:ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.local_laundry_service),
                    title: const Text(
                      'Çamaşır Randevusu',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen())
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.edit_note),
                    title: const Text(
                      'Arıza Kaydı',
                      style: TextStyle(
                        fontSize: 17,
                        ),
                      ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ArizaKaydi())
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.food_bank),
                    title: const Text(
                      'Yemek Listesi',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const YemekListesi())
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.alt_route_sharp),
                    title: const Text(
                      'Diğer İşlemler',
                      style: TextStyle(
                        fontSize: 17,
                        ),
                      ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DigerIslemler())
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      'Çıkış Yap',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WelcomeScreen())
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}