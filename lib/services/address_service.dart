import '../models/user_address.dart';

class AddressService {
  static UserAddress _address = UserAddress(
    fullName: "John Doe",
    phone: "+381 64 1234567",
    street: "Main Street 12",
    city: "Novi Sad",
    zip: "21000",
  );

  static UserAddress getAddress() {
    return _address;
  }

  static void updateAddress(UserAddress newAddress) {
    _address = newAddress;
  }
}
