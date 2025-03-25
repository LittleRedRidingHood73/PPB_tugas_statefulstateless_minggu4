import 'dart:ffi';

import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote-card.dart';
import 'traslucent-box.dart';
import 'property.dart';

void main() {
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {},
        child: Icon(
            Icons.add
        ),
      ), // FloatingActionButton
    ), // Scaffold
  ));
}

class PropertyList extends StatefulWidget {
  @override
  _PropertyListState createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  List<Property> properties = [
    Property(title: 'Beautiful beach house', address: 'San Antonio 1337', price: 1000000, image: "assets/1.jpg"),
    Property(title: 'Calm lakeside manor', address: 'Kejawan Putih 1277', price: 1000000, image: "assets/2.jpeg"),
    Property(title: 'Big white mansion', address: 'Jalan Teknik Kimia 8876', price: 1000000, image: "assets/3.jpg"),
  ];

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
                decoration: InputDecoration(labelText: "Title"),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Address"),
                onChanged: (value) => address = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                onChanged: (value) => price = int.tryParse(value) ?? 0,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Image Path"),
                onChanged: (value) => image = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  properties.add(Property(title: title, address: address, price: price, image: image));
                });
                Navigator.pop(context);
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
        String title = properties[index].title;
        String address = properties[index].address;
        int price = properties[index].price;
        String image = properties[index].image;

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
              onPressed: () {
                setState(() {
                  properties[index] = Property(title: title, address: address, price: price, image: image);
                });
                Navigator.pop(context);
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
            Property property = entry.value;
            return TranslucentCard(
              title: property.title,
              price: property.price,
              imageURI: property.image,
              delete: () {
                setState(() {
                  properties.removeAt(index);
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