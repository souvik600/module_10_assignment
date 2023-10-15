import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListItem {
  String title;
  String subtitle;

  ListItem({required this.title, required this.subtitle});
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ListItem> items = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Items"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.blue,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Add Title',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.lightBlue),
                ),
              ),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter a value';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: subtitleController,
              decoration: const InputDecoration(
                hintText: 'Add Description',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.lightBlue),
                ),
              ),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter a value';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  items.add(
                    ListItem(
                      title: titleController.text,
                      subtitle: subtitleController.text,
                    ),
                  );
                });
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              child: const Text("Add"),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      maxRadius: 20,
                      backgroundColor: Colors.deepOrange,
                      child: Text(
                        index.toString(),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_right_alt_sharp,
                      size: 34,
                    ),
                    tileColor: Colors.grey,
                    title: Text(items[index].title),
                    subtitle: Text(items[index].subtitle),
                    onLongPress: () {
                      showAlertDialog(context, index);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 4,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // Function to show the AlertDialog for editing or deleting an item
  void showAlertDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Alert"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                showEditBottomSheet(context, index);
              },
              child: const Text("Edit"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  items.removeAt(index);
                });
                Fluttertoast.showToast(msg: "Item deleted.");
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void showEditBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Add Title',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.amberAccent),
                  ),
                ),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter a value';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: subtitleController,
                decoration: const InputDecoration(
                  hintText: 'Add Description',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.amberAccent),
                  ),
                ),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter a value';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    items[index].title = titleController.text;
                    items[index].subtitle = subtitleController.text;
                  });
                  Fluttertoast.showToast(msg: "Item updated.");
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange),
                child: const Text("Edit Done"),
              ),
            ],
          ),
        );
      },
    );
  }
}
