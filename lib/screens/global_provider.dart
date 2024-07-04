import 'dart:convert';

import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier{


  double latitude = 0;
  double longitude = 0;


  static bool updateInternet = true;

  String routeName = "";
  static String selectedWarehouseName = "";
  static String selectedWarehouseId = "";
  static String roleName = "Select role";
  static String roleId = "Select roleId";
  static String userIdAfterLogin = "";
  static String userRoleType = "admin";
  static int generalProductType = 0;
  static int cylinderProductType = 0;
  static int isAdmin = -1;
  static String? userName = "";
  bool isProductTypeGeneral = false;
  List<dynamic> initialRole = [];
  List<dynamic> initialWarehouse = [];

  f(){
    notifyListeners();
  }




  //salesman allocation
  static String salesmanAllocationId = "";
  static String salesmanCurrentAllocationReferenceNo = "";
  static String salesmanAllocationStatus = "";
  static String salesmanAllocationMessage = "";



}