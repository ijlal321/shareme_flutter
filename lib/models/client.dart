
class Client {

  final int publicId;
  String publicName;
  bool approved;
  List<int> files;

  Client({
    required this.publicId,
    this.publicName = "",
    this.approved = false,
    this.files = const [],
  });
}