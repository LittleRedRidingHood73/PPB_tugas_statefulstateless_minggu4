import 'dart:ffi';

class Property {

  String title;
  String address;
  int price;
  String image;

  //  normal constructor, as we've already seen

  //  Quote(String author, String text){
  //    this.text = text;
  //    this.author = author;
  //  }

  //  constructor with named parameters

  //  Quote({ String author, String text }){
  //    this.text = text;
  //    this.author = author;
  //  }

  // constructor with named parameters
  // & automatically assigns named arguments to class properties

  Property({ required this.title, required this.address, required this.price, required this.image });

}