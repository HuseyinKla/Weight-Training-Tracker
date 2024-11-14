import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weight_training_tracker/Classes/UserData.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _firestore = FirebaseFirestore.instance;
  List<List<String>> egserzise = [
    [
      'Şınav',
      '5 ',
      ' 7',
      ' kere yapılacak',
    ],
    [
      'Mekik',
      '3 ',
      ' 5',
      ' kere yapılacak',
    ],
    [
      'Plank',
      '3 ',
      ' 60',
      ' saniye yapılacak',
    ],
    [
      'Lunge',
      '5 ',
      ' 10',
      ' kere yapılacak',
    ],
    [
      'Leg Raises',
      '3 ',
      ' 6',
      ' kere yapılacak',
    ],
    [
      'Russian Twist',
      '3 ',
      ' 15',
      ' kere yapılacak',
    ],
  ];
  List<String> yapilmislarListesi = [];

  void _tamamlandiOnayi(String gorev) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Emin misiniz?'),
          content: Text('Bu görevi tamamlandı olarak işaretle?'),
          actions: <Widget>[
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                setState(() {
                  egserzise.remove(gorev);
                  yapilmislarListesi.add(gorev);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

    CollectionReference newRef = _firestore.collection('temp');
    var data = newRef.doc('tempData');
    return Scaffold(
      appBar: AppBar(
        title: Text("Günlük Antrenmanlar"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsetsDirectional.all(12),
        margin: EdgeInsetsDirectional.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 2),
          color: Colors.lightBlueAccent[100],
        ),
        child: Column(
          children: [
            Text(
              'Yapılacaklar Listesi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: egserzise.map((yapilacak) {
                    return Card(
                      child: ListTile(
                        title: Text(yapilacak[0]),
                        subtitle: Text((int.parse(yapilacak[1]) *
                                    int.parse(UserData.getUserGap!))
                                .toString() +
                            ' set her set' +
                            yapilacak[2] +
                            yapilacak[3]),
                        trailing: IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Emin misiniz?'),
                                content: Text(
                                    'Bu egzersizi tamamlandı olarak işaretlemek istiyor musunuz?'),
                                actions: [
                                  TextButton(
                                    child: Text('Evet'),
                                    onPressed: () {
                                      setState(() {
                                        egserzise.remove(yapilacak);
                                        yapilmislarListesi.add(yapilacak[0]);
                                      });
                                      Navigator.pop(
                                          context); // Pop-up menüyü kapat
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Hayır'),
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Pop-up menüyü kapat
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(thickness: 1),
            Text(
              'Yapılmışlar Listesi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: yapilmislarListesi.map((yapilmis) {
                    return Card(
                      child: ListTile(
                        title: Text(yapilmis),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
