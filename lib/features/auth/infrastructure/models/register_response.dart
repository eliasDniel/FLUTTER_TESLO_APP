class RegisterResponse {
    final String email;
    final String fullName;
    final String id;
    final bool isActive;
    final List<String> roles;
    final String token;

    RegisterResponse({
        required this.email,
        required this.fullName,
        required this.id,
        required this.isActive,
        required this.roles,
        required this.token,
    });

    factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
        email: json["email"],
        fullName: json["fullName"],
        id: json["id"],
        isActive: json["isActive"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "fullName": fullName,
        "id": id,
        "isActive": isActive,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "token": token,
    };
}
