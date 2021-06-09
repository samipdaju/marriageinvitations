class INVITE{
  int id;
  String name;
  bool isComplete;
  String num;
  String address;


  INVITE({this.isComplete,this.name,this.id,this.num,this.address});



  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "taskName": this.name,
      "isComplete":this.isComplete,
      "guestNum": this.num,
      "guestAddress": this.address
    };

    return map;



  }




}