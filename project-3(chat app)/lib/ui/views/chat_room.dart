import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatRoom extends StatefulWidget {
  var userEmail;
  var userName;
  Map<String, dynamic>? userMap;
  String? chatRoomId;

  ChatRoom(
      {required this.userEmail,
      required this.userName,
      required this.chatRoomId,
      required this.userMap});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  //message controller
  final TextEditingController _messageController = TextEditingController();
  //firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //select image type
  File? imageFile;

//select image
  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker
        .pickImage(source: ImageSource.gallery, imageQuality: 30)
        .then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  //for creating unique file name
  String fileName = Uuid().v1();
  //upload image in storage & save into firestore
  Future uploadImage() async {
    int status = 1;
    //add empty message in firesore
    await _firestore
        .collection('chatroom')
        .doc(widget.chatRoomId)
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": _auth.currentUser!.displayName,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });
    //put image in firebase storage
    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");
    
    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      //If shows any error then delete this message
      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .doc(fileName)
          .delete();
      status = 0;
    });
    //When successfully uploaded image in firebase storage then it will works
    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      //update empty message
      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});
      //added current/send user recent list
      await _firestore
          .collection('recent')
          .doc('0000')
          .collection(widget.userEmail)
          .doc(widget.userMap!['email'])
          .set({
        'email': widget.userMap!['email'],
        'name': widget.userMap!['name']
      });
      //added reciever user recent list
      await _firestore
          .collection('recent')
          .doc('0000')
          .collection(widget.userMap!['email'])
          .doc(widget.userEmail)
          .set({'email': widget.userEmail, 'name': widget.userName});
  }
  }

  //send text message
  void onSendMessage() async {
    if (_messageController.text.isNotEmpty) {
      //added data in map
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser!.displayName,
        "message": _messageController.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };
      //clear txtfield
      _messageController.clear();
      //add messages in firestore
      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .add(messages);
      //added current/send user recent list
      await _firestore
          .collection('recent')
          .doc('0000')
          .collection(widget.userEmail)
          .doc(widget.userMap!['email'])
          .set({
        'email': widget.userMap!['email'],
        'name': widget.userMap!['name']
      });
      //added reciever user recent list
      await _firestore
          .collection('recent')
          .doc('0000')
          .collection(widget.userMap!['email'])
          .doc(widget.userEmail)
          .set({'email': widget.userEmail, 'name': widget.userName});
      } else {
      Fluttertoast.showToast(msg: "Please Type message");
    }
  }

  @override
  Widget build(BuildContext context) {
    //mediaquery size
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.blue)),

        title: Text(
          widget.userMap!['name'],
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 15,
          right: 15,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //all msg show up 
              Container(
                height: size.height / 1.30,
                width: size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('chatroom')
                      .doc(widget.chatRoomId)
                      .collection('chats')
                      .orderBy("time", descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> map = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          return Align(
                              alignment: Alignment.bottomCenter,
                              child: messages(size, map, context));
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              //msg textfield part
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      maxLines: 1,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 236, 235, 239),
                          //for send image
                          suffixIcon: IconButton(
                            onPressed: () => getImage(),
                            icon: const Icon(
                              Icons.photo,
                              color: Colors.blue,
                            ),
                          ),
                          hintText: "Send Message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          )),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                      onPressed: onSendMessage),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return map['type'] == 'text'
        //text message ui
        ? Container(
            width: size.width,
            alignment: map['sendby'] == _auth.currentUser!.displayName
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: map['sendby'] == _auth.currentUser!.displayName
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(15))
                    : const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(15)),
                color: map['sendby'] == _auth.currentUser!.displayName
                    ? Colors.blue
                    : const Color.fromARGB(255, 223, 220, 231),
              ),
              child: Text(
                map['message'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: map['sendby'] == _auth.currentUser!.displayName
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          )
         //image message ui
            : Container(
                height: size.height / 3.5,
                width: size.width,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                alignment: map['sendby'] == _auth.currentUser!.displayName
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  height: size.height / 3.5,
                  width: size.width / 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: map['message'] != "" ? null : Alignment.center,
                  child: map['message'] != ""
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            map['message'],
                            fit: BoxFit.fill,
                          ),
                        )
                      : const CircularProgressIndicator(),
                ));
  }
}
