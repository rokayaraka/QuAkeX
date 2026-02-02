import 'dart:convert';
import 'dart:developer';

import 'package:earthquake_app/models/earthQuakeModel.dart';
import 'package:earthquake_app/utils/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  _setQueryParams() {
    queryParams["format"] = "geojson";
    queryParams["starttime"] = "58055-04-17";
    queryParams["endtime"] = "58058-01-11";
    queryParams["minmagnitude"] = "4";
    queryParams["orderby"] = _orderBy;
    queryParams["limit"] = "500";
    queryParams["latitude"] = "$_latitude";
    queryParams["longitude"] = "$_longitude";
    queryParams["maxradiuskm"] = "$_maxRadiusKm";
  }

  init() async {
    _startTime =await getFormttedDateTime(DateTime.now().subtract(Duration(days: 10)).microsecondsSinceEpoch);
     _endTime =await getFormttedDateTime(DateTime.now().microsecondsSinceEpoch);
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
}
