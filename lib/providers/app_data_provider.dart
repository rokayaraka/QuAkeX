import 'dart:convert';

import 'package:earthquake_app/models/earthQuakeModel.dart';
import 'package:earthquake_app/utils/helper_functions.dart';
import 'package:flutter/foundation.dart';
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
  EarthQuakeModel? earthQuakeModel;

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

  init(){
    _startTime =getFormttedDateTime(DateTime.now().subtract(Duration(days: 1)).microsecondsSinceEpoch);
     _endTime =getFormttedDateTime(DateTime.now().microsecondsSinceEpoch);
     _maxRadiusKm = masRadiusKmThreshold;

     _setQueryParams();
     getEarthQuakedata();
  }

  Future<void> getEarthQuakedata() async{
    final uri = Uri.https(baseUrl.authority,baseUrl.path,queryParams);
    try{
     final response = await http.get(uri);
     if(response.statusCode==200){
      final json = jsonDecode(response.body) ;
      earthQuakeModel=EarthQuakeModel.fromJson(json);
      print(earthQuakeModel!.features.length);
      notifyListeners();
     }
    }catch(error){
      print(error.toString());
    }
  }
}
