import 'package:restaurant_app/models/app_user.dart';

class AuthService {
  static AppUser? currentUser;

  static bool isLoggedIn() {
  return currentUser != null;
}

   // LOGIN (mock)
  static void login(String email, String password) {
    if (email == "admin@restaurant.com") {
      currentUser = AppUser(
        id: "2",
        name: "Admin",
        email: email,
        isAdmin: true,
      );
    } else {
      currentUser = AppUser(
        id: "1",
        name: "User",
        email: email,
        isAdmin: false,
      );
    }
  }

  // REGISTER (mock)
  static void register(String name, String email, String password) {
    currentUser = AppUser(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      isAdmin: false,
    );
  }
    static void logout(){
      currentUser=null;
    }
}