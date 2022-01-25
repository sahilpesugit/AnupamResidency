class CheckinEntry{
  final String name;
  final String location;
  final int phoneNumber;

  CheckinEntry({
    required this.name,
    required this.location,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap(){
    return {
      'name':name,
      'location':location,
      'phoneNumber':phoneNumber,
    };
  }
}