class UserModel {
  String? fname;
  String? lname;
  String? email;
  String? mobile;
  String? dob;
  String? password;
  String? confirmPassword;
  String? clientKey;
  String? deviceType;

  UserModel(
      {this.fname,
      this.lname,
      this.email,
      this.mobile,
      this.dob,
      this.password,
      this.confirmPassword,
      this.clientKey,
      this.deviceType});

  UserModel.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    mobile = json['mobile'];
    dob = json['dob'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
    clientKey = json['client_key'];
    deviceType = json['device_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    data['client_key'] = this.clientKey;
    data['device_type'] = this.deviceType;
    return data;
  }
}
