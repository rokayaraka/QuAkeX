import 'dart:convert';
import 'dart:developer';

import 'package:earthquake_app/models/earthQuakeModel.dart';
import 'package:earthquake_app/utils/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
  import 'package:geolocator/geolocator.dart';

class AppDataProvider with ChangeNotifier {
  final baseUrl = Uri.parse("https://earthquake.usgs.gov/fdsnws/event/1/query");
  Map<String, dynamic> queryParams = {};

  double _maxRadiusKm = 500;
  double _latitude = 0.0;
  double _longitude = 0.0;
  String _startTime = "";
  String _endTime = "";
  String _orderBy = "time";
  String? _currentCity;
  double _masRadiusKmThreshold = 20001.6;
  bool _shouldUseLocation = false;
  EarthquakeModel? earthQuakeModel;

  get maxRadiusKm => this._maxRadiusKm;

  get latitude => this._latitude;

  get longitude => this._longitude;

  get startTime => this._startTime;

  get endTime => this._endTime;

  get orderBy => this._orderBy;

  get currentCity => this._currentCity;

  get masRadiusKmThreshold => this._masRadiusKmThreshold;

  get shouldUseLocation => this._shouldUseLocation;

  get getEarthQuakeModel => this.earthQuakeModel;

  bool get hasDataLoaded => earthQuakeModel!=null;

  void setOrder(String value){
    _orderBy = value;
    notifyListeners();
    _setQueryParams();
    getEarthQuakedata();
  }

  _setQueryParams() {
    queryParams["format"] = "geojson";
    queryParams["starttime"] = _startTime;
    queryParams["endtime"] = _endTime;
    queryParams["minmagnitude"] = "4";
    queryParams["orderby"] = _orderBy;
    queryParams["limit"] = "500";
    queryParams["latitude"] = "$_latitude";
    queryParams["longitude"] = "$_longitude";
    queryParams["maxradiuskm"] = "$_maxRadiusKm";
  }

  void init() async {
    _startTime = 
    await getFormttedDateTime(DateTime.now().subtract(Duration(days: 5)).millisecondsSinceEpoch);
     _endTime = 
     await getFormttedDateTime(DateTime.now().millisecondsSinceEpoch);
     _maxRadiusKm = masRadiusKmThreshold;

     _setQueryParams();
     getEarthQuakedata();
  }

  Color getAlertColor(String color){
    return switch(color){
      "green"=>Colors.green,
      "yellow"=>Colors.yellow,
      "orange"=>Colors.orange,
      _=>Colors.red,
    };
  }

  Future<void> getEarthQuakedata() async{
    final uri = Uri.https(baseUrl.authority,baseUrl.path,queryParams);
    log(uri.toString());
    log(_endTime);
     log(_startTime);
    
    try{
     final response = await http.get(uri);
     if(response.statusCode==200){
      final json = jsonDecode(response.body) ;
      log(json.runtimeType.toString());
      earthQuakeModel=EarthquakeModel.fromJson(json);
      print(earthQuakeModel!.features!.length);
      notifyListeners();
     }
    }catch(error){
      log(error.toString());
    }
  }

  void setStartTime(String date) {
    _startTime=date;
    _setQueryParams();
    notifyListeners();
  }

  void setEndTime(String date) {
    _endTime=date;
    _setQueryParams();
    notifyListeners();
  }

  Future<void> setLocation(bool value) async {
    _shouldUseLocation=value;
    notifyListeners();
    if(value){
      final position = await _determinePosition();
      _latitude = position.latitude;
      _longitude=position.longitude;
      _maxRadiusKm=500;
      _setQueryParams();
      getEarthQuakedata();
    }
  }



/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
}
