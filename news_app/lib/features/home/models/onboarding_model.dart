class OnboardingModel {
  final String title;
  final String description;
  final String image;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.image,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'image': image};
  }
}
