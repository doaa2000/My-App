import 'row.dart';

class Data {
  int? count;
  List<UserRow>? rows;

  Data({this.count, this.rows});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json['count'] as int?,
        rows: (json['rows'] as List<dynamic>?)
            ?.map((e) => UserRow.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'rows': rows?.map((e) => e.toJson()).toList(),
      };
}
