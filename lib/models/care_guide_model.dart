class CareGuideModel {
  final int week;
  final String titleKey; // Localization key
  final String descriptionKey; // Localization key
  final String tipsKey; // Localization key
  
  CareGuideModel({
    required this.week,
    required this.titleKey,
    required this.descriptionKey,
    required this.tipsKey,
  });
  
  factory CareGuideModel.fromJson(Map<String, dynamic> json) {
    return CareGuideModel(
      week: json['week'] as int,
      titleKey: json['titleKey'] as String,
      descriptionKey: json['descriptionKey'] as String,
      tipsKey: json['tipsKey'] as String,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'week': week,
      'titleKey': titleKey,
      'descriptionKey': descriptionKey,
      'tipsKey': tipsKey,
    };
  }
}
