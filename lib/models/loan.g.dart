// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loan _$LoanFromJson(Map<String, dynamic> json) {
  return Loan(
      json['amount'] as num,
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      json['year'] as int,
      json['rate'] as num,
      json['type'] as String);
}

Map<String, dynamic> _$LoanToJson(Loan instance) => <String, dynamic>{
      'amount': instance.amount,
      'startDate': instance.startDate?.toIso8601String(),
      'year': instance.year,
      'rate': instance.rate,
      'type': instance.type
    };
