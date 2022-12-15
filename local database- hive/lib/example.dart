import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Example extends StatefulWidget {
  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  Box? notepad;
  @override
  void initState() {
    notepad = Hive.box('notepad');
    super.initState();
  }

  TextEditingController _controller = TextEditingController();
  TextEditingController _updateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('learning-approach'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'write something'),
            ),
            SizedBox(
              width: 400,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final userInput = _controller.text;
                    await notepad!.add(userInput);
                    _controller.clear();
                    Fluttertoast.showToast(msg: 'added successfully');
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: e.toString(),
                    );
                  }
                },
                child: Text("Add new data"),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box('notepad').listenable(),
                builder: (context, box, widget) {
                  return ListView.builder(
                    itemCount: notepad!.keys.toList().length,
                    itemBuilder: (_, index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(notepad!.getAt(index).toString()),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return Dialog(
                                              child: Container(
                                                height: 200,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            _updateController,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                'write something'),
                                                      ),
                                                      ElevatedButton(
                                                          onPressed: () async {
                                                            final updatedData =
                                                                _updateController
                                                                    .text;
                                                            notepad!.putAt(
                                                                index,
                                                                updatedData);
                                                                _updateController.clear();
                                                                Navigator.pop(context);
                                                          },
                                                          child: Text('update'))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      await notepad!.deleteAt(index);
                                      Fluttertoast.showToast(
                                          msg: 'deleted successfully');
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.amber,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    
    );
  }
}
