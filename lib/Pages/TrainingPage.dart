import 'package:flutter/material.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  @override
  Widget build(BuildContext context) {
    List<String> egserzise = [
      'Şınav',
      'Mekik',
      'Plank',
      'Squat',
      'Lunge',
      'Leg Raises',
      'Russian Twist',
    ];

    List<List<String>> description = [
      [
        "Ellerinizi omuz genişliğinde açın ve ayaklarınızı hafifçe ayırın",
        "Şınav yaparken vücudunuzu yukarı ve aşağı doğru hareket ettireceksiniz",
        "Şınavın en son adımında, nefes vererek ve karın kaslarınızı sıkarak kollarınızı düzleştirin ve vücudunuzu yukarı doğru itin",
        ""
      ],
      [
        "Sırt üstü düz bir zeminde uzanın ve ellerinizi başınızın arkasına yerleştirin.",
        "Karın kaslarınızı sıkarak başınızı ve üst bedeninizi yavaşça yukarı doğru kaldırın",
        "Başınızı ve üst bedeninizi yavaşça yerleştirdiğiniz başlangıç pozisyonuna geri indirin",
        "\n"
      ],
      [
        "Düz bir zeminde elleriniz ve ayak parmak uçlarınız üzerinde, eller omuz genişliğinde olsun",
        "Vücudunuzun düz bir çizgi oluşturmasına dikkat ederek karın kaslarınızı sıkın",
        "Plank pozisyonunu mümkün olduğunca uzun süre boyunca korumaya çalışın",
        "\n"
      ],
      [
        "Ayaklarınızı omuz genişliğinde açarak dik bir duruş alın. Göğsünüzü hafifçe öne doğru iterek pozisyon alın",
        "Nefes alarak yavaşça kalçanızı geriye doğru itin ve çömelme hareketine başlayın. Kalçanızı geriye iterek çömelirken dizlerinizi bükün",
        "Ağırlık merkezinizi topuklarınızda tutarak nefes vererek yavaşça yükselin",
        ""
      ],
      [
        "Ayaklarınızı kalça genişliğinde açın. Kollarınızı bel hizasında tutabilirsiniz.",
        "Öne doğru bir adım atarak bir bacağınızı ileriye doğru uzatın ve ön bacağınızın dizinin 90 derece bükün",
        "Nefes vererek ön bacağınızı iterek başlangıç pozisyonuna geri dönün. Ardından diğer bacağınızla aynı adımları tekrarlayın.",
        ""
      ],
      [
        "Sırt üstü düz bir zeminde uzanın. Kollarınızı yanlara doğru düz ve avuç içleri yere bakacak şekilde yerleştirin",
        "Nefes alarak bacaklarınızı yavaşça kaldırın. Bacaklarınızı dik bir açıyla mümkün olduğunca yukarıya kaldırın",
        "Nefes vererek yavaşça bacaklarınızı indirin",
        ""
      ],
      [
        "Düz bir zeminde oturun ve dizlerinizi hafifçe bükün. Ayaklarınızı yerde sabit tutun",
        "Karın kaslarınızı sıkın ve üst gövdenizi 45 derece açıyla geriye eğin",
        "Kollarınızı sabit tutun ve hareketin kontrolünü elden bırakmadan sağa doğru dönün, ardından sol tarafa dönün. Hareketi her iki tarafa tekrarlayın",
        ""
      ],
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Egzersizler"),
        centerTitle: true,
      ),
      body: Center(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsetsDirectional.all(8),
              itemCount: egserzise.length,
              itemBuilder: (context, index) {
                var containers = egserzise
                    .map((e) => Container(
                          foregroundDecoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                                'Assets/' + egserzise[index] + '.jpg'),
                            fit: BoxFit.cover,
                            opacity: 0.3,
                          )),
                          height: 230,
                          margin: EdgeInsetsDirectional.all(20),
                          child: Card(
                            //margin: EdgeInsetsDirectional.all(8),
                            color: Colors.transparent.withOpacity(0),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsetsDirectional.only(
                                      start: 12, top: 4),
                                  alignment: Alignment.topLeft,
                                  child: Text('\n' + e,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsetsDirectional.only(
                                      start: 12, top: 4),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '\n\n' +
                                        description[index][0] +
                                        '\n' +
                                        description[index][1] +
                                        '\n' +
                                        description[index][2] +
                                        '\n' +
                                        description[index][3],
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList();
                return containers[index];
              })),
    );
  }
}
