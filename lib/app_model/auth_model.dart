class AuthModel {
  String authId;
  String authName;
  String authMobileNumber;
  String authEmailAddress;
  String authPassword;
  String authConfirmPassword;
  String authAs; // New field for radio button selection

  // Constructor
  AuthModel({
    required this.authId,
    required this.authName,
    required this.authMobileNumber,
    required this.authEmailAddress,
    required this.authPassword,
    required this.authConfirmPassword,
    required this.authAs, // Include authAs in the constructor
  });

  // From Map constructor (for converting a map to AuthModel)
  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      authId: map['authId'] ?? '',
      authName: map['authName'] ?? '',
      authMobileNumber: map['authMobileNumber'] ?? '',
      authEmailAddress: map['authEmailAddress'] ?? '',
      authPassword: map['authPassword'] ?? '',
      authConfirmPassword: map['authConfirmPassword'] ?? '',
      authAs: map['authAs'] ?? '', // Map the authAs field
    );
  }

  // To Map method (for converting AuthModel to a map)
  Map<String, dynamic> toMap() {
    return {
      'authId': authId,
      'authName': authName,
      'authMobileNumber': authMobileNumber,
      'authEmailAddress': authEmailAddress,
      'authPassword': authPassword,
      'authConfirmPassword': authConfirmPassword,
      'authAs': authAs, // Add authAs to the map
    };
  }

  // To String method (for converting AuthModel to a string)
  @override
  String toString() {
    return 'AuthModel{authId: $authId, authName: $authName, authMobileNumber: $authMobileNumber, authEmailAddress: $authEmailAddress, authPassword: $authPassword, authConfirmPassword: $authConfirmPassword, authAs: $authAs}';
  }
}
