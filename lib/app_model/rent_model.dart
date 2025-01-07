import 'package:cloud_firestore/cloud_firestore.dart';

class RentModel {
  String rentId;
  String addPropertyType;
  String addPostalCode;
  String addUnit;
  String addStreet;
  String addFloorNo;
  String addSqft;
  String addBhk;
  String addBathrooms;
  String addAdvance;
  String addRent;
  String addAdditionalDetails;
  DateTime addRentCreatedAt;
  String? userId;
  String userType;
  String userName;

  // Constructor
  RentModel({
    required this.rentId,
    required this.addPropertyType,
    required this.addPostalCode,
    required this.addUnit,
    required this.addStreet,
    required this.addFloorNo,
    required this.addSqft,
    required this.addBhk,
    required this.addBathrooms,
    required this.addAdvance,
    required this.addRent,
    required this.addAdditionalDetails,
    required this.addRentCreatedAt,
    this.userId,
    required this.userType,
    required this.userName,
  });

  // From Map
  factory RentModel.fromMap(Map<String, dynamic> map) {
    return RentModel(
      rentId: map['rentId'] ?? '',
      addPropertyType: map['addPropertyType'] ?? '',
      addPostalCode: map['addPostalCode'] ?? '',
      addUnit: map['addUnit'] ?? '',
      addStreet: map['addStreet'] ?? '',
      addFloorNo: map['addFloorNo'] ?? '',
      addSqft: map['addSqft'] ?? '',
      addBhk: map['addBhk'] ?? '',
      addBathrooms: map['addBathrooms'] ?? '',
      addAdvance: map['addAdvance'] ?? '',
      addRent: map['addRent'] ?? '',
      addAdditionalDetails: map['addAdditionalDetails'] ?? '',
      addRentCreatedAt:
          (map['addRentCreatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      userId: map['userId'],
      userType: map['userType'] ?? '',
      userName: map['userName'] ?? '',
    );
  }

  // To Map
  Map<String, dynamic> toMap() {
    return {
      'rentId': rentId,
      'addPropertyType': addPropertyType,
      'addPostalCode': addPostalCode,
      'addUnit': addUnit,
      'addStreet': addStreet,
      'addFloorNo': addFloorNo,
      'addSqft': addSqft,
      'addBhk': addBhk,
      'addBathrooms': addBathrooms,
      'addAdvance': addAdvance,
      'addRent': addRent,
      'addAdditionalDetails': addAdditionalDetails,
      'addRentCreatedAt': Timestamp.fromDate(addRentCreatedAt),
      'userId': userId,
      'userType': userType,
      'userName': userName,
    };
  }

  // To String
  @override
  String toString() {
    return '''
RentModel(
  rentId: $rentId,
  addPropertyType: $addPropertyType,
  addPostalCode: $addPostalCode,
  addUnit: $addUnit,
  addStreet: $addStreet,
  addFloorNo: $addFloorNo,
  addSqft: $addSqft,
  addBhk: $addBhk,
  addBathrooms: $addBathrooms,
  addAdvance: $addAdvance,
  addRent: $addRent,
  addAdditionalDetails: $addAdditionalDetails,
  addRentCreatedAt: $addRentCreatedAt,
  userId: $userId,
  userType: $userType,
  userName: $userName,
)''';
  }
}
