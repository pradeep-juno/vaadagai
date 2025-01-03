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
  });

  // From Map constructor
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
    );
  }

  // To Map method
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
    };
  }

  // To String method
  @override
  String toString() {
    return 'SaleModel(saleId: $saleId, addPropertyType: $addPropertyType, addPostalCode: $addPostalCode, addUnit: $addUnit, addStreet: $addStreet, addTotalFloors: $addTotalFloors, addFloorNo: $addFloorNo, addSqft: $addSqft, addBhk: $addBhk, addBathrooms: $addBathrooms, addPrice: $addPrice, addAdditionalDetails: $addAdditionalDetails)';
  }
}
