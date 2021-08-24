import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = 'profile';

  const ProfileScreen({Key? key}) : super(key: key);
  final double width = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo3.png',
          height: 40,
        ),
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: 220.0,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/back.png',
                    ),
                  ),
                ),
              ),
              Container(
                height: 220.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Theme.of(context).accentColor.withOpacity(0.2),
                      Theme.of(context).accentColor.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -width*0.4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/person.jpg',
                      fit: BoxFit.cover,
                      height: width,
                      width: width,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: width*0.4),
          Text('أحمد السنوار', style:  Theme.of(context).textTheme.headline3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, color: Theme.of(context).accentColor,),
              Text('الشيخ رضوان', style:  Theme.of(context).textTheme.headline2,),
            ],
          ),
        ],
      ),
    );
  }
}