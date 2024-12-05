class BookingRequestModel {
  int businessId;
  int serviceId;
  DateTime time;

  BookingRequestModel({
    required this.businessId,
    required this.serviceId,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'business_id': businessId,
      'service_id': serviceId,
      'time': time.toString(),
    };
  }
}