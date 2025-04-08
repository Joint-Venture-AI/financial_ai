import 'package:financial_ai_mobile/core/utils/app_icons.dart';

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String? icon; // Add an optional icon property

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.icon, // Initialize the icon property
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final category = json['category'] as String;
    return NotificationModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: category,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
      icon: _getIconForCategory(
        category,
      ), // Determine the icon based on the category
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'icon': icon, // Include the icon in the JSON representation
    };
  }

  static String? _getIconForCategory(String category) {
    switch (category) {
      case "food":
        return AppIcons.foodIcon;
      case "social Life":
        return AppIcons.socialIcon;
      case "pets":
        return AppIcons.petsIcon;
      case "education":
        return AppIcons.educationIcon;
      case "gift":
        return AppIcons.gitIcon;
      case "transport":
        return AppIcons.transportIcon;
      case "rent":
        return AppIcons.rentIcon;
      case "apparel":
        return AppIcons.apprarelIcon;
      case "beauty":
        return AppIcons.beautyIcon;
      case "health":
        return AppIcons.healthIcon;
      default:
        return AppIcons
            .bellIcon; // Or a default icon if you have one for "other"
    }
  }
}
