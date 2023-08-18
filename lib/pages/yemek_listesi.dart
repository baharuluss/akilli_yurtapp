import 'package:akilli_yurt/yanmenu.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haftanın Günleri',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,

      ),
      home: const YemekListesi(),
    );
  }
}

class YemekListesi extends StatelessWidget {
  const YemekListesi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd4c4e9),
      appBar: AppBar(

        title: const Text(
          'Yemek Listesi',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(
            height: 50,
          ), //2/6

          const Center(
            child: Text(
              "Haftalık Yemek Listesi",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildExpansionTile('Pazartesi', ['domates/brokoli çorba, tavuk yahni/karnabahar, salçalı spagetti, ayran']),
          _buildExpansionTile('Salı', ['tarhana/mantar çorba, etli nohut/taze fasulye, sehriyeli pirinç pilavı, meyve']),
          _buildExpansionTile('Çarşamba', ['yayla/mercimek çorba, tavuk külbastı/bezelye, bulgur pilavı, pembe sultan']),
          _buildExpansionTile('Perşembe', ['toyga/şehriye çorba, et sote/patates yemeği, pirinç pilavı, salata']),
          _buildExpansionTile('Cuma', ['ezogelin/havuç çorba, kıymalı ıspanak, mantar sote, peynirli tepsi böreği, hoşaf']),
          _buildExpansionTile('Cumartesi', ['mısır/yeşil mercimek çorba, tavuk baget ve patates kızartması/patlıcan yemeği, pilav, yoğurt']),
          _buildExpansionTile('Pazar', ['domates/yoğurt  çorba, ızgara köfte/pırasa yemeği, peynirli makarna, pancar salata',]),
        ],
      ),
      drawer: const YanMenu(),
    );
  }

  Widget _buildExpansionTile(String title, List<String> children) {
    return Card(
      color: Colors.deepPurple.shade200,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        

      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            
          ),
        ),
        collapsedTextColor: Colors.deepPurple,
        textColor: Colors.deepPurple,
        iconColor: Colors.deepPurple,
        children: children.map((child) => ListTile(title: Text(child))).toList(),

      ),
    );
  }
}

