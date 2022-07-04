class Profile {
  late String firstName;
  late String lastName;
  late String addressName;
  late String emailName;
  late String phoneNum;
  late String payment;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.addressName,
    required this.emailName,
    required this.phoneNum,
    required this.payment,
  });

  static Profile fromJson(dynamic json) {
    return Profile(
        firstName: json["firstName"],
        lastName: json["lastName"],
        addressName: json["addressName"],
        emailName: json["emailName"],
        phoneNum: json["phoneNum"],
        payment: json["payment"]);
  }

  static List<String> keys = [
    "firstName",
    "lastName",
    "addressName",
    "emailName",
    "phoneNum",
    "payment"
  ];
}
