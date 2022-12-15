import 'package:flutter/material.dart';
import 'package:learning_approach/helper/comment_helper.dart';
import 'package:learning_approach/model/comment.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Comment>? comments;
  bool isLoaded = false;
  getData()async{
    comments = await CommentHelper().getComments();
    setState(() {
      isLoaded = true;
    });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'learning-approach',
          style: TextStyle(),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: comments?.length??0,
          itemBuilder: (_, index){
            return Card(
              child: ListTile(
                title: Text(comments![index].email),
                subtitle: Text(comments![index].body),
              ),
            );
          },
          ),
      ),
    );
  }
}
