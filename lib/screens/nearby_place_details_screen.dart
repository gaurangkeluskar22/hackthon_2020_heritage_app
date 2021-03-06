import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nishant/constants.dart';
import 'package:nishant/screens/reviews.dart';
import 'package:nishant/services/network.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class NearbyPlaceDetails extends StatefulWidget {
  final place;
  final images;
  NearbyPlaceDetails({@required this.place, this.images});
  @override
  _NearbyPlaceDetailsState createState() => _NearbyPlaceDetailsState();
}

class _NearbyPlaceDetailsState extends State<NearbyPlaceDetails> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  var placeDetails;
// '$kPlaceDetailsUrl${widget.place['place_id']}&key=$kApiKey'
  void getData() async {
    NetworkHelper networkHelper = NetworkHelper(
        '$kPlaceDetailsUrl${widget.place['place_id']}&key=$kApiKey');

    var data = await networkHelper.getJson();
    setState(() {
      placeDetails = data['result'];
//      print(placeDetails['reviews'][0]['author_name']);
//      print(placeDetails['reviews'].length);
    });
  }

//  launchURL(var url) async {
//    if (await canLaunch('https://flutter.io')) {
//      await launchURL('https://flutter.io');
//    } else {
//      throw 'Could not launch $url';
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SolidBottomSheet(
        body: Visibility(
          visible: placeDetails == null ? false : true,
          child: SingleChildScrollView(
            child: Card(
              elevation: 0.5,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: 25.0, left: 20.0, right: 20.0, bottom: 20.0),
                    child: Text(
                      'The Gateway of India is an arch-monument built in the early twentieth century in the city of Mumbai, in the Indian state of Maharashtra. It was erected to commemorate the landing in December 1911 at Apollo Bunder, Mumbai (then Bombay) of King-Emperor George V and Queen-Empress Mary, the first British monarch to visit India. At the time of the royal visit, the gateway was not yet built, and a cardboard structure greeted the monarch. The foundation stone was laid in March 1913 for a monument built in the Indo-Saracenic style, incorporating elements of 16th-century Marathi architecture. The final design of the monument by architect George Wittet was sanctioned only in 1914, and construction was completed in 1924. The structure is a triumphal arch made of basalt, which is 26 metres (85 feet) high.',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        headerBar: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Center(
            child: Text(
              'History & Facts',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'Lato',
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: placeDetails == null
          ? Center(
              child: SpinKitPulse(
                color: Colors.blue,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 430,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                        ),
                        child: Image.network(
                          widget.images,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0.5,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 25, left: 20),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                placeDetails != null
                                    ? placeDetails['name']
                                    : 'name',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, top: 10.0, right: 10.0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: RatingBar(
                                    ignoreGestures: true,
                                    itemSize: 23.0,
                                    initialRating: placeDetails == null
                                        ? 0.0
                                        : placeDetails['rating'].toDouble(),
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
//                                  print(rating);
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 12.0),
                                child: Container(
                                  child: Text(
                                    placeDetails == null
                                        ? '0.0'
                                        : '${placeDetails['rating']} / 5',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                      color: Colors.blue,
                                      fontFamily: 'Monst',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 17.0, top: 20.0),
                                child: Container(
                                  height: 30,
                                  child: Material(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    color: Colors.blue,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0,
                                          left: 8.0,
                                          right: 8.0,
                                          bottom: 8.0),
                                      child: Center(
                                        child: Text(
                                          StringUtils.capitalize(
                                            placeDetails == null
                                                ? 'type'
                                                : placeDetails['types'][0]
                                                    .toString()
                                                    .replaceAll(
                                                        (RegExp('_')), ' '),
                                          ),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Lato',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 20.0),
                                child: Container(
                                  height: 30,
                                  child: Material(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    color: Colors.blue,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0,
                                          left: 8.0,
                                          right: 8.0,
                                          bottom: 8.0),
                                      child: Center(
                                        child: Text(
                                          StringUtils.capitalize(
                                            placeDetails == null
                                                ? 'type'
                                                : placeDetails['types'][1]
                                                    .toString()
                                                    .replaceAll(
                                                        (RegExp('_')), ' '),
                                          ),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Lato',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 20.0),
                                child: Container(
                                  height: 30,
                                  child: Material(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    color: Colors.blue,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0,
                                          left: 5.0,
                                          right: 5.0,
                                          bottom: 8.0),
                                      child: Center(
                                        child: Text(
                                          StringUtils.capitalize(
                                            placeDetails == null
                                                ? 'type'
                                                : placeDetails['types'][2]
                                                    .toString()
                                                    .replaceAll(
                                                        (RegExp('_')), ' '),
                                          ),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Lato',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Address',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Text(
                              placeDetails == null
                                  ? 'Adress'
                                  : placeDetails['formatted_address'],
                              style:
                                  TextStyle(fontSize: 16.0, fontFamily: 'Lato'),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ReviewsScreen(placeDetails);
                            },
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 0.4,
                        child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Reviews 👌',
                              style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600,
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Open google Map
//                        launchURL(placeDetails['url']);
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 0.4,
                        child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Open in Google Maps  🗺',
                              style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600,
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
