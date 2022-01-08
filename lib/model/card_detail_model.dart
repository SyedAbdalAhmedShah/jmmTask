// To parse this JSON data, do
//
//     final cardDetail = cardDetailFromJson(jsonString);

import 'dart:convert';

CardDetail cardDetailFromJson(String str) =>
    CardDetail.fromJson(json.decode(str));

String cardDetailToJson(CardDetail data) => json.encode(data.toJson());

class CardDetail {
  CardDetail({
    this.city,
    this.country,
    this.description,
  });

  String? city;
  String? country;
  String? description;

  factory CardDetail.fromJson(Map<String, dynamic> json) => CardDetail(
        city: json["city"],
        country: json["country"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "description": description,
      };
}
