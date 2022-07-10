class Profile {
  String firstName;
  String lastName;
  String address;
  String email;
  String phone;
  String imageUrl;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.email,
    required this.phone,
    required this.imageUrl,
  });

  static Profile fromJson(dynamic json) {
    return Profile(
        firstName: json["firstName"],
        lastName: json["lastName"],
        address: json["address"],
        email: json["email"],
        phone: json["phone"],
        imageUrl: json["imageUrl"]);
  }

  static List<String> keys = [
    "firstName",
    "lastName",
    "address",
    "email",
    "phone",
    "imageUrl"
  ];
}
