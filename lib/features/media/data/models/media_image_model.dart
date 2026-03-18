/// Model representing a stored image in Supabase Storage.
class MediaImageModel {
  final String name;
  final String url;
  final String path;
  final String? createdAt;

  const MediaImageModel({
    required this.name,
    required this.url,
    required this.path,
    this.createdAt,
  });
}
