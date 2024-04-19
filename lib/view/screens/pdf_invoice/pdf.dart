import 'dart:io';
import 'package:desktop_app/Model/products_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'file_handeler.dart';

class PdfInvoiceApi {
  static generate(
    ProductsModel productsModel,
    PdfPageFormat? format,
  ) async {
    final pdf = pw.Document();
    var data = await rootBundle.load("fonts/IBMPlexSansArabic-Bold.ttf");
    final ttf = Font.ttf(data);
    final iconImage =
        (await rootBundle.load('images/crown.png')).buffer.asUint8List();

    final tableHeaders = [
      'عدد الاثواب',
      'الطول',
      'وسع الصدر',
      'الرقبة',
      'وسع اليد',
      'طول الكيك',
      'المفصل',
    ];

    final tableData = [
      [
        productsModel.numDresses ?? '',
        productsModel.length ?? '',
        productsModel.chestLength ?? '',
        productsModel.neck ?? '',
        productsModel.handLength ?? '',
        productsModel.kLength ?? '',
        productsModel.mLength ?? ''
      ],
    ];

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        theme: ThemeData.withFont(
          base: ttf,
        ),
        textDirection: pw.TextDirection.rtl,
        build: (context) {
          return [
            pw.Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pw.Image(
                  pw.MemoryImage(iconImage),
                  height: 72,
                  width: 72,
                ),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('              اولاد ابو سلطح',
                        style: pw.TextStyle(
                          fontSize: 17.0,
                        ),
                        textAlign: TextAlign.center),
                    pw.Text(
                        'لخياطة جميع انواع الملابس الرجالي \n ادارة الحاج عبد النبي ابو سلطح \nواولاد ايمن - محمد',
                        textDirection: pw.TextDirection.rtl,
                        style: const pw.TextStyle(
                          fontSize: 15.0,
                          color: PdfColors.grey700,
                        ),
                        textAlign: TextAlign.center),
                  ],
                ),
                SizedBox(
                  width: 100,
                  child: pw.Text(productsModel.date.toString(),
                      textAlign: TextAlign.end),
                )
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 40),

            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            ///
            /// PDF Table Create
            ///

            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Table.fromTextArray(
                headers: tableHeaders,
                data: tableData,
                border: null,
                headerDecoration:
                    const pw.BoxDecoration(color: PdfColors.grey300),
                cellHeight: 30.0,
                headerAlignment: Alignment.center,
                cellAlignments: {
                  0: pw.Alignment.center,
                  1: pw.Alignment.center,
                  2: pw.Alignment.center,
                  3: pw.Alignment.center,
                  4: pw.Alignment.center,
                  5: pw.Alignment.center,
                  6: pw.Alignment.center,
                },
              ),
            ),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Divider(),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Text(
                'Jacobia',
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text("Email :jacobia@gmail.com"),
                ],
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    ' support: 032134212',
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  static generate2(
    ProductsModel productsModel,
    PdfPageFormat? format,
  ) async {
    final pdf = pw.Document();
    var data = await rootBundle.load("fonts/IBMPlexSansArabic-Bold.ttf");
    final ttf = Font.ttf(data);
    final iconImage =
        (await rootBundle.load('images/crown.png')).buffer.asUint8List();
    print(productsModel.sadr);
    final kom = (await rootBundle.load(productsModel.kom!.length == 0
            ? "images/crown.png"
            : productsModel.kom.toString()))
        .buffer
        .asUint8List();
    final sadr = (await rootBundle.load(productsModel.sadr!.length == 0
            ? "images/crown.png"
            : productsModel.sadr.toString()))
        .buffer
        .asUint8List();

    final taqwera = (await rootBundle.load(productsModel.taqwera!.length == 0
            ? "images/crown.png"
            : productsModel.taqwera.toString()))
        .buffer
        .asUint8List();
    final glab = (await rootBundle.load(productsModel.glab!.length == 0
            ? "images/crown.png"
            : productsModel.glab.toString()))
        .buffer
        .asUint8List();
    final gyb = (await rootBundle.load(productsModel.gayb!.length == 0
            ? "images/crown.png"
            : productsModel.gayb.toString()))
        .buffer
        .asUint8List();
    final ganb = (await rootBundle.load(productsModel.ganb!.length == 0
            ? "images/crown.png"
            : productsModel.ganb.toString()))
        .buffer
        .asUint8List();
    final yaqa = (await rootBundle.load(productsModel.yaqa!.length == 0
            ? "images/crown.png"
            : productsModel.yaqa.toString()))
        .buffer
        .asUint8List();
    final komBalady =
        (await rootBundle.load("images/كم-بلدي1.png")).buffer.asUint8List();
    final komSh3rawy =
        (await rootBundle.load("images/png.png")).buffer.asUint8List();

    final tableHeaders2 = [
      'عدد الاثواب',
      'تاريخ الاستلام',
      'التاريخ',
      'التليفون',
      'العنوان',
      "الاسم",
      "رقم الفاتورة"
    ];
    final tableHeaders3 = [
      'الكم',
      'جلاب',
      'جانب',
      'الجيب',
      "التقويرة",
      "الياقة",
      "الصدر"
    ];
    final tableData3 = [
      [
        productsModel.kom,
        productsModel.glab,
        productsModel.ganb,
        productsModel.gayb,
        productsModel.taqwera,
        productsModel.yaqa,
        productsModel.sadr
      ],
    ];

    final tableData2 = [
      [
        productsModel.numDresses.toString(),
        DateFormat("yyyy-MM-dd").format(DateTime.parse(
          productsModel.deliveryTime.toString(),
        )),
        DateFormat("yyyy-MM-dd").format(DateTime.parse(
          productsModel.date.toString(),
        )),
        productsModel.phone,
        productsModel.address,
        productsModel.name,
        productsModel.code
      ],
    ];
    final tableHeaders = [
      'الطول',
      'وسع الصدر',
      'الرقبة',
      'طول الكم',
      'الكتف',
      'وسع اليد',
      'طول الكبك',
      "سقوط التقويرة",
      "مقاس البدن",
    ];

    final tableData = [
      [
        productsModel.length.toString(),
        productsModel.chestLength.toString(),
        productsModel.neck.toString(),
        productsModel.komLength.toString(),
        productsModel.ketfLength.toString(),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            productsModel.handLength == null
                ? "0"
                : productsModel.handLength.toString(),
          ),
          Divider(),
          Text(productsModel.hand2Length == null
              ? "0"
              : productsModel.hand2Length.toString()),
        ]),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            productsModel.kLength == null
                ? "0"
                : productsModel.kLength.toString(),
          ),
          Divider(),
          Text(productsModel.k2Length == null
              ? "0"
              : productsModel.k2Length.toString()),
        ]),
        Column(children: [
          Text(productsModel.droppTaqwera1 == null
              ? "0"
              : productsModel.droppTaqwera1.toString()),
          Divider(),
          Text(productsModel.droppTaqwera2 == null
              ? "0"
              : productsModel.droppTaqwera2.toString()),
          Divider(),
          Text(productsModel.droppTaqwera3 == null
              ? "0"
              : productsModel.droppTaqwera3.toString())
        ]),
        Column(children: [
          Text(productsModel.badnSize1 == null
              ? "0"
              : productsModel.badnSize1.toString()),
          Divider(),
          Text(productsModel.badnSize2 == null
              ? "0"
              : productsModel.badnSize2.toString()),
          Divider(),
          Text(productsModel.badnSize3 == null
              ? "0"
              : productsModel.badnSize3.toString())
        ]),
      ],
    ];

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(20),
        theme: ThemeData.withFont(
          base: ttf,
        ),
        textDirection: pw.TextDirection.rtl,
        build: (context) {
          return [
            pw.Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pw.Image(
                  pw.MemoryImage(iconImage),
                  height: 72,
                  width: 72,
                ),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('              اولاد ابو سلطح',
                        style: pw.TextStyle(
                          fontSize: 17.0,
                        ),
                        textAlign: TextAlign.center),
                    pw.Text(
                        'لخياطة جميع انواع الملابس الرجالي \n ادارة الحاج عبد النبي ابو سلطح \nواولاد ايمن - محمد',
                        textDirection: pw.TextDirection.rtl,
                        style: const pw.TextStyle(
                          fontSize: 15.0,
                          color: PdfColors.grey700,
                        ),
                        textAlign: TextAlign.center),
                  ],
                ),
                SizedBox(
                  width: 100,
                  child: pw.Text(
                      DateFormat().format(
                        DateTime.parse(
                          productsModel.date.toString(),
                        ),
                      ),
                      textAlign: TextAlign.end),
                )
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            Divider(),
            Divider(),
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Table.fromTextArray(
                headers: tableHeaders2,
                data: tableData2,
                border: null,
                headerDecoration:
                    const pw.BoxDecoration(color: PdfColors.grey300),
                cellHeight: 30.0,
                cellAlignments: {
                  0: pw.Alignment.center,
                  1: pw.Alignment.center,
                  2: pw.Alignment.center,
                  3: pw.Alignment.center,
                  4: pw.Alignment.center,
                  5: pw.Alignment.center,
                  6: pw.Alignment.center,
                },
              ),
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            ///
            /// PDF Table Create
            ///
            /// Divider(),
            Divider(),
            SizedBox(height: 10),
