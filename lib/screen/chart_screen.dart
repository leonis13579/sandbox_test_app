import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox_test_app/bloc/company_bloc.dart';
import 'package:sandbox_test_app/bloc/company_state.dart';
import 'package:sandbox_test_app/network/company_data.dart';
import 'package:sandbox_test_app/screen/company_screen.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LEAP test app Page')),
      body: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (_, state) {
          if (state is CompanyLoadingState) {
            return const _LoadingStateScreen();
          } else if (state is CompanyFetchedState) {
            return _ChartStateScreen(data: state.data);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _ChartStateScreen extends StatefulWidget {
  final List<CompanyData> data;

  const _ChartStateScreen({required this.data, super.key});

  @override
  State<_ChartStateScreen> createState() => _ChartStateScreenState();
}

class _ChartStateScreenState extends State<_ChartStateScreen> {
  final sectionsColors = const [
    Colors.amber,
    Colors.blueGrey,
    Colors.cyan,
    Colors.deepOrange,
    Colors.green,
  ];

  int touchedIndex = -1;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PieChart(PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    isPressed = false;
                    return;
                  }

                  touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                  if (pieTouchResponse.touchedSection != null && pieTouchResponse.touchedSection!.touchedSectionIndex > -1 && !isPressed) {
                    isPressed = true;
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => CompanyScreen(companyData: widget.data[pieTouchResponse.touchedSection!.touchedSectionIndex])),
                    );
                  }
                });
              },
            ),
            startDegreeOffset: 180,
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 1,
            centerSpaceRadius: 0,
            sections: widget.data
                .map(
                  (company) => PieChartSectionData(
                    value: company.capitalization.toDouble(),
                    title: company.symbol,
                    titlePositionPercentageOffset: 0.55,
                    radius: 150,
                    color: sectionsColors[widget.data.indexOf(company)],
                    borderSide:
                        touchedIndex == (widget.data.indexOf(company)) ? const BorderSide(color: Colors.white, width: 6) : BorderSide(color: Colors.white.withOpacity(0)),
                  ),
                )
                .toList(),
          )),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          alignment: WrapAlignment.center,
          children: widget.data.map((company) => _Indicator(title: company.name, color: sectionsColors[widget.data.indexOf(company)])).toList(),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  final Color color;
  final String title;

  const _Indicator({required this.title, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
        const SizedBox(width: 4),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
      ],
    );
  }
}

class _LoadingStateScreen extends StatelessWidget {
  const _LoadingStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
