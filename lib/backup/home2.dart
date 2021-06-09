// import 'package:flutter/material.dart';
// import 'package:flutter_app_offline/database/database.dart';
// import 'package:flutter_app_offline/edit_screen.dart';
// import 'package:flutter_app_offline/model/invite.dart';
// import 'package:flutter_app_offline/setting_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
// class InviteApp extends StatefulWidget {
//   @override
//   _InviteAppState createState() => _InviteAppState();
// }
//
// class _InviteAppState extends State<InviteApp> {
//   List<INVITE> inviteList = [];
//
//   Color eyeColor = Colors.black;
//
//
//   bool insertData = false;
//
//   String nameValue = "";
//   String numValue="";
//   String addressValue="";
//
//   String appTitle = "Invitation List";
//
//   Future<List<INVITE>> getInvite() async {
//     inviteList = await DB.getInvitations();
//
//     setState(() {});
//
//     if (inviteList != null) {
//       return inviteList;
//     }
//
//     return null;
//   }
//
//   @override
//   void initState() {
//     getInvite();
//     getuserPref();
//
//     super.initState();
//   }
//
//   getuserPref() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     String langPref = prefs.getString("lang") ?? "Eng";
//
//     if (langPref == "Eng") {
//       appTitle = "Invitation List";
//     } else if (langPref == "Nep") {
//       appTitle = "आमंत्रण सूची";
//     }
//
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xff780017),
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage("assets/marriage.png"), fit: BoxFit.cover),
//           ),
//           child: SafeArea(
//             child: Column(
//               children: [
//
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         icon: Icon(
//                           Icons.add,
//                           size: 50,
//                         ),
//                         color: Color(0xffBF933B),
//                         onPressed: () {
//                           setState(() {
//                             insertData = true;
//                           });
//                         },
//                       ),
//                       SizedBox(width: 10,),
//                       IconButton(
//                         icon: Icon(Icons.settings,
//                             size: 50, color: Color(0xffBF933B)),
//                         onPressed: () async {
//                           await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => SettingScreen()));
//
//                           getuserPref();
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Visibility(
//                   visible: insertData,
//                   child: Expanded(
//                       child: Expanded(
//                         child: Container(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Guest Name',
//                                 style: TextStyle(
//                                     color: Color(0xffBF933B),
//                                     fontSize: 35,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 5.0),
//                                 child: TextField(
//                                   style: TextStyle(
//                                       fontSize: 25, color: Color(0xffCCCCCC)),
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(),
//                                     labelText: "Enter a name",
//                                     labelStyle: TextStyle(
//                                       fontSize: 25,
//                                       color: Color(0xffCCCCCC),
//                                     ),
//                                   ),
//                                   onChanged: (value) {
//                                     nameValue = value;
//                                   },
//                                 ),
//                               ),
//                               Text(
//                                 'Guest Number',
//                                 style: TextStyle(
//                                     color: Color(0xffBF933B),
//                                     fontSize: 35,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 5.0),
//                                 child: TextField(
//                                   style: TextStyle(
//                                       fontSize: 25, color: Color(0xffCCCCCC)),
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(),
//                                     labelText: "Enter a number",
//                                     labelStyle: TextStyle(
//                                       fontSize: 25,
//                                       color: Color(0xffCCCCCC),
//                                     ),
//                                   ),
//                                   onChanged: (value) {
//                                     numValue = value;
//                                   },
//                                 ),
//                               ),
//                               Text(
//                                 'Guest Address',
//                                 style: TextStyle(
//                                     color: Color(0xffBF933B),
//                                     fontSize: 35,
//                                     fontWeight: FontWeight.bold),
//                               ),
//
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 5.0),
//                                 child: TextField(
//                                   style: TextStyle(
//                                       fontSize: 25, color: Color(0xffCCCCCC)),
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(),
//                                     labelText: "Enter address",
//                                     labelStyle: TextStyle(
//                                       fontSize: 25,
//                                       color: Color(0xffCCCCCC),
//                                     ),
//                                   ),
//                                   onChanged: (value) {
//                                     addressValue = value;
//
//                                   },
//                                 ),
//                               ),
//                               TextButton(
//                                   onPressed: () async {
//                                     INVITE todoApp =
//                                     INVITE(name: nameValue, isComplete: false,address: addressValue,num: numValue);
//
//                                     await DB.insert(todoApp);
//                                     setState(() {
//                                       insertData = false;
//                                     });
//
//                                     getInvite();
//                                   },
//                                   child: Text(
//                                     'Save',
//                                     style: TextStyle(
//                                         color: Color(0xffBF933B),
//                                         fontSize: 35,
//                                         fontWeight: FontWeight.bold),
//                                   )),
//
//                             ],
//                           ),
//                         ),
//                       )),
//                 ),
//                 Visibility(
//                   visible: !insertData,
//                   child: Container(
//
//
//                     child: Column(
//
//                       children: [
//                         SizedBox(height: 100,),
//
//                         Container(
//                           child: Text(
//                             appTitle,
//                             style: TextStyle(
//                               fontSize: 40,
//                               color: Color(0xffCCCCCC),
//                               fontStyle: FontStyle.italic,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20,)
//
//                       ],
//                     )
//
//                     ,
//                   ),
//                 ),
//
//
//
//                 Visibility(
//                   visible: !insertData,
//                   child: Expanded(
//
//                     child: Container(
//
//                         child: inviteList != null
//                             ? ListView.builder(
//                             itemBuilder: (context, position) {
//                               return Container(
//                                   child: Column(
//
//                                     children: [
//                                       SizedBox(height: 30,),
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 8.0),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                           children: [
//
//                                             Expanded(
//
//                                               flex: 6,
//                                               child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//
//                                                   Text(
//                                                     inviteList[position].name,
//                                                     style: TextStyle(
//                                                         color: Color(0xffCCCCCC),
//                                                         fontSize: 35,
//                                                         fontWeight: FontWeight.bold),
//                                                   ),
//                                                   SizedBox(height: 10,),
//                                                   Text(eyeColor==Colors.black?"Num:":"Num: ${inviteList[position].num}",
//                                                     style: TextStyle(
//                                                       color: Color(0xffCCCCCC),
//                                                       fontSize: 25,
//                                                     ),),
//                                                   SizedBox(height: 10,),
//                                                   Text("Address: ${inviteList[position].address} ",
//                                                     style: TextStyle(
//                                                       color: Color(0xffCCCCCC),
//                                                       fontSize: 25,
//                                                     ),),
//                                                 ],
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: IconButton(
//                                                   icon: Icon(
//                                                     Icons.edit,
//                                                     color: Color(0xffCCCCCC),
//                                                   ),
//                                                   onPressed: () async {
//                                                     var response =
//                                                     await Navigator.push(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                             builder:
//                                                                 (context) =>
//                                                                 EditScreen(
//                                                                   invite:
//                                                                   inviteList[position],
//                                                                 )));
//
//                                                     getInvite();
//                                                   }),
//                                             ),
//                                             Expanded(
//                                               child: IconButton(
//                                                   icon: Icon(
//                                                     Icons.delete,
//                                                     color: Color(0xffCCCCCC),
//                                                   ),
//                                                   onPressed: () async {
//                                                     await DB.delete(
//                                                         inviteList[position].id);
//                                                     getInvite();
//                                                   }),
//                                             ),
//                                             Expanded(
//                                               child: IconButton(
//                                                   icon: Icon(
//                                                     Icons.remove_red_eye,
//                                                     color: eyeColor,
//                                                   ),
//                                                   onPressed: ()  {
//                                                     setState(() {
//                                                       if(eyeColor == Color(0xffCCCCCC) ){
//                                                         eyeColor = Colors.black;
//                                                       }
//                                                       else if(eyeColor == Colors.black){
//                                                         eyeColor = Color(0xffCCCCCC);
//                                                       }
//
//                                                     });
//
//                                                   }),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//
//                                     ],
//                                   ));
//                             },
//                             itemCount: inviteList.length)
//                             : Container()),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
