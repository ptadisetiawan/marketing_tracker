class UserLocation {
  final double latitude;
  final double longitude;
  final String email;

  UserLocation({this.latitude, this.longitude, this.email});
  UserLocation.fromJson(Map<String, dynamic> parsedJSON)
      : latitude = parsedJSON['latitude'],
        longitude = parsedJSON['longitude'],
        email = parsedJSON['email'];

  UserLocation.fromMap(Map snapshot)
        : latitude = snapshot['latitude'] ?? '',
        longitude = snapshot['longitude'] ?? '',
        email = snapshot['email'] ?? '';
}
