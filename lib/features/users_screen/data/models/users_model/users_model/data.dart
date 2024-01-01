import 'row.dart';

class Data {
  int? count;
  List<Row>? rows;

  Data({this.count, this.rows});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json['count'] as int?,
        rows: (json['rows'] as List<dynamic>?)
            ?.map((e) => Row.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'rows': rows?.map((e) => e.toJson()).toList(),
      };
}
