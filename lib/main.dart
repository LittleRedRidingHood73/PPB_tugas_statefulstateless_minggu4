import 'dart:ffi';

import 'package:firstproject/models/property.dart';
import 'package:firstproject/services/database_service.dart';
import 'package:flutter/material.dart';
import 'traslucent-box.dart';
import 'property.dart';

void main() async {
  await _setup();
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20), // Adds space below the image
                child: Image.asset('assets/logo.png', height: 60,),
              ),
            ],
          ),
      ),
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child:
            SingleChildScrollView(
              child:
                Expanded(
                  child: Column (
                  children: [
                    PropertyList(),
                  ],
                                ),
                )
            ) /* add child content here */,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.redAccent,
      //   onPressed: () {
      //     // gimana cara manggil _addProperty()
      //   },
      //   child: Icon(
      //       Icons.add
      //   ),
      // ), // FloatingActionButton
    ), // Scaffold
  ));
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.setup();
}

class PropertyList extends StatefulWidget {
  @override
  _PropertyListState createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  List<MyProperty> properties = [];

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  void _loadProperties() async {
    final list = await DatabaseService.getProperties(); // from your DB service
    setState(() {
      properties = list;
    });
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();


  void _addProperty() {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String address = '';
        int price = 0;
        String image = '';

        return AlertDialog(
          title: Text("Add Property"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
                // onChanged: (value) => title = value,
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: "Address"),
                // onChanged: (value) => address = value,
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                // onChanged: (value) => price = int.tryParse(value) ?? 0,
              ),
              TextField(
                controller: imageController,
                decoration: InputDecoration(labelText: "Image Path"),
                // onChanged: (value) => image = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty && addressController.text.isNotEmpty && priceController.text.isNotEmpty && imageController.text.isNotEmpty) {
                  await DatabaseService.addProperty(MyProperty()
                    ..title = titleController.text
                    ..address = addressController.text
                    ..price = int.tryParse(priceController.text) ?? 0
                    ..image = imageController.text);
                  titleController.text = '';
                  addressController.text = '';
                  priceController.text = '';
                  imageController.text = '';
                  Navigator.pop(context);
                  _loadProperties();
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _editProperty(int index) {
    showDialog(
      context: context,
      builder: (context) {
        String title = properties[index].title ?? '';
        String address = properties[index].address ?? '';
        int price = properties[index].price;
        String image = properties[index].image ?? '';

        return AlertDialog(
          title: Text("Edit Property"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: TextEditingController(text: title),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Address"),
                controller: TextEditingController(text: address),
                onChanged: (value) => address = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: price.toString()),
                onChanged: (value) => price = int.tryParse(value) ?? price,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Image Path"),
                controller: TextEditingController(text: image),
                onChanged: (value) => image = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                MyProperty prop = properties[index];
                prop
                  ..title = title
                  ..address = address
                  ..price = price
                  ..image = image
                  ..updateDateTime = DateTime.now();

                await DatabaseService.updateProperty(prop);
                Navigator.pop(context);
                _loadProperties();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        SizedBox(height: 10,),
        ElevatedButton(
          onPressed: _addProperty,
          child: Text("Add Property"),
        ),
        Column(
          children: properties.asMap().entries.map((entry) {
            int index = entry.key;
            MyProperty property = entry.value;
            return TranslucentCard(
              title: property.title ?? '',
              price: property.price,
              imageURI: property.image ?? '',
              delete: () {
                setState(() async {
                  await DatabaseService.deleteProperty(properties[index].id);
                  _loadProperties();
                });
              },
              edit: () => _editProperty(index), // Add edit functionality
            );
          }).toList(),
        ),
      ],
    );
  }
}