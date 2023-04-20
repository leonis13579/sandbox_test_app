import 'package:dio/dio.dart';
import 'package:sandbox_test_app/network/api_key.dart';
import 'package:sandbox_test_app/network/company_data.dart';

class CompanyNetworkService {
  final _dio = Dio();
  String _uriForCompany(String symbol) => 'https://www.alphavantage.co/query?function=OVERVIEW&symbol=$symbol&apikey=$api_key';

  final searchingCompanySymbols = ['AAPL', 'AMZN', 'GOOG', 'MSFT', 'META'];

  Future<List<CompanyData>> fetchCompaniesData() async {
    final responses = await Future.wait(searchingCompanySymbols.map((symbol) => _fetchCompanyData(symbol)));

    return responses.whereType<CompanyData>().toList();
  }

  Future<CompanyData?> _fetchCompanyData(String companySymbol) async {
    final response = await _dio.get<Map<String, dynamic>>(_uriForCompany(companySymbol));

    return response.data != null ? CompanyData.fromJson(response.data!) : null;
  }
}