Row(
  children:[
    Text("نوع التفصيل : ${productsModel.type}"),
    Text("    (${productsModel.additionalType1.toString()})   "),
    Text(   "(${productsModel.additionalType2.toString()})"),
SizedBox(width: 30),
    Text("نوع القماش : ${productsModel.fyberType}"),

  ],
),
            SizedBox(height: 10),

            Row(children: [
              Expanded(
                child: Divider(),
              ),
              Text("  المقاسات  "),
              Expanded(
                child: Divider(),
              ),
            ]),

            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Table.fromTextArray(
                headers: tableHeaders,
                data: tableData,
                border: null,
                headerStyle: TextStyle(fontSize: 10),
                cellStyle: TextStyle(fontSize: 10),
                headerDecoration:
                    const pw.BoxDecoration(color: PdfColors.grey300),
                cellHeight: 30.0,
                headerAlignment: Alignment.center,
                cellAlignments: {
                  0: pw.Alignment.center,
                  1: pw.Alignment.center,
                  2: pw.Alignment.center,
                  3: pw.Alignment.center,
                  4: pw.Alignment.center,
                  5: pw.Alignment.center,
                  6: pw.Alignment.center,
               7: pw.Alignment.center,
                 8: pw.Alignment.center,

                },
              ),
            ),
            Divider(),
         

            Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  productsModel.kom!.length != 0
                      ? Column(children: [
                          pw.Image(
                            pw.MemoryImage(kom),
                            height: 100,
                            width: 100,
                          ),
                          Text("المقاس : ${productsModel.komSize.toString()}"),
                        ])
                      : SizedBox(),
                  productsModel.sadr!.length != 0
                      ? Column(children: [
                          pw.Image(
                            pw.MemoryImage(sadr),
                            height: 100,
                            width: 100,
                          ),
                          Text("المقاس : ${productsModel.sadrSize.toString()}"),
                        ])
                      : SizedBox(),
                  productsModel.taqwera!.length != 0
                      ? Column(children: [
                          pw.Image(
                            pw.MemoryImage(taqwera),
                            height: 100,
                            width: 100,
                          ),
                          Text(
                              "المقاس : ${productsModel.taqweraSize.toString()}"),
                        ])
                      : SizedBox(),
                  productsModel.yaqa!.length != 0
                      ? Column(children: [
                          pw.Image(
                            pw.MemoryImage(yaqa),
                            height: 100,
                            width: 100,
                          ),
                          Text("المقاس : ${productsModel.yaqaSize.toString()}"),
                        ])
                      : SizedBox(),
                  productsModel.ganb!.length != 0
                      ? Column(children: [
                          pw.Image(
                            pw.MemoryImage(ganb),
                            height: 100,
                            width: 100,
                          ),
                          Text("المقاس : ${productsModel.ganbSize.toString()}"),
                        ])
                      : SizedBox(),
                  productsModel.gayb!.length != 0
                      ? Column(children: [
                          pw.Image(
                            pw.MemoryImage(gyb),
                            height: 100,
                            width: 100,
                          ),
                          Text("المقاس : ${productsModel.gaybSize.toString()}"),
                        ])
                      : SizedBox(),
                  productsModel.glab!.length != 0
                      ? Column(children: [
                          pw.Image(
                            pw.MemoryImage(glab),
                            height: 100,
                            width: 100,
                          ),
                          Text("المقاس : ${productsModel.glabSize.toString()}"),
                        ])
                      : SizedBox(),
                  Stack(
                    children: [
                      ClipRRect(
                          child: pw.Image(
                        pw.MemoryImage(komBalady),
                        height: 100,
                        width: 100,
                      )),
                      Positioned(
                        top: 55,
                        right: 15,
                        child: Text(
                            productsModel.komBaladyLenght4 == null
                                ? "0"
                                : productsModel.komBaladyLenght4.toString(),
                            style: TextStyle(fontSize: 10)),
                      ),
                      Positioned(
                          top: 25,
                          right: 80,
                          child: SizedBox(
                            height: 50,
                            width: 60,
                            child: Text(
                                productsModel.komBaladyLenght3 == null
                                    ? "0"
                                    : productsModel.komBaladyLenght3
                                        .toString(),
                                style: TextStyle(fontSize: 10)),
                          )),
                      Positioned(
                        top: 25,
                        right: 8,
                        child: Text(
                            productsModel.komBaladyLenght1 == null
                                ? "0"
                                : productsModel.komBaladyLenght1.toString(),
                            style: TextStyle(fontSize: 10)),
                      ),
                      Positioned(
                        top: 25,
                        left: 43,
                        child: Text(
                            productsModel.komBaladyLenght2 == null
                                ? "0"
                                : productsModel.komBaladyLenght2.toString(),
                            style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      ClipRRect(
                          child: pw.Image(
                        pw.MemoryImage(komSh3rawy),
                        height: 100,
                        width: 100,
                      )),
                      Positioned(
                        top: 55,
                        right: 16,
                        child: Text(
                            productsModel.komSha3rawyLenght4 == null
                                ? "0"
                                : productsModel.komSha3rawyLenght4.toString(),
                            style: TextStyle(fontSize: 10)),
                      ),
                      Positioned(
                          top: 20,
                          right: 80,
                          child: SizedBox(
                            height: 50,
                            width: 60,
                            child: Text(
                                productsModel.komSha3rawyLenght3 == null
                                    ? "0"
                                    : productsModel.komSha3rawyLenght3
                                        .toString(),
                                style: TextStyle(fontSize: 10)),
                          )),
                      Positioned(
                        top: 20,
                        right: 10,
                        child: Text(
                            productsModel.komSha3rawyLenght1 == null
                                ? "0"
                                : productsModel.komSha3rawyLenght1.toString(),
                            style: TextStyle(fontSize: 10)),
                      ),
                      Positioned(
                        top: 20,
                        left: 43,
                        child: Text(
                            productsModel.komSha3rawyLenght2 == null
                                ? "0"
                                : productsModel.komSha3rawyLenght2.toString(),
                            style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                ]),
            Divider(),
            Divider(),
            SizedBox(height: 20),
            pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Row(
                children: [
                  pw.Spacer(flex: 6),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'المبلغ المدفوع',
                                style: pw.TextStyle(),
                              ),
                            ),
                            pw.Text(
                              productsModel.amountPaid.toString(),
                              style: pw.TextStyle(),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'المبلغ المتبقي',
                                style: pw.TextStyle(),
                              ),
                            ),
                            pw.Text(
                              productsModel.remainingAmount.toString(),
                              style: pw.TextStyle(),
                            ),
                          ],
                        ),
                        pw.Divider(),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'القيمة',
                                style: pw.TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            pw.Text(
                              productsModel.prize.toString(),
                              style: pw.TextStyle(),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                        pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    return FileHandleApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
