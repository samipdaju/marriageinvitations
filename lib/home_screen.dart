import 'package:flutter/material.dart';
import 'package:flutter_app_offline/edit_screen.dart';
import 'package:flutter_app_offline/setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'extracts/extracted.dart';

import 'package:translator/translator.dart';

import 'database/database.dart';
import 'model/invite.dart';

class InviteApp extends StatefulWidget {
  @override
  _InviteAppState createState() => _InviteAppState();
}

class _InviteAppState extends State<InviteApp> {
  Future<void> customLaunch(command) async {
    if (await canLaunch(command)) {
      print("launched $command");
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  List<INVITE> inviteList = [];

  // prints Eu amo o Brasil!

  // prints Eu amo o Brasil!
  Color eyeColor = Color(0xffCCCCCC);
  Color checkColor = Color(0xffCCCCCC);

  bool insertData = false;
  bool statusValue = true;

  String nameValue = "";
  String numValue = "";
  String addressValue = "";

  String appTitle = "Invitation List";
  String address = "";
  String coming = "";
  String notComing = "";
  String name = "";

  Future<List<INVITE>> getInvite() async {
    inviteList = await DB.getInvitations();

    setState(() {});

    if (inviteList != null) {
      return inviteList;
    }

    return null;
  }

  @override
  void initState() {
    getInvite();
    getuserPref();

    super.initState();

// prints Hola
  }

  getuserPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String langPref = prefs.getString("lang") ?? "Eng";

    if (langPref == "Eng") {
// prints Hola

      appTitle = "Invitation List";
      address = "Address";
      coming = "Coming";
      notComing = "Not Coming";
    } else if (langPref == "Nep") {
      appTitle = "आमंत्रण सूची";
      address = "ठेगाना";
      coming = "आउने";
      notComing = "नआउने";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff780017),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/marriage.png"), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 50,
                        ),
                        color: Color(0xffBF933B),
                        onPressed: () {
                          setState(() {
                            insertData = true;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        icon: Icon(Icons.settings,
                            size: 50, color: Color(0xffBF933B)),
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingScreen()));

                          getuserPref();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Visibility(
                  visible: insertData,
                  child: Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 70,
                            ),
                            Heading("Guest Name"),
                            TextFields(
                              onPress: (value) {
                                nameValue = value;
                              },
                              label: "Enter a name",
                            ),
                            Heading("Guest Number"),
                            TextFields(
                              onPress: (value) {
                                numValue = value;
                              },
                              label: "Enter a number",
                            ),
                            Heading("Guest Address"),
                            TextFields(
                              onPress: (value) {
                                addressValue = value;
                              },
                              label: "Enter an address",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 30),
                                Expanded(
                                  flex: 9,
                                  child: Text(
                                    statusValue ? 'Coming' : "Not Coming",
                                    style: TextStyle(
                                        color: Color(0xffBF933B),
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Checkbox(
                                      value: statusValue,
                                      onChanged: (value) {
                                        setState(() {
                                          statusValue = value;
                                        });
                                      }),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () async {
                                  INVITE todoApp = INVITE(
                                      name: nameValue,
                                      isComplete: false,
                                      num: numValue,
                                      address: addressValue,
                                      status: statusValue.toString());

                                  await DB.insert(todoApp);
                                  setState(() {
                                    insertData = false;
                                  });

                                  getInvite();
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Color(0xffBF933B),
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !insertData,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  appTitle,
                                  style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: eyeColor,
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      getInvite();
                                      setState(() {
                                        if (eyeColor == Color(0xffCCCCCC)) {
                                          eyeColor = Colors.black;
                                        } else if (eyeColor == Colors.black) {
                                          eyeColor = Color(0xffCCCCCC);
                                        }
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 1,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !insertData,
                  child: Expanded(
                    child: Container(
                        child: inviteList != null
                            ? ListView.builder(
                                itemBuilder: (context, position) {
                                  return Container(
                                      child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    inviteList[position].name,

//

                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  ListTile(
                                                      leading: Icon(
                                                        Icons.phone,
                                                        size: 35,
                                                        color:
                                                            Color(0xff80C904),
                                                      ),
                                                      title: eyeColor ==
                                                              Colors.black
                                                          ? Text(
                                                              "",
                                                            )
                                                          : GestureDetector(
                                                              onTap: () {
                                                                print("YES");
                                                                customLaunch(
                                                                    "tel: +977 ${inviteList[position].num}");
                                                              },
                                                              child: Text(
                                                                inviteList[position].num,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        25,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline),
                                                              ),
                                                            )),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "$address : ${inviteList[position].address}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 26,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    inviteList[position]
                                                                .status ==
                                                            "true"
                                                        ? " - $coming"
                                                        : " - $notComing",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Color(0xffCCCCCC),
                                                  ),
                                                  onPressed: () async {
                                                    var response =
                                                        await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditScreen(
                                                                          invite:
                                                                              inviteList[position],
                                                                        )));

                                                    getInvite();
                                                  }),
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Color(0xffCCCCCC),
                                                  ),
                                                  onPressed: () async {
                                                    await DB.delete(
                                                        inviteList[position]
                                                            .id);
                                                    getInvite();
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        height: 1,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ));
                                },
                                itemCount: inviteList.length)
                            : Container()),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
