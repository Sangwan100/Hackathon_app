import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

import 'package:hacakthon_app/widgets/Request_box.dart';
import 'package:hacakthon_app/widgets/image_input.dart';

import 'package:hacakthon_app/widgets/info_text.dart';
import '../widgets/your_request.dart';
import '../widgets/bottom_bar.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  Position position;
  File _pickedImage;
  String _originalAddress;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void getCurrentLocation() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(position);

    getCurrentAddress();
  }

  void getCurrentAddress() async {
    final query = "1600 Amphiteatre Parkway, Mountain View";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    print("${first.featureName} : ${first.coordinates}");

// From coordinates

    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    final coordinates = Coordinates(position.latitude, position.longitude);

    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;
    var originalAddress = "${first.featureName} : ${first.addressLine}";

    setState(() {
      _originalAddress = originalAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(13, 132, 155, 1),
        title: Text(
          'Request Page',
          textAlign: TextAlign.left,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InfoText(),
            Row(
              //mainAxisAlignment: MainAxisAlignment.S,
              children: <Widget>[
                Expanded(child: ImageInput(_selectImage)),
                Expanded(child: ImageInput(_selectImage)),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ImageInput(_selectImage),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 17.0),
                        child: Card(
                          shadowColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.indigo,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(top: 15),
                              height: 100,
                              width: 185,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: SingleChildScrollView(
                                        child: _originalAddress != null
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.0),
                                                child: Text(
                                                  _originalAddress,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              )
                                            : TextFormField(
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.indigo,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: null,

                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Your Location...',
                                                ),

                                                // onSubmitted: (_) {},
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FlatButton.icon(
                        icon: Icon(
                          Icons.location_on,
                        ),
                        label: Text(
                          'Current Location',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        textColor: Colors.indigo,
                        onPressed: () {
                          getCurrentLocation();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            YourRequest(),
            SizedBox(
              height: 8.0,
            ),
            RequestBox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: Icon(
          Icons.check_circle,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}
