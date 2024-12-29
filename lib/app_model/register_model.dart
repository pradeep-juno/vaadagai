class RegisterModel {
  String regId;
  String regName;
  String regMobileNumber;
  String regEmailAddress;
  String regPassword;
  String regConfirmPassword;
  String regAs; // New field for radio button selection

  // Constructor
  RegisterModel({
    required this.regId,
    required this.regName,
    required this.regMobileNumber,
    required this.regEmailAddress,
    required this.regPassword,
    required this.regConfirmPassword,
    required this.regAs, // Include regAs in the constructor
  });

  // From Map constructor (for converting a map to RegisterModel)
  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      regId: map['registerId'] ?? '',
      regName: map['regName'] ?? '',
      regMobileNumber: map['regMobileNumber'] ?? '',
      regEmailAddress: map['regEmailAddress'] ?? '',
      regPassword: map['regPassword'] ?? '',
      regConfirmPassword: map['regConfirmPassword'] ?? '',
      regAs: map['regAs'] ?? '', // Map the regAs field
    );
  }

  // To Map method (for converting RegisterModel to a map)
  Map<String, dynamic> toMap() {
    return {
      'registerId': regId,
      'regName': regName,
      'regMobileNumber': regMobileNumber,
      'regEmailAddress': regEmailAddress,
      'regPassword': regPassword,
      'regConfirmPassword': regConfirmPassword,
      'regAs': regAs, // Add regAs to the map
    };
  }

  // To String method (for converting RegisterModel to a string)
  @override
  String toString() {
    return 'RegisterModel{registerId: $regId, regName: $regName, regMobileNumber: $regMobileNumber, regEmailAddress: $regEmailAddress, regPassword: $regPassword, regConfirmPassword: $regConfirmPassword, regAs: $regAs}';
  }
}
