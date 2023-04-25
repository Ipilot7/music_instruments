class UserModel {
  int? id;
  // int? status;
  int? activeTariffId;
  String? authKey;
  String? img;
  String? firstname;
  String? lastname;
  String? deviceId;
  String? deviceName;
  String? deviceToken;
  String? username;
  int? allowedDevicesCount;

  UserModel(
      {this.id,
      // this.status,
      this.allowedDevicesCount,
      this.img,
      this.authKey,
      this.username,
      this.firstname,
      this.lastname,
      this.deviceId,
      this.deviceName,
      this.deviceToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    // status = json['status'];
    img = json['img'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    deviceId = json['device_id'];
    deviceName = json['device_name'];
    deviceToken = json['device_token'];
    id = json['id'];
    authKey = json['auth_key'];
    username = json['username'];
    allowedDevicesCount = json['allowed_devices_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img'] = img;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['device_id'] = deviceId;
    data['device_name'] = deviceName;
    data['device_token'] = deviceToken;
    data['id'] = id;
    data['auth_key'] = authKey;
    data['username'] = username;
    data['allowed_devices_count'] = allowedDevicesCount;
    return data;
  }
}
