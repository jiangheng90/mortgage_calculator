import 'package:json_annotation/json_annotation.dart';
part 'loan.g.dart';

@JsonSerializable()
class Loan {
  num amount;
  DateTime startDate;
  int year;
  num rate;
  String type;

  Loan(
      this.amount,
      this.startDate,
      this.year,
      this.rate,
      this.type);

  factory Loan.fromJson(Map<String,dynamic> json) => _$LoanFromJson(json);
  Map<String,dynamic> toJson()=> _$LoanToJson(this);
}