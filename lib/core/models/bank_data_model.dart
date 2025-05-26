import 'dart:convert';

// Helper to parse the top-level JSON
ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));
String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  final bool success;
  final String message;
  final int statusCode;
  final Data data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    // Defensive check for the top-level 'data' field
    if (json['data'] is! Map<String, dynamic>) {
      print(
        'CRITICAL PARSE ERROR: Top-level "data" field is not a Map. Received: ${json['data'].runtimeType} - Value: ${json['data']}',
      );
      // Fallback to an empty Data object or throw a more specific error
      return ApiResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? 'Error: Invalid data structure from API',
        statusCode: json["statusCode"] ?? 500,
        data: Data(categorised: [], nonCategorised: []), // Provide empty data
      );
    }
    return ApiResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? '',
      statusCode: json["statusCode"] ?? 0,
      data: Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "statusCode": statusCode,
    "data": data.toJson(),
  };
}

class Data {
  final List<BankDataModel> categorised;
  final List<BankDataModel> nonCategorised;

  Data({required this.categorised, required this.nonCategorised});

  factory Data.fromJson(Map<String, dynamic> json) {
    List<BankDataModel> parseTransactionList(
      List<dynamic>? rawList,
      String listName,
    ) {
      if (rawList == null) return [];
      return rawList.map((item) {
        if (item is Map<String, dynamic>) {
          return BankDataModel.fromJson(item);
        } else {
          print(
            'PARSE WARNING: Item in "$listName" is not a Map. Received: ${item.runtimeType} - Value: $item. Skipping.',
          );
          // Return a default/error model or filter it out later.
          // For now, let's create an error placeholder.
          return BankDataModel(
            id: 'error_item_${DateTime.now().millisecondsSinceEpoch}', // <<< ADDED A PLACEHOLDER ID
            actualAmount: 0.0,
            currencyCode: 'ERR',
            descriptionDisplay: 'Invalid item format',
            status: 'ERROR',
            createdAt: DateTime.now(), // Placeholder
          );
        }
      }).toList();
    }

    return Data(
      categorised: parseTransactionList(
        json["categorised"] as List<dynamic>?,
        "categorised",
      ),
      nonCategorised: parseTransactionList(
        json["nonCategorised"] as List<dynamic>?,
        "nonCategorised",
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "categorised": List<dynamic>.from(categorised.map((x) => x.toJson())),
    "nonCategorised": List<dynamic>.from(nonCategorised.map((x) => x.toJson())),
  };
}

// ... (BankDataModel and the rest of the file remain the same as the previous good version) ...
class BankDataModel {
  final double actualAmount;
  final String currencyCode;
  final String descriptionDisplay;
  final String status;
  final DateTime createdAt;

  // Optional: include _id if you need a unique key for list items
  final String id;

  BankDataModel({
    required this.id,
    required this.actualAmount,
    required this.currencyCode,
    required this.descriptionDisplay,
    required this.status,
    required this.createdAt,
  });

  factory BankDataModel.fromJson(Map<String, dynamic> json) {
    // Defensive parsing for nested objects 'amount' and 'descriptions'
    Map<String, dynamic>? amountMap;
    if (json['amount'] is Map<String, dynamic>) {
      amountMap = json['amount'] as Map<String, dynamic>;
    } else if (json['amount'] != null) {
      print(
        'PARSE WARNING: "amount" field is not a Map for id ${json['_id']}. Received: ${json['amount'].runtimeType} - Value: ${json['amount']}',
      );
    }

    Map<String, dynamic>? descriptionsMap;
    if (json['descriptions'] is Map<String, dynamic>) {
      descriptionsMap = json['descriptions'] as Map<String, dynamic>;
    } else if (json['descriptions'] != null) {
      print(
        'PARSE WARNING: "descriptions" field is not a Map for id ${json['_id']}. Received: ${json['descriptions'].runtimeType} - Value: ${json['descriptions']}',
      );
    }

    return BankDataModel(
      id:
          json["_id"] as String? ??
          'unknown_id_${DateTime.now().millisecondsSinceEpoch}', // Added timestamp to unknown_id for more uniqueness
      actualAmount: (amountMap?['actualAmount'] as num?)?.toDouble() ?? 0.0,
      currencyCode: amountMap?['currencyCode'] as String? ?? 'N/A',
      descriptionDisplay:
          descriptionsMap?['display'] as String? ?? 'No description',
      status: json["status"] as String? ?? 'UNKNOWN',
      createdAt:
          (json["createdAt"] != null && json["createdAt"] is String)
              ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
              : DateTime.now(), // Fallback
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "amountDetails": {
      "actualAmount": actualAmount,
      "currencyCode": currencyCode,
    },
    "description": descriptionDisplay,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
  };
}
