class UserLocation {
  final double latitude;
  final double longitude;
  final String email;
  final String address;
  final int waktu;

  UserLocation({this.latitude, this.longitude, this.email, this.address, this.waktu});
  UserLocation.fromJson(Map<String, dynamic> parsedJSON)
      : latitude = parsedJSON['latitude'],
        longitude = parsedJSON['longitude'],
        email = parsedJSON['email'],
        address = parsedJSON['address'],
        waktu = parsedJSON['waktu'];

  UserLocation.fromMap(Map snapshot)
        : latitude = snapshot['latitude'] ?? 0,
        longitude = snapshot['longitude'] ?? 0,
        email = snapshot['email'] ?? '',
        address = snapshot['address'] ?? '',
        waktu = snapshot['waktu'] ?? 0;
}
