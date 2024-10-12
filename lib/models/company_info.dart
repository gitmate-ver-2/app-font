class CompanyInfo {
  final int id;
  final String companyName;
  final String headquartersLocation;
  final String industry;
  final String welfare;
  final String recruitmentMethod;
  final String requirements;
  final String imageUrl;

  CompanyInfo({
    required this.id,
    required this.companyName,
    required this.headquartersLocation,
    required this.industry,
    required this.welfare,
    required this.recruitmentMethod,
    required this.requirements,
    required this.imageUrl,
  });

  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
      id: json['id'],
      companyName: json['company_name'],
      headquartersLocation: json['headquarters_location'],
      industry: json['industry'],
      welfare: json['welfare'],
      recruitmentMethod: json['recruitment_method'],
      requirements: json['requirements'],
      imageUrl: json['image_url'],
    );
  }
}
