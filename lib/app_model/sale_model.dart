import 'package:cloud_firestore/cloud_firestore.dart';

class SaleModel {
  String saleId;
  String addPropertyType;
  String addPostalCode;
  String addUnit;
  String addStreet;
  String addTotalFloors;
  String addFloorNo;
  String addSqft;
  String addBhk;
  String addBathrooms;
  String addPrice;
  String addAdditionalDetails;
  DateTime addSaleCreatedAt;
  String? userId;
  String userType;
  String userName;

  // Constructor
  SaleModel({
    required this.saleId,
    required this.addPropertyType,
    required this.addPostalCode,
    required this.addUnit,
    required this.addStreet,
    required this.addTotalFloors,
    required this.addFloorNo,
    required this.addSqft,
    required this.addBhk,
    required this.addBathrooms,
    required this.addPrice,
    required this.addAdditionalDetails,
    required this.addSaleCreatedAt,
    this.userId,
    required this.userType,
    required this.userName,
  });

  // From Map
  factory SaleModel.fromMap(Map<String, dynamic> map) {
    return SaleModel(
      saleId: map['saleId'] ?? '',
      addPropertyType: map['addPropertyType'] ?? '',
      addPostalCode: map['addPostalCode'] ?? '',
      addUnit: map['addUnit'] ?? '',
      addStreet: map['addStreet'] ?? '',
      addTotalFloors: map['addTotalFloors'] ?? '',
      addFloorNo: map['addFloorNo'] ?? '',
      addSqft: map['addSqft'] ?? '',
      addBhk: map['addBhk'] ?? '',
      addBathrooms: map['addBathrooms'] ?? '',
      addPrice: map['addPrice'] ?? '',
      addAdditionalDetails: map['addAdditionalDetails'] ?? '',
      addSaleCreatedAt:
          (map['addSaleCreatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      userId: map['userId'],
      userType: map['userType'] ?? '',
      userName: map['userName'] ?? '',
    );
  }

  // To Map
  Map<String, dynamic> toMap() {
    return {
      'saleId': saleId,
      'addPropertyType': addPropertyType,
      'addPostalCode': addPostalCode,
      'addUnit': addUnit,
      'addStreet': addStreet,
      'addTotalFloors': addTotalFloors,
      'addFloorNo': addFloorNo,
      'addSqft': addSqft,
      'addBhk': addBhk,
      'addBathrooms': addBathrooms,
      'addPrice': addPrice,
      'addAdditionalDetails': addAdditionalDetails,
      'addSaleCreatedAt': Timestamp.fromDate(addSaleCreatedAt),
      'userId': userId,
      'userType': userType,
      'userName': userName,
    };
  }

  // To String
  @override
  String toString() {
    return 'SaleModel(saleId: $saleId, addPropertyType: $addPropertyType, addPostalCode: $addPostalCode, '
        'addUnit: $addUnit, addStreet: $addStreet, addTotalFloors: $addTotalFloors, addFloorNo: $addFloorNo, '
        'addSqft: $addSqft, addBhk: $addBhk, addBathrooms: $addBathrooms, addPrice: $addPrice, '
        'addAdditionalDetails: $addAdditionalDetails, addSaleCreatedAt: $addSaleCreatedAt, '
        'userId: $userId, userType: $userType, userName: $userName)';
  }
}
