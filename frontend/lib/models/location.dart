// Location class to store location object
class MyLocation {
  final String name;
  final String? address;
  final double? lat;
  final double? lng;
  final String? placeId;

  MyLocation({
    required this.name,
    this.address,
    this.lat,
    this.lng,
    this.placeId,
  });
}