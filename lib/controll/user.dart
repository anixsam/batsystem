class UserS {
  final String id;
  final String fullName;
  final String email;
  final String vehicleNo;

  UserS({this.id, this.fullName, this.email, this.vehicleNo});

  UserS.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        vehicleNo = data['vehiclno'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'vehicleno': vehicleNo,
    };
  }
}
