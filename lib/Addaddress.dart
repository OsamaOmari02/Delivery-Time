import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddAddress extends StatefulWidget {

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  address(title, userAddress, keyboard) {
    return Container(
      child: TextFormField(
        initialValue: userAddress,
        decoration: InputDecoration(
          labelText: title,
          contentPadding: EdgeInsets.symmetric(horizontal: 9),
        ),
        keyboardType: keyboard,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Address"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          address("Area", "al rahibat", TextInputType.text),
          SizedBox(height: 20),
          address("Street", "ali", TextInputType.text),
          SizedBox(height: 20),
          address("Building (optional)", "al rahibat", TextInputType.text),
          SizedBox(height: 20),
          address("Building number (optional)", "", TextInputType.number),
          SizedBox(height: 20),
          address("Floor (optional)", "", TextInputType.number),
          SizedBox(height: 40),
          ElevatedButton(
              onPressed: () {},
              child: Text("Save"),
          ),
        ],
      ),
    );
  }
}