import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Classes/Meal.dart';
import '../Classes/UserData.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({Key? key}) : super(key: key);

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  List<Meal> meals = [];
  late String mealName;
  late String mealType;
  late String calories;
  late int weight;

  void addMeal() {
    if (mealName != null && mealType != null && calories != null) {
      Meal meal = Meal(
        mealName: mealName,
        mealType: mealType,
        calories: int.parse(calories),
      );
      setState(() {
        meals.add(meal);
        mealName = '';
        mealType = '';
        calories = '';
      });
    }
  }

  void showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Başarılı!'),
          content: Text('İşlem başarıyla tamamlandı.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  void showCelebrationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('TEBRİKLER!'),
          content: Text(
              'HEDEFİNE BAŞARIYLA ULAŞTIN. SENİ TEBRİK EDERİZ. HEMEN BİR HEDEF DAHA BELİRLE ZAYIFLAMAYA BAŞLA'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  void finishDay() {
    int totalCalories = 0;
    for (var meal in meals) {
      totalCalories += meal.calories;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Günü Bitir'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bugün $totalCalories kalori aldınız.'),
              SizedBox(height: 16),
              Text('Güncel Kilonuzu Girin:'),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen kilonuzu girin';
                  }
                  return null;
                },
                onChanged: (value) {
                  weight = int.parse(value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                setState(() {
                  UserData.setUserKilo(weight.toString());
                  FirebaseFirestore.instance
                      .collection("People")
                      .doc(UserData.getUserUid())
                      .update({
                    'kilo': weight.toString(),
                  });
                  meals.clear();
                  for (int i = 0; i < UserData.pastKilos.length; i++) {
                    if (UserData.pastKilos[i] == null) {
                      UserData.updateChartValue(i, weight.toString());
                      break;
                    } else if (UserData
                            .pastKilos[UserData.pastKilos.length - 1] !=
                        null) {
                      UserData.setPastKilos();
                      UserData.updateChartValue(0, weight.toString());
                      break;
                    }
                  }
                });
                Navigator.of(context).pop();
                if (int.parse(UserData.getUserTargetKilo!) >=
                    int.parse(UserData.getUserKilo!)) {
                  UserData.setUserTargetKilo(null.toString());
                  UserData.setUserGap("0");
                  showCelebrationPopup(context);
                } else {
                  showSuccessPopup(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Günlük Yemekler'),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: meals.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsetsDirectional.all(15),
            decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ListTile(
              title: Text(meals[index].mealName),
              trailing: Text('Kalori: ${meals[index].calories}'),
              subtitle: Text('Hangi Yemekte Yendi: ${meals[index].mealType}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMealDetailsScreen()),
          ).then((value) {
            if (value != null) {
              setState(() {
                mealName = value['mealName'];
                mealType = value['mealType'];
                calories = value['calories'];
                addMeal();
              });
            }
          });
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
            child: Text('Günü Bitir'),
            onPressed: () {
              finishDay();
            },
          ),
        ),
      ),
    );
  }
}

class AddMealDetailsScreen extends StatefulWidget {
  @override
  _AddMealDetailsScreenState createState() => _AddMealDetailsScreenState();
}

class _AddMealDetailsScreenState extends State<AddMealDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late String mealName;
  late String mealType;
  late String calories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek Detayları'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Yemek Adı'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen yemek adını girin';
                  }
                  return null;
                },
                onSaved: (value) {
                  mealName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Hangi Yemekte Yendiği'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen yemekte yendiği bilgisini girin';
                  }
                  return null;
                },
                onSaved: (value) {
                  mealType = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Kalori'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen kalori miktarını girin';
                  }
                  return null;
                },
                onSaved: (value) {
                  calories = value!;
                },
              ),
              ElevatedButton(
                child: Text('Kaydet'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Map<String, String> mealDetails = {
                      'mealName': mealName,
                      'mealType': mealType,
                      'calories': calories,
                    };
                    Navigator.pop(context, mealDetails);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
