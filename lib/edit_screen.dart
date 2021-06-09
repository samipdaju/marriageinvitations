import 'package:flutter/material.dart';

import 'database/database.dart';
import 'model/invite.dart';

import 'extracts/extracted.dart';

class EditScreen extends StatefulWidget {
  final INVITE invite;

  EditScreen({this.invite});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String invitations;
  String changeNum;
  String changeAddress;
  bool statusValue = true;

  @override
  void initState() {
    // TODO: implement initState
    invitations = widget.invite.name;
    changeNum = widget.invite.num;
    changeAddress = widget.invite.address;


    super.initState();
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
        child: Center(
          child: SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 140,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,



                  children: [
                    SizedBox(width: 120),

                    Expanded(
                      flex: 6,


                      child: Text(
                        statusValue?'Coming':"Not Coming",
                        style: TextStyle(
                            color: Color(0xffBF933B),
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(

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
                SizedBox(height: 20,),





                Heading("Edit Name"),

                TextFields(hint:widget.invite.name,
                  onPress: (value){
                   invitations = value;

                  },),
                Heading("Edit Number"),
                TextFields(hint:widget.invite.num,
                onPress: (value){
                  changeNum = value;

                },),
                Heading("Edit Address"),
                TextFields(hint:widget.invite.address,
                  onPress: (value){
                    changeAddress = value;

                  },),

                IconButton(
                  icon: Icon(Icons.save),
                  iconSize: 40,
                  color: Color(0xffCCCCCC),
                  onPressed: () async {
                    INVITE todo = INVITE(
                      status: statusValue.toString(),
                      num: changeNum,
                        address: changeAddress,
                        name: invitations,
                        isComplete: widget.invite.isComplete,
                        id: widget.invite.id);

                    await DB.update(todo);

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
