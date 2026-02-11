class UserAddress {
  String fullName;
  String phone;
  String street;
  String city;
  String zip;

  UserAddress({
    required this.fullName,
    required this.phone,
    required this.street,
    required this.city,
    required this.zip,
  });
    factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      fullName: json["fullName"] ?? "",
      phone: json["phone"] ?? "",
      street: json["street"] ?? "",
      city: json["city"] ?? "",
      zip: json["zip"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "phone": phone,
      "street": street,
      "city": city,
      "zip": zip,
    };
  }

}
