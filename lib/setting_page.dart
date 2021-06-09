import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {


  String appTitle="";



  @override
  void initState() {
    getuserPref();
    super.initState();
  }



  getuserPref() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String langPref =  prefs.getString("lang")?? "Eng";


    if(langPref=="Eng"){
      appTitle = "Settings";
    }

    else if (langPref=="Nep"){
      appTitle = "सेटिंग";
    }

    setState(() {

    });


  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff780017),

      appBar: AppBar(title: Text(appTitle,
        style: TextStyle(
        fontSize: 25,),),
      centerTitle: true,
      backgroundColor: Color(0xff780017),),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/marriage.png"),
            fit: BoxFit.fill
          )
        ),
        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text('Choose a language:',
            style: TextStyle(
              fontSize: 35,
              color: Color(0xffBF933B),
              fontWeight: FontWeight.bold

            ),),
              SizedBox(
                height: 10,
              ),

              TextButton(onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

              prefs.setString("lang", "Nep");

                getuserPref();


              }, child: Text('नेपाली',
              style: TextStyle(
                fontSize: 35,
                color: Color(0xffBF933B),
              ),)),

              TextButton(onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                prefs.setString("lang", "Eng");
                getuserPref();


              }, child: Text('English',style: TextStyle(
                  fontSize: 35,
                color: Color(0xffBF933B),
              ),)),
              Text('Show phone number ',
                style: TextStyle(
                    fontSize: 35,
                    color: Color(0xffBF933B),
                    fontWeight: FontWeight.bold

                ),),
              TextButton(onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                prefs.setString("lang", "Nep");

                getuserPref();


              }, child: Text('Yes',
                style: TextStyle(
                  fontSize: 35,
                  color: Color(0xffBF933B),
                ),)),



            ],
          ),
        ),
      ),

    );
  }
}
