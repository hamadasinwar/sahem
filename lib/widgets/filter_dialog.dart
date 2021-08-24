import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'filter_tile.dart';

class FiltersDialog extends StatefulWidget {
  const FiltersDialog({Key? key}) : super(key: key);

  @override
  State<FiltersDialog> createState() => _FiltersDialogState();
}

class _FiltersDialogState extends State<FiltersDialog> {
  var food = false;
  var clothes = false;
  var devices = false;
  var equipments = false;

  Future<dynamic> getFiltersValue()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      food = prefs.getBool('food')??false;
      clothes = prefs.getBool('clothes')??false;
      devices = prefs.getBool('devices')??false;
      equipments = prefs.getBool('equipments')??false;
    });
  }

  Future<bool> setFilterValue(String key, bool value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(0, 10),
                    blurRadius: 10),
              ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'التصنيفات',
                style: Theme.of(context).textTheme.headline6,
              ),
              const Divider(color: Colors.white, thickness: 2, height: 3),
              const SizedBox(height: 15),
              FutureBuilder(
                future: getFiltersValue(),
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return CircularProgressIndicator(color: Theme.of(context).primaryColor);
                  }else {
                    return Column(
                      children: [
                        FilterTile(
                          title: 'الاطعمة',
                          value: food,
                          onChanged: (value) async {
                            setFilterValue('food', value ?? false).then((_) {
                              setState(() {
                                food = value ?? false;
                              });
                            });
                          },
                        ),
                        FilterTile(
                          title: 'الملابس',
                          value: clothes,
                          onChanged: (value) async {
                            setFilterValue('clothes', value ?? false).then((_) {
                              setState(() {
                                clothes = value ?? false;
                              });
                            });
                          },
                        ),
                        FilterTile(
                          title: 'الأجهزة الكهربائية',
                          value: devices,
                          onChanged: (value) async {
                            setFilterValue('devices', value ?? false).then((_) {
                              setState(() {
                                devices = value ?? false;
                              });
                            });
                          },
                        ),
                        FilterTile(
                          title: 'المعدات',
                          value: equipments,
                          onChanged: (value) async {
                            setFilterValue('equipments', value ?? false).then((
                                _) {
                              setState(() {
                                equipments = value ?? false;
                              });
                            });
                          },
                        ),
                        const SizedBox(height: 22),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith((states) =>
                              const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 15)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Theme.of(context).primaryColor, width: 3.5),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'تم',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
