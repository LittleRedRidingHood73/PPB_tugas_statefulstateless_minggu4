import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote-card.dart';

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:
        SingleChildScrollView(
            child:
            Column (
              children: [
                translucentRow("Lorem ipsum dolor sit", Colors.white),
                translucentRow("Lorem ipsum dolor sit", Colors.white),
                translucentRow("Lorem ipsum dolor sit", Colors.white),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.lightBlueAccent,
                  ),
                  width: 300,
                  height: 200,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(30.0),
                  child: Image.asset('assets/3.jpg', height: 50),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.pinkAccent,
                  ),
                  width: 300,
                  height: 80,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                      child: Text(
                        "What image is that?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          letterSpacing: 1,
                          color: Colors.black,
                        ),
                      )
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.yellowAccent,
                  ),
                  width: 300,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.food_bank),
                          Text("Food")
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.umbrella),
                          Text("Scenery")
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.person),
                          Text("People")
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.lightGreen,
                  ),
                  width: 300,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.food_bank),
                          Text("Food")
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.umbrella),
                          Text("Scenery")
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.person),
                          Text("People")
                        ],
                      ),
                    ],
                  ),
                ),
                QuoteList(),
              ],
            )
        ) /* add child content here */,
      ),
      floatingActionButton: FloatingActionButton(
        child: Text(
          'BUY',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            letterSpacing: 1,
            color: Colors.black,
          ), // TextStyle
        ), // Text
        backgroundColor: Colors.redAccent,
        onPressed: () {},
      ), // FloatingActionButton
    ), // Scaffold
  ));
}

Widget translucentRow(String text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Spacing around rows
    padding: EdgeInsets.all(16), // Padding inside the row
    decoration: BoxDecoration(
      color: color.withOpacity(0.3), // Set transparency
      borderRadius: BorderRadius.circular(10), // Rounded corners
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/1.jpg', height: 90), // Example icon
        SizedBox(width: 10),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    ),
  );
}

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(author: 'Oscar Wilde', text: 'Be yourself; everyone else is already taken'),
    Quote(author: 'Oscar Wilde', text: 'I have nothing to declare except my genius'),
    Quote(author: 'Oscar Wilde', text: 'The truth is rarely pure and never simple')
  ];

  final TextEditingController textController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  void addQuote() {
    if (textController.text.isNotEmpty && authorController.text.isNotEmpty) {
      setState(() {
        quotes.add(Quote(
          text: textController.text,
          author: authorController.text,
        ));
        textController.clear();
        authorController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Input Fields
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: 'Enter Quote',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: authorController,
                decoration: InputDecoration(
                  labelText: 'Enter Author',
                  border: OutlineInputBorder(),

                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: addQuote,
                child: Text('Add Quote'),
              ),
            ],
          ),
        ),

        // List of Quotes
        Column(
          children: quotes.map((quote) => QuoteCard(
            quote: quote,
            delete: () {
              setState(() {
                quotes.remove(quote);
              });
            },
          )).toList(),
        ),
      ],
    );
  }
}