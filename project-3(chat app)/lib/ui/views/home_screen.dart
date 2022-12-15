import 'package:chatapp/business_logic/auth.dart';
import 'package:chatapp/const/app_colors.dart';
import 'package:chatapp/ui/route/route.dart';
import 'package:chatapp/ui/views/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //find user added
  Map<String, dynamic>? userMap;
  //user search loader
  bool isLoading = false;
  //auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //find user search controller
  final TextEditingController _searchController = TextEditingController();
   //search user
  void onUserSearch() async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      setState(() {
        isLoading = true;
      });

      await _firestore
          .collection('users')
          .where("email", isEqualTo: _searchController.text)
          .get()
          .then(
        (value) {
          setState(() {
            userMap = value.docs[0].data();
            isLoading = false;
          });
          print(userMap);
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'failed');
    }
  }
  //create unique chatroom id
  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat Home",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.caribbeanGreen,
        actions: [
          IconButton(
            onPressed: () => Auth().signOut(),
            icon: Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 20,
        ),
        child: Column(
          children: [
            //search textfield
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search",
                suffixIcon: IconButton(
                  onPressed: () {
                    onUserSearch();
                    _searchController.clear();
                  },
                  icon: Icon(
                    Icons.search_outlined,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            userMap != null
                ? ListTile(
                    onTap: () {
                      //passing data chatroom screen
                      String roomId = chatRoomId(
                          _auth.currentUser!.displayName!, userMap!['name']);
                      Get.toNamed(chatRoom,
                          arguments: ChatRoom(
                            userEmail: _auth.currentUser!.email,
                            userName: _auth.currentUser!.displayName!,
                            chatRoomId: roomId,
                            userMap: userMap!,
                          ));
                    },
                    leading: CircleAvatar(
                      child: Center(
                        child: Icon(
                          Icons.person_outline,
                          size: 20,
                        ),
                      ),
                    ),
                    title: Text(
                      userMap!['name'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(userMap!['email']),
                    trailing: const Icon(
                      Icons.chat_bubble_outline,
                      size: 20,
                    ),
                  )
                : Container(),

            SizedBox(
              height: 30,
            ),
            Divider(
              height: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            Align(alignment: Alignment.topLeft, child: Text("Recent")),
            //already chat user list
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('recent')
                  .doc('0000')
                  .collection(_auth.currentUser!.email.toString(),)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(child: const Text("Error"));
                } else if (snapshot.hasData) {
                  var data = snapshot.data.docs;

                  return Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var indexData = data![index];

                          Map<String, dynamic> data2 = indexData.data();
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 223, 220, 231),
                                  borderRadius: BorderRadius.circular(7)),
                              child: ListTile(
                                onTap: () {
                                  String roomId = chatRoomId(
                                      _auth.currentUser!.displayName!,
                                      indexData['name']);

                                  Get.toNamed(chatRoom,
                                      arguments: ChatRoom(
                                        userEmail: _auth.currentUser!.email,
                                        userName:
                                            _auth.currentUser!.displayName,
                                        chatRoomId: roomId,
                                        userMap: data2,
                                      ));
                                },
                                leading: const CircleAvatar(
                                  child: Center(
                                    child: Icon(Icons.person_outlined,
                                        size: 17, color: Colors.white),
                                  ),
                                ),
                                title: Text(indexData['name']),
                                subtitle: Text(indexData['email']),
                                trailing: const Icon(
                                  Icons.chat_outlined,
                                  size: 17,
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
