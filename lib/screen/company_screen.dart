import 'package:flutter/material.dart';
import 'package:sandbox_test_app/network/company_data.dart';

class CompanyScreen extends StatelessWidget {
  final CompanyData companyData;

  const CompanyScreen({required this.companyData, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(companyData.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          _CompanyInfoLine(title: 'Сокращение названия компании', info: companyData.symbol),
          const Divider(),
          _CompanyInfoLine(title: 'Описание компании', info: companyData.description, isLarge: true),
          const Divider(),
          _CompanyInfoLine(title: 'Общая капитализация на рынке', info: companyData.capitalization.toString(), isLarge: true),
          const Divider(),
        ]),
      ),
    );
  }
}

class _CompanyInfoLine extends StatelessWidget {
  final String title;
  final String info;
  final bool isLarge;

  const _CompanyInfoLine({required this.title, required this.info, this.isLarge = false, super.key});

  @override
  Widget build(BuildContext context) {
    return isLarge
        ? SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(info)],
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), Text(info)],
          );
  }
}
