import 'package:sandbox_test_app/network/company_data.dart';

abstract class CompanyState {
  const CompanyState();
}

class CompanyLoadingState extends CompanyState {}

class CompanyFetchedState extends CompanyState {
  final List<CompanyData> data;

  const CompanyFetchedState(this.data);
}
