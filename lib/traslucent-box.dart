import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TranslucentCard extends StatelessWidget {
  final String title;
  final int price;
  final String imageURI;
  final VoidCallback delete;
  final VoidCallback edit;

  TranslucentCard({
    required this.title,
    required this.imageURI,
    required this.price,
    required this.delete,
    required this.edit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Spacing around rows
      padding: EdgeInsets.all(16), // Padding inside the row
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1), // ✅ Make background translucent
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: Column(
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 30), // ✅ Fix text visibility
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  imageURI,
                  height: 90,
                  width: 200,
                  fit: BoxFit.cover,
              ), // Example icon
              SizedBox(width: 10),
              Text(
                '\$$price',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.green, fontSize: 20),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: edit,
                label: Text('Edit'),
                icon: Icon(Icons.edit),
              ),
              ElevatedButton.icon(
                onPressed: delete,
                label: Text('Delete'),
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
