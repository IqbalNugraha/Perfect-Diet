import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_detail_summary.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/row_custom.dart';

class DetailRekomendasi extends StatefulWidget {
  final int id;
  final String title;
  final String image;
  const DetailRekomendasi({
    required this.id,
    required this.title,
    required this.image,
    super.key,
  });

  @override
  State<DetailRekomendasi> createState() => _DetailRekomendasiState();
}

class _DetailRekomendasiState extends State<DetailRekomendasi> {
  var diet = StringBuffer();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ViewDetailSummary>(context, listen: false).fetchDetailSummary(
        widget.id,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dataDetailSummary =
        Provider.of<ViewDetailSummary>(context).responseDetailSummary;
    bool isValid = Provider.of<ViewDetailSummary>(context).isValid;
    String deskripsi = Provider.of<ViewDetailSummary>(context).deskripsi;

    return Scaffold(
      backgroundColor: MyColors.background(),
      body: Consumer<ViewDetailSummary>(
        builder: (context, viewDetailSummary, _) {
          if (viewDetailSummary.state == ClassViewDetailSummary.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: MyColors.red(),
              ),
            );
          } else if (viewDetailSummary.state == ClassViewDetailSummary.error) {
            return const Center(
              child: FontPop16w400Black(
                  text: "Terdapat Kesalahan Proses Data",
                  textAlign: TextAlign.center),
            );
          } else if (viewDetailSummary.state == ClassViewDetailSummary.empty) {
            return const Center(
              child: FontPop16w400Black(
                  text: "Data Kosong", textAlign: TextAlign.center),
            );
          } else {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 48),
                    const RowCustomToolbar(toolbar: "Detail Makanan"),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: size.width,
                      child: FontPop16w400Black(
                        text: widget.title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 1,
                      color: MyColors.grey(),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refreshPage,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RowCustomImage(
                                tipeDiet: dataDetailSummary.diet
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                image: widget.image,
                                title: widget.title,
                              ),
                              const SizedBox(height: 16),
                              const FontPop14w400Black(text: "Deskripsi :"),
                              const SizedBox(height: 8),
                              isValid
                                  ? const FontPop12w400Semi(text: "-")
                                  : FontPop12w400Semi(text: deskripsi),
                              const SizedBox(height: 16),
                              const FontPop14w400Black(text: "Bahan - Bahan :"),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 160,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: dataDetailSummary
                                          .extendedIngredients?.length ??
                                      0,
                                  itemBuilder: (context, i) {
                                    return RowNumber(
                                      number: '${i + 1}.',
                                      value: dataDetailSummary
                                              .extendedIngredients?[i].name ??
                                          "",
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              const FontPop14w400Black(text: "Tipe Hidangan :"),
                              const SizedBox(height: 8),
                              FontPop12w400Semi(
                                text: dataDetailSummary.dishType
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _refreshPage() async {
    setState(() {
      Provider.of<ViewDetailSummary>(context, listen: false).fetchDetailSummary(
        widget.id,
      );
    });
  }
}
