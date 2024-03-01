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
  static generate(ProductsModel productsModel, PdfPageFormat? format,) async {
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
        productsModel.numDresses??'',
        productsModel.length??'',
        productsModel.chestLength??'',
        productsModel.neck??'',
        productsModel.handLength??'',
        productsModel.kLength??'',
        productsModel.mLength??''
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
                  child: pw.Text(

                      productsModel.date.toString(),

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

  static generate2(ProductsModel productsModel, PdfPageFormat? format,) async {
    final pdf = pw.Document();
    var data = await rootBundle.load("fonts/IBMPlexSansArabic-Bold.ttf");
    final ttf = Font.ttf(data);
    final iconImage =
    (await rootBundle.load('images/crown.png')).buffer.asUint8List();

    final tableHeaders2 = [
      'الساعه',
      'التاريخ',
      'التليفون',
      'العنوان',
      "الاسم",
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
        DateFormat("yyyy-MM-dd").format(DateTime.parse(
          productsModel.date.toString(),
        )),
        DateFormat("yyyy-MM-dd").format(DateTime.parse(
          productsModel.date.toString(),
        )),
        productsModel.phone,
        productsModel.address,
        productsModel.name,
      ],
    ];
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
        productsModel.numDresses.toString(),
        productsModel.length.toString(),
        productsModel.chestLength.toString(),
        productsModel.neck.toString(),
        productsModel.handLength.toString(),
        productsModel.kLength.toString(),
        productsModel.mLength.toString()
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
            pw.Divider(),
            pw.SizedBox(height: 40),
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
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerRight,
                  2: pw.Alignment.centerRight,
                  3: pw.Alignment.centerRight,
                  4: pw.Alignment.centerRight,
                },
              ),
            ),
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
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Table.fromTextArray(
                headers: tableHeaders3,
                data: tableData3,
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
            pw.Divider(),

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
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Divider(),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Text(
                'اولاد ابو سلطح',
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text("street-200street-00"),
                  pw.Text(
                    'Address: ',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'admin@gmail.com',
                  ),
                  pw.Text(
                    'Email: ',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return FileHandleApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

}
