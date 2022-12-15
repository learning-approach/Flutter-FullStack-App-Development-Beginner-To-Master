
import 'package:http/http.dart' as http;
import 'package:learning_approach/model/comment.dart';

class CommentHelper{
  Future<List<Comment>?> getComments()async{
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    if (response.statusCode==200) {
      var data = response.body;
      print(data);
      return commentFromJson(data);
    }
  }
}