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
    if (json['data'] is! Map<String, dynamic>) {
      print(
        'CRITICAL PARSE ERROR: Top-level "data" field is not a Map. Received: ${json['data'].runtimeType} - Value: ${json['data']}',
      );
      return ApiResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? 'Error: Invalid data structure from API',
        statusCode: json["statusCode"] ?? 500,
        data: Data(categorised: [], nonCategorised: []),
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
          // Create a placeholder/error BankDataModel
          return BankDataModel(
            id: 'error_item_${DateTime.now().millisecondsSinceEpoch}',
            tId: null,
            accId: null,
            amount: Amount(
              value: AmountValue(unscaledValue: "0", scale: "0"),
              currencyCode: "ERR",
              actualAmount: 0.0,
            ),
            descriptions: Descriptions(display: "Invalid item format"),
            status: 'ERROR',
            user: null,
            v: null,
            createdAt: DateTime.now(),
            updatedAt: null,
            isCategorised: null,
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

// --- Helper Classes for BankDataModel ---
class AmountValue {
  String unscaledValue;
  String scale;

  AmountValue({required this.unscaledValue, required this.scale});

  factory AmountValue.fromJson(Map<String, dynamic> json) {
    return AmountValue(
      unscaledValue: json['unscaledValue'] as String? ?? '0',
      scale: json['scale'] as String? ?? '0',
    );
  }

  Map<String, dynamic> toJson() => {
    'unscaledValue': unscaledValue,
    'scale': scale,
  };
}

class Amount {
  AmountValue value;
  String currencyCode;
  double actualAmount;

  Amount({
    required this.value,
    required this.currencyCode,
    required this.actualAmount,
  });

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
      value: AmountValue.fromJson(json['value'] as Map<String, dynamic>? ?? {}),
      currencyCode: json['currencyCode'] as String? ?? 'N/A',
      actualAmount: (json['actualAmount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'value': value.toJson(),
    'currencyCode': currencyCode,
    'actualAmount': actualAmount,
  };
}

class Descriptions {
  String display;

  Descriptions({required this.display});

  factory Descriptions.fromJson(Map<String, dynamic> json) {
    return Descriptions(
      display: json['display'] as String? ?? 'No description',
    );
  }

  Map<String, dynamic> toJson() => {'display': display};
}
// --- End of Helper Classes ---

class BankDataModel {
  final String id; // Corresponds to _id
  final String? tId;
  final String? accId;
  final Amount amount;
  final Descriptions descriptions;
  final String status;
  final String? user;
  final int? v; // Corresponds to __v
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool? isCategorised;

  BankDataModel({
    required this.id,
    this.tId,
    this.accId,
    required this.amount,
    required this.descriptions,
    required this.status,
    this.user,
    this.v,
    required this.createdAt,
    this.updatedAt,
    this.isCategorised,
  });

  factory BankDataModel.fromJson(Map<String, dynamic> json) {
    return BankDataModel(
      id:
          json["_id"] as String? ??
          'unknown_id_${DateTime.now().millisecondsSinceEpoch}',
      tId: json["tId"] as String?,
      accId: json["accId"] as String?,
      amount: Amount.fromJson(json['amount'] as Map<String, dynamic>? ?? {}),
      descriptions: Descriptions.fromJson(
        json['descriptions'] as Map<String, dynamic>? ?? {},
      ),
      status: json["status"] as String? ?? 'UNKNOWN',
      user: json["user"] as String?,
      v: json["__v"] as int?,
      createdAt:
          (json["createdAt"] != null && json["createdAt"] is String)
              ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
              : DateTime.now(),
      updatedAt:
          (json["updatedAt"] != null && json["updatedAt"] is String)
              ? DateTime.tryParse(json["updatedAt"])
              : null,
      isCategorised: json["isCategorised"] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "tId": tId,
    "accId": accId,
    "amount": amount.toJson(),
    "descriptions": descriptions.toJson(),
    "status": status,
    "user": user,
    "__v": v,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    // When sending to categorize, you typically send the current state.
    // The server then changes it. If you want to explicitly send it as false:
    "isCategorised": isCategorised ?? false,
  };
}
