import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AutenticacaoModel {
  //
  final String accessToken;
  final String refreshToken;

  //Constutor
  AutenticacaoModel({
    required this.accessToken,
    required this.refreshToken,
  });
  // Json serealize
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  factory AutenticacaoModel.fromMap(Map<String, dynamic> map) {
    return AutenticacaoModel(
      accessToken: map['access_token'] as String,
      refreshToken: map['refresh_token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AutenticacaoModel.fromJson(String source) =>
      AutenticacaoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
