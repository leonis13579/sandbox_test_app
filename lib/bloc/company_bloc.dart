import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox_test_app/bloc/company_state.dart';
import 'package:sandbox_test_app/network/company_data.dart';
import 'package:sandbox_test_app/network/company_network_service.dart';

class CompanyBloc extends Cubit<CompanyState> {
  CompanyBloc() : super(CompanyLoadingState()) {
    Future(() async {
      final fetchedData = await CompanyNetworkService().fetchCompaniesData();

      emit(CompanyFetchedState(fetchedData));
    });
  }

  void fetchedData(List<CompanyData> fetchedData) => emit(CompanyFetchedState(fetchedData));
}
