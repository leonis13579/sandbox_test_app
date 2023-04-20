class CompanyData {
  final String symbol;
  final String name;
  final String description;
  final int capitalization;

  CompanyData.fromJson(Map<String, dynamic> json)
      : symbol = json['Symbol'],
        name = json['Name'],
        description = json['Description'],
        capitalization = int.parse(json['MarketCapitalization']);
}
