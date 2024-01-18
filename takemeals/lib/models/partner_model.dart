class Partner {
  final int id;
  final int userId;
  final String storeName;
  final String address;
  final String city;
  final String province;
  final String openAt;
  final String closeAt;
  final String latitude;
  final String longitude;
  final String createdAt;
  final String updatedAt;

  Partner({
    required this.id,
    required this.userId,
    required this.storeName,
    required this.address,
    required this.city,
    required this.province,
    required this.openAt,
    required this.closeAt,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'],
      userId: json['user_id'],
      storeName: json['store_name'],
      address: json['address'],
      city: json['city'],
      province: json['province'],
      openAt: json['open_at'],
      closeAt: json['close_at'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
