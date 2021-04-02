import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<void> main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyPlacesDemo());
}

class MyPlacesDemo extends StatefulWidget {
  @override
  _MyPlacesDemoState createState() => _MyPlacesDemoState();
}

class _MyPlacesDemoState extends State<MyPlacesDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: placesDemoHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class placesDemoHome extends StatefulWidget {
  @override
  _placesDemoHomeState createState() => _placesDemoHomeState();
}

class _placesDemoHomeState extends State<placesDemoHome> {
  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context, {double mulBy = 1}) {
    return screenSize(context).height * mulBy;
  }

  double screenWidth(BuildContext context, {double mulBy = 1}) {
    return screenSize(context).width * mulBy;
  }

  TextEditingController searchController = new TextEditingController();
  List searchList;
  List addedPlaces = [];

  Future<List> search(query) async {
    var response = await http.get(Uri.parse(
        'https://atlas.microsoft.com/search/fuzzy/json?&api-version=1.0&subscription-key=92tpz6XR_M-zfPMLwYfB_uCjyZ9JOJnDVkfOxZW0XK8&language=en-US&query=$query'));

    var data = json.decode(response.body);
    setState(() {
      searchList = data['results'];
      print(searchList[0]);
    });
  }

  void addPlace(place) {
    setState(() {
      addedPlaces.add(place);
    });
  }

  void removePlace(place) {
    setState(() {
      addedPlaces.remove(place);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Azure Places API PoC"),
      ),
      body: SafeArea(
        child: Material(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  width: screenWidth(context, mulBy: 1),
                  height: screenHeight(context, mulBy: 0.5),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text("Search for Places", style: TextStyle(fontSize: 22)),
                      Row(
                        children: [
                          Container(
                            width: screenWidth(context, mulBy: 0.7),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  labelText: "Search",
                                  filled: true,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                search(searchController.text);
                              },
                              child: Text("Search"))
                        ],
                      ),
                      Container(
                        height: 220,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                searchList == null ? 0 : searchList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: new Container(
                                  height: 220,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 2,
                                            color: Colors.grey[300],
                                            offset: Offset(0, 0),
                                            spreadRadius: 2)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          searchList[index]['poi']['name'] ==
                                                  null
                                              ? 'NA '
                                              : searchList[index]['poi']
                                                  ['name'],
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(searchList[index]['poi']
                                                    ['phone'] ==
                                                null
                                            ? 'NA'
                                            : searchList[index]['poi']
                                                ['phone']),
                                        Text(
                                            "Lat: ${searchList[index]['position']['lat'] == null ? 'NA' : searchList[index]['position']['lat']}"),
                                        Text(
                                            "Lon: ${searchList[index]['position']['lon'] == null ? 'NA' : searchList[index]['position']['lon']}"),
                                        ElevatedButton(
                                            onPressed: () {
                                              addPlace(searchList[index]);
                                            },
                                            child: Text("Add"))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth(context, mulBy: 1),
                  //height: screenHeight(context, mulBy: 0.3),
                  child: Column(
                    children: [
                      Text(
                        "Added Places",
                        style: TextStyle(fontSize: 22),
                      ),
                      Container(
                        height: 220,
                        child: ListView.builder(
                            itemCount:
                                addedPlaces == null ? 0 : addedPlaces.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: new Container(
                                  height: 220,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 2,
                                            color: Colors.grey[300],
                                            offset: Offset(0, 0),
                                            spreadRadius: 2)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          addedPlaces[index]['poi']['name'],
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(addedPlaces[index]['poi']
                                                    ['phone'] ==
                                                null
                                            ? 'NA'
                                            : addedPlaces[index]['poi']
                                                ['phone']),
                                        Text(
                                            "Lat: ${addedPlaces[index]['position']['lat'] == null ? 'NA' : addedPlaces[index]['position']['lat']}"),
                                        Text(
                                            "Lon: ${addedPlaces[index]['position']['lon'] == null ? 'NA' : addedPlaces[index]['position']['lon']}"),
                                        ElevatedButton(
                                            onPressed: () {
                                              removePlace(addedPlaces[index]);
                                            },
                                            child: Text("Remove"))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
