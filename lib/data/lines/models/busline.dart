class BusLine {
  final String number;

  BusLine({required this.number});

  BusLine copyWith({
    String? number,
  }) {
    return BusLine(number: number ?? this.number);
  }

  factory BusLine.fromMap(Map<String, dynamic> map) {
    return BusLine(
      number: map['values'][0]['value']?.toString() ?? '',
    );
  }

  @override
  String toString() {
    return 'BusLine(numer: $number)';
  }
}
