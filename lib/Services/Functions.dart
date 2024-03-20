import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spliter_x/Services/Conts.dart';

Future<void> signUp(String phoneNumber, String firstname, String lastName,
    {String email = ''}) async {
  Map<String, String> transaction = {
    "totalTransactions": "0",
    "spends": "0.0",
    "expense": "0.0"
  };
  await fire.collection("Users").doc(phoneNumber).set({
    'phoneNumber': phoneNumber,
    'firstName': firstname,
    'lastName': lastName,
    'email': email,
    'profileUrl': "",
    'rooms': [],
    'transactions': transaction,
    'timeStamp': DateTime.now()
  });
}

Future<void> addRoom(String adminPhoneNumber, String roomName,
    List<List<String>> roomMembers) async {
  List<Map> tempList = [];
  for (List<String> i in roomMembers) {
    Map<String, String> temp = {};
    temp["phoneNumber"] = i[0];
    temp["Name"] = i[1];
    temp["spends"] = i[2];
    temp["expense"] = i[3];
    tempList.add(temp);
  }
  DocumentReference docRef = fire.collection("Rooms").doc();
  await docRef.set({
    'roomProfileUrl': '',
    'roomId': docRef.id.toString(),
    'name': roomName,
    'admin': {'name': 'Darshan Bhalani', 'phoneNumber': adminPhoneNumber},
    'totalExpenseOfCurrentMonth': '0.0',
    'currentMonthTransactions': tempList,
    'transactionGroups': [],
    'timeStamp': DateTime.now(),
  }).whenComplete(() async {
    for (var i in roomMembers) {
      await fire.collection("Users").doc(i[0]).update({
        'rooms': FieldValue.arrayUnion([docRef.id.toString()])
      });
    }
  });
}

Future<void> addTransactionGroup(String roomId, String? groupName) async {
  List tempList = [];
  await fire.collection("Rooms").doc(roomId).get().then((snap) {
    tempList = snap['currentMonthTransactions'];
  });
  for (var element in tempList) {
    element["spends"] = "0.0";
    element["expense"] = "0.0";
  }
  DocumentReference docRef = fire.collection("TransactionGroups").doc();
  await docRef.set({
    'groupId': docRef.id.toString(),
    'groupName': groupName ??
        "${monthNames[DateTime.now().month - 1]} ${DateTime.now().year} ${docRef.id}",
    'totalExpense': '0.0',
    'currentMonthTransactions': tempList,
    'transactions': [],
    'timeStamp': DateTime.now(),
    'completeTime': null
  }).whenComplete(() async {
    Map<String, dynamic> temp = {};
    temp["Id"] = docRef.id.toString();
    temp["status"] = true;
    await fire.collection("Rooms").doc(roomId).update({
      'transactionGroups': FieldValue.arrayUnion([temp])
    });
  });
}

Future<void> addTransaction(String groupId, String totalAmount,
    String paymentMode, List<List<String>> membersList,
    {String description = "No description added!"}) async {
  List<Map> tempList = [];
  for (var i in membersList) {
    Map<String, String> temp = {};
    temp["phoneNumber"] = i[0];
    temp["name"] = i[1];
    temp["spends"] = i[2];
    temp["expense"] = i[3];
    tempList.add(temp);
  }
  DocumentReference docRef = fire.collection("Transactions").doc();
  await docRef.set({
    'transactionId': docRef.id.toString(),
    'groupId': groupId,
    'description': description,
    'totalAmount': totalAmount,
    'paymentMode': paymentMode,
    'members': tempList,
    'timeStamp': DateTime.now(),
  }).whenComplete(() async {
    List<dynamic> temp = [];
    double total = 0.0;
    await fire.collection("TransactionGroups").doc(groupId).get().then((value) {
      temp = value["currentMonthTransactions"];
      total = double.parse(value["totalExpense"]);
    });
    for (var i in membersList) {
      total = total + double.parse(i[2].toString());
      for (var j in temp) {
        if (j["phoneNumber"] == i[0]) {
          double tempSpends = double.parse(j["spends"].toString());
          j["spends"] = (tempSpends + double.parse(i[2])).toString();
          double tempExpense = double.parse(j["expense"].toString());
          j["expense"] = (tempExpense + double.parse(i[3])).toString();
        }
      }
    }
    await fire.collection("TransactionGroups").doc(groupId).update({
      'currentMonthTransactions': temp,
      'transactions': FieldValue.arrayUnion([docRef.id.toString()]),
      'totalExpense': total.toString()
    });
  });
}

Future<void> deleteTransaction(String transactionId, String groupId) async {
  List<dynamic> tempList = [];
  await fire.collection("Transactions").doc(transactionId).get().then((value) {
    tempList = value["members"];
  });
  List<dynamic> temp = [];
  double total = 0.0;
  await fire.collection("TransactionGroups").doc(groupId).get().then((value) {
    temp = value["currentMonthTransactions"];
    total = double.parse(value["totalExpense"].toString());
  });
  for (var i in tempList) {
    total = total - double.parse(i["expense"].toString());
    for (var j in temp) {
      if (j["phoneNumber"] == i["phoneNumber"]) {
        double tempSpends = double.parse(j["spends"].toString());
        j["spends"] = (tempSpends - double.parse(i["spends"])).toString();
        double tempExpense = double.parse(j["expense"].toString());
        j["expense"] = (tempExpense - double.parse(i["expense"])).toString();
      }
    }
  }
  await fire.collection("TransactionGroups").doc(groupId).update({
    'currentMonthTransactions': temp,
    'transactions': FieldValue.arrayRemove([transactionId]),
    'totalExpense': total.toString()
  });
  await fire.collection("Transactions").doc(transactionId).delete();
}

Future<void> deleteTransactionGroup(String groupId, String roomId) async {
  DocumentReference documentReference =
      await FirebaseFirestore.instance.collection('Rooms').doc(roomId);
  DocumentSnapshot documentSnapshot = await documentReference.get();
  Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;
  if (data != null && data.containsKey('transactionGroups')) {
    List<dynamic>? groupList = data['transactionGroups'];
    if (groupList != null) {
      await documentReference.update({
        'transactionGroups': FieldValue.arrayRemove([
          for (var map in groupList)
            if (map['Id'] == groupId) map
        ])
      });
    }
  }
  List temp = [];
  await fire.collection("TransactionGroups").doc(groupId).get().then((value) {
    temp = value["transactions"];
  });
  for (var i in temp) {
    await fire.collection("Transactions").doc(i.toString()).delete();
  }
  await fire.collection("TransactionGroups").doc(groupId).delete();
}

Future<void> deleteRoom(String roomId) async {
  List<dynamic>? groupList;
  List<dynamic> memberList = [];
  await fire.collection("Rooms").doc(roomId).get().then((value) {
    groupList = value["transactionGroups"];
    memberList = value["currentMonthTransactions"];
  });
  if (groupList != null) {
    for (var i in groupList!) {
      await deleteTransactionGroup(i["Id"], roomId);
    }
  }
  for (var i in memberList) {
    await fire.collection("Users").doc(i["phoneNumber"]).update({
      'rooms': FieldValue.arrayRemove([roomId])
    });
  }
  await fire.collection("Rooms").doc(roomId).delete();
}

class Log {
  final String phoneNumber;
  final String roomId;
  Log(this.phoneNumber, this.roomId);
}
