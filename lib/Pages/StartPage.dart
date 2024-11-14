import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../Classes/UserData.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String? userGender;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController kilosController = TextEditingController();
  final TextEditingController VKIController = TextEditingController();
  final TextEditingController fatRatioController = TextEditingController();
  final TextEditingController waistRatioController = TextEditingController();
  final TextEditingController hipRatioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ol"),
        centerTitle: true,
      ),
      body: Container(
        height: 450,
        width: 390,
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsetsDirectional.only(start: 30, end: 30),
        margin: EdgeInsetsDirectional.only(start: 10, top: 30),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Adınız",
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 10),
                  width: 140,
                  height: 40,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.female_outlined),
                    label: Text("KADIN"),
                    style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                      backgroundColor: MaterialStatePropertyAll(
                        userGender == 'KADIN' ? Colors.green : Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        userGender = 'KADIN';
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: surnameController,
                    decoration: InputDecoration(
                      hintText: "Soyadınız",
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 10),
                  width: 140,
                  height: 40,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.male_outlined),
                    style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                      backgroundColor: MaterialStatePropertyAll(
                        userGender == 'ERKEK' ? Colors.green : Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        userGender = 'ERKEK';
                      });
                    },
                    label: Text("ERKEK"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: kilosController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Kilonuz",
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                SizedBox(width: 40),
                Expanded(
                  child: TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Yaşınız",
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: VKIController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "VKİ",
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                SizedBox(width: 40),
                Expanded(
                  child: TextFormField(
                    controller: fatRatioController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Yağ Oranınız",
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: waistRatioController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Bel Oranınız",
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                SizedBox(width: 40),
                Expanded(
                  child: TextFormField(
                    controller: hipRatioController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Kalça Oranınız",
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              padding: EdgeInsetsDirectional.only(start: 240),
              child: ElevatedButton(
                  onPressed: () {
                    UserData.setUserUid(Uuid().v4());
                    UserData.setUserName(nameController.text);
                    UserData.setUserSurname(surnameController.text);
                    UserData.setUserGender(userGender!);
                    UserData.setUserKilo(kilosController.text);
                    UserData.setUserAge(ageController.text);
                    UserData.setUserVKI(VKIController.text);
                    UserData.setUserFatRatio(fatRatioController.text);
                    UserData.setUserWaistRatio(waistRatioController.text);
                    UserData.setUserHipRatio(hipRatioController.text);
                    UserData.setUserSingIn(true);
                    UserData.updateChartValue(0, kilosController.text);
                    FirebaseFirestore.instance
                        .collection("People")
                        .doc(UserData.getUserUid())
                        .set({
                      'name': nameController.text,
                      'surname': surnameController.text,
                      'gender': userGender,
                      'kilo': kilosController.text,
                      'age': ageController.text,
                      'VKI': VKIController.text,
                      'fat ratio': fatRatioController.text,
                      'waist ratio': waistRatioController.text,
                      'hip ratio': hipRatioController.text,
                      'is sign in': true,
                    }).whenComplete(
                            () => Navigator.popAndPushNamed(context, "/main"));
                  },
                  child: Text("Kayıt ol")),
            ),
          ],
        ),
      ),
    );
  }
}
