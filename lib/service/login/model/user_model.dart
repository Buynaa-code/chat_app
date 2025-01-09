class User {
  final String username;
  final String password;

  User({required this.username, required this.password});

  // Convert a User object to a map
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  // Convert a map to a User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
    );
  }
}

class LoginResponse {
  final String message;
  final String token;

  LoginResponse({required this.message, required this.token});

  // Convert a LoginResponse object to a map
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
    };
  }

  // Convert a map to a LoginResponse object
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      token: json['token'],
    );
  }
}
