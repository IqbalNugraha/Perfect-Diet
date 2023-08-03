import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';

class LinearProgress extends StatefulWidget {
  final String lemak, karbo, indicatorLemak, indicatorKarbo;
  final double percentFat, percentCarb;
  const LinearProgress({
    required this.karbo,
    required this.lemak,
    required this.indicatorLemak,
    required this.indicatorKarbo,
    required this.percentFat,
    required this.percentCarb,
    super.key,
  });

  @override
  State<LinearProgress> createState() => _LinearProgressState();
}

class _LinearProgressState extends State<LinearProgress> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: const [
              SizedBox(width: 10),
              Expanded(
                child: FontPop14w400Black(text: "Karbohidrat"),
              ),
              SizedBox(width: 20),
              Expanded(
                child: FontPop14w400Black(text: "Lemak"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: FontPop14w400Black(text: widget.karbo),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: FontPop14w400Black(text: widget.lemak),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children:  [
              Expanded(
                child: LinearIndicator(
                  progress: widget.indicatorKarbo,
                  percent: widget.percentCarb,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: LinearIndicator(
                  progress: widget.indicatorLemak,
                  percent: widget.percentFat,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class LinearIndicator extends StatefulWidget {
  final String progress;
  final double percent;
  const LinearIndicator({
    required this.progress,
    required this.percent,
    super.key,
  });

  @override
  State<LinearIndicator> createState() => _LinearIndicatorState();
}

class _LinearIndicatorState extends State<LinearIndicator> {
  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      animation: true,
      lineHeight: 30,
      animationDuration: 1500,
      percent: widget.percent,
      center: FontPop12w400White(text: widget.progress),
      progressColor: MyColors.red(),
    );
  }
}

class CircularIndicator extends StatefulWidget {
  final String progress;
  final double percent;
  const CircularIndicator({
    required this.progress,
    required this.percent,
    super.key,
  });

  @override
  State<CircularIndicator> createState() => _CircularIndicatorState();
}

class _CircularIndicatorState extends State<CircularIndicator> {
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 80,
      lineWidth: 10,
      percent: widget.percent,
      animation: true,
      animationDuration: 1500,
      center: FontPop24w700White(
        text: widget.progress,
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: MyColors.yellow(),
      backgroundColor: MyColors.white(),
      reverse: true,
    );
  }
}

class ContainerIndicator extends StatefulWidget {
  final String judul, rekomendasi, progres;
  final double percent;
  const ContainerIndicator({
    required this.judul,
    required this.rekomendasi,
    required this.progres,
    required this.percent,
    super.key,
  });

  @override
  State<ContainerIndicator> createState() => _ContainerIndicatorState();
}

class _ContainerIndicatorState extends State<ContainerIndicator> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: MyColors.white(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            FontPop16w400Black(
              text: widget.judul,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 8),
            FontPop14w400Black(
              text: widget.rekomendasi,
            ),
            const SizedBox(height: 8),
            LinearIndicator(progress: widget.progres, percent: widget.percent),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
