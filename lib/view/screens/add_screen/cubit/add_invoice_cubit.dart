import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

import '../../../../Model/category_model.dart';
import '../../../../Model/products_model.dart';
import '../../../../view_model/cubit/products_cubit/products_cubit.dart';

import '../../pdf_invoice/pdf.dart';
import '../data/image_lists.dart';
import '../cubit/add_invoice_state.dart';

class AddInvoiceCubit extends Cubit<AddInvoiceState> {

  /// ===============================
  ///         CONTROLLERS
  /// ===============================

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();
  final dateDeliveryController = TextEditingController();

  // additions controllers
  final field1Controller = TextEditingController();
  final field2Controller = TextEditingController();
  final field3Controller = TextEditingController();
  final field4Controller = TextEditingController();

  final fieldKom1Controller = TextEditingController();
  final fieldKom2Controller = TextEditingController();
  final fieldKom3Controller = TextEditingController();
  final fieldKom4Controller = TextEditingController();

  // size controllers
  final ya2aController = TextEditingController();
  final taqweraController = TextEditingController();
  final sadrController = TextEditingController();
  final komController = TextEditingController();
  final glabController = TextEditingController();
  final ganbController = TextEditingController();
  final gybController = TextEditingController();

  final amountPaidController = TextEditingController();
  final totalController = TextEditingController();
  final remainingAmountController = TextEditingController();
  final prizeController = TextEditingController();
  final worker_costController = TextEditingController();

  final lengthController = TextEditingController();
  final badnLengthController1 = TextEditingController();
  final badnLengthController2 = TextEditingController();
  final badnLengthController3 = TextEditingController();

  final hand1LengthController = TextEditingController();
  final hand2LengthController = TextEditingController();

  final k1LengthController = TextEditingController();
  final k2LengthController = TextEditingController();

  final taqwera1LengthController = TextEditingController();
  final taqwera2LengthController = TextEditingController();
  final taqwera3LengthController = TextEditingController();

  final chestLengthController = TextEditingController();
  final ketfLengthController = TextEditingController();
  final neckController = TextEditingController();

  final totalTypeController = TextEditingController();
  final quantityController = TextEditingController();
  final quantityTypeController = TextEditingController();
  final typeController = TextEditingController();
  final priceTypeController = TextEditingController();

  final komLengthController = TextEditingController();
  final numDressesController = TextEditingController();
  final codeController = TextEditingController();

  /// ===============================
  ///       DROPDOWN VARIABLES
  /// ===============================

  String? selectedAdditionalA;
  String? selectedAdditionalB;
  String? selectedAdditionalC;

  String? categoryName;
  String? invoiceCode;


  /// ===============================
  ///       IMAGE SELECTIONS
  /// ===============================

  final lists = ImageLists();

  int sadrIndex = 0;
  int komIndex = 0;
  int glabIndex = 0;
  int ganbIndex = 0;
  int gybIndex = 0;
  int taqweraIndex = 0;
  int yaqaIndex = 0;

  String? sadrPath;
  String? komPath;
  String? glabPath;
  String? ganbPath;
  String? gybPath;
  String? taqweraPath;
  String? yaqaPath;


  AddInvoiceCubit()
      : super(AddInvoiceState(
    selectedDate: DateFormat.yMd().format(DateTime.now()),
    selectedDeliveryDate:
    DateFormat.yMd().format(DateTime.now().add(const Duration(days: 10))),
    showOverpay: false,
  ))
  {
    /// initial selected images
    sadrPath = lists.list6[sadrIndex];
    komPath = lists.list7[komIndex];
    glabPath = lists.list3[glabIndex];
    ganbPath = lists.list4[ganbIndex];
    gybPath = lists.list5[gybIndex];
    taqweraPath = lists.list1[taqweraIndex];
    yaqaPath = lists.list2[yaqaIndex];

    dateController.text = state.selectedDate;
    dateDeliveryController.text = state.selectedDeliveryDate;
  }
  void selectFabricType(CategoryModel item) {
    typeController.text = item.type ?? '';
    quantityTypeController.text = item.quantity.toString();
    priceTypeController.text = item.price.toString();

    updateFabricTotals();
  }


  /// ===============================
  ///         DATE PICKERS
  /// ===============================
  void updateFabricTotals() {
    final q = double.tryParse(quantityController.text) ?? 0;
    final available = double.tryParse(quantityTypeController.text) ?? 0;
    final price = double.tryParse(priceTypeController.text) ?? 0;

    // تحديث الكمية المتاحة
    quantityTypeController.text = (available - q).toStringAsFixed(2);

    // إجمالي النوع
    totalTypeController.text = (q * price).toStringAsFixed(2);

    // إعادة حساب الإجمالي العام
    recalculateTotal();
  }

  void selectDate(String formatted) {
    dateController.text = formatted;
    emit(state.copyWith(selectedDate: formatted));
  }

  void selectDeliveryDate(String formatted) {
    dateDeliveryController.text = formatted;
    emit(state.copyWith(selectedDeliveryDate: formatted));
  }


  ProductsModel buildUpdatedProduct(String id) {
    String formatDate(String input) {
      try {
        final dt = DateFormat('dd/MM/yyyy').parse(input);
        return DateFormat('yyyy-MM-dd').format(dt);
      } catch (_) {
        return input;
      }
    }

    return ProductsModel(
      sId: id,
      name: nameController.text,
      phone: phoneController.text,
      address: addressController.text,

      date: formatDate(dateController.text),
      deliveryTime: formatDate(dateDeliveryController.text),

      prize: prizeController.text,
      workerCost: worker_costController.text,
      amountPaid: amountPaidController.text,
      remainingAmount: remainingAmountController.text,
      total: totalController.text,

      type: typeController.text,
      quantity: quantityController.text,

      numDresses: numDressesController.text,
      length: lengthController.text,
      ketfLength: ketfLengthController.text,
      komLength: komLengthController.text,
      chestLength: chestLengthController.text,
      neck: neckController.text,
      handLength: hand1LengthController.text,
      hand2Length: hand2LengthController.text,
      kLength: k1LengthController.text,
      k2Length: k2LengthController.text,
      droppTaqwera1: taqwera1LengthController.text,
      droppTaqwera2: taqwera2LengthController.text,
      droppTaqwera3: taqwera3LengthController.text,
      badnSize1: badnLengthController1.text,
      badnSize2: badnLengthController2.text,
      badnSize3: badnLengthController3.text,

      sadr: sadrPath ?? '',
      yaqa: yaqaPath ?? '',
      kom: komPath ?? '',
      glab: glabPath ?? '',
      ganb: ganbPath ?? '',
      gayb: gybPath ?? '',
      taqwera: taqweraPath ?? '',

      komSha3rawyLenght1: field1Controller.text,
      komSha3rawyLenght2: field2Controller.text,
      komSha3rawyLenght3: field3Controller.text,
      komSha3rawyLenght4: field4Controller.text,

      komBaladyLenght1: fieldKom1Controller.text,
      komBaladyLenght2: fieldKom2Controller.text,
      komBaladyLenght3: fieldKom3Controller.text,
      komBaladyLenght4: fieldKom4Controller.text,

      code: codeController.text.isNotEmpty ? codeController.text : Random(),
    );
  }

  /// ===============================
  ///       IMAGE PICK HANDLERS
  /// ===============================

  void selectSadr(int index) {
    sadrIndex = index;
    sadrPath = lists.list6[index];
    emit(state);
  }
  void updateCategory(String category) {
    categoryName = category;
    emit(state);
  }
  void selectKom(int index) {
    komIndex = index;
    komPath = lists.list7[index];
    emit(state);
  }

  void selectGlab(int index) {
    glabIndex = index;
    glabPath = lists.list3[index];
    emit(state);
  }

  void selectGanb(int index) {
    ganbIndex = index;
    ganbPath = lists.list4[index];
    emit(state);
  }

  void selectGyb(int index) {
    gybIndex = index;
    gybPath = lists.list5[index];
    emit(state);
  }

  void selectTaqwera(int index) {
    taqweraIndex = index;
    taqweraPath = lists.list1[index];
    emit(state);
  }

  void selectYaqa(int index) {
    yaqaIndex = index;
    yaqaPath = lists.list2[index];
    emit(state);
  }


  /// ===============================
  ///       PAYMENT CALCULATIONS
  /// ===============================

  void recalculateTotal() {
    final prize = double.tryParse(prizeController.text) ?? 0;
    final worker = double.tryParse(worker_costController.text) ?? 0;

    final total = prize + worker;

    totalController.text = total.toStringAsFixed(2);

    recalculateRemaining();
  }

  void recalculateRemaining() {
    final total = double.tryParse(totalController.text) ?? 0;
    final paid = double.tryParse(amountPaidController.text) ?? 0;

    final remaining = total - paid;

    remainingAmountController.text = remaining.toStringAsFixed(2);

    emit(state.copyWith(showOverpay: paid > total));
  }


  /// ===============================
  ///       BUILD PRODUCT MODEL
  /// ===============================

  ProductsModel buildProductModel({required String createdById}) {
    return ProductsModel(
      name: nameController.text,
      date: dateController.text,
      deliveryTime: dateDeliveryController.text,

      phone: phoneController.text,
      address: addressController.text,

      code: codeController.text,
      quantity: quantityController.text,

      prize: double.tryParse(totalController.text),
      total: totalController.text,
      amountPaid: double.tryParse(amountPaidController.text),
      remainingAmount: double.tryParse(remainingAmountController.text),
      workerCost: worker_costController.text,

      // lengths
      length: double.tryParse(lengthController.text),
      badnSize1: double.tryParse(badnLengthController1.text),
      badnSize2: double.tryParse(badnLengthController2.text),
      badnSize3: double.tryParse(badnLengthController3.text),

      handLength: double.tryParse(hand1LengthController.text),
      hand2Length: double.tryParse(hand2LengthController.text),

      kLength: double.tryParse(k1LengthController.text),
      k2Length: double.tryParse(k2LengthController.text),

      droppTaqwera1: double.tryParse(taqwera1LengthController.text),
      droppTaqwera2: double.tryParse(taqwera2LengthController.text),
      droppTaqwera3: double.tryParse(taqwera3LengthController.text),

      chestLength: double.tryParse(chestLengthController.text),
      ketfLength: double.tryParse(ketfLengthController.text),
      komLength: double.tryParse(komLengthController.text),
      neck: double.tryParse(neckController.text),

      // fabric
      fyberType: categoryName,
      // q: quantityTypeController.text,
      // priceType: priceTypeController.text,
      // totalType: totalTypeController.text,

      // other
      numDresses: double.tryParse(numDressesController.text),
      type: selectedAdditionalA != null ? "افرنجي" : "بلدي",

      // additions (image + numeric)
      sadr: sadrPath,
      kom: komPath,
      glab: glabPath,
      ganb: ganbPath,
      gayb: gybPath,
      taqwera: taqweraPath,
      yaqa: yaqaPath,

      sadrSize: double.tryParse(sadrController.text),
      komSize: double.tryParse(komController.text),
      glabSize: double.tryParse(glabController.text),
      ganbSize: double.tryParse(ganbController.text),
      gaybSize: double.tryParse(gybController.text),
      taqweraSize: double.tryParse(taqweraController.text),
      yaqaSize: double.tryParse(ya2aController.text),

      // sha3rawy fields
      komSha3rawyLenght1: double.tryParse(field1Controller.text),
      komSha3rawyLenght2: double.tryParse(field2Controller.text),
      komSha3rawyLenght3: double.tryParse(field3Controller.text),
      komSha3rawyLenght4: double.tryParse(field4Controller.text),

      // balady fields
      komBaladyLenght1: double.tryParse(fieldKom1Controller.text),
      komBaladyLenght2: double.tryParse(fieldKom2Controller.text),
      komBaladyLenght3: double.tryParse(fieldKom3Controller.text),
      komBaladyLenght4: double.tryParse(fieldKom4Controller.text),

      createdAt: DateTime.now().toString(),
    );
  }


  /// ===============================
  ///       SUBMIT PRODUCT
  /// ===============================

  Future<void> submitProduct(BuildContext context) async {
    final model = buildProductModel(createdById: "");
    final productCubit = ProductCubit();
    await productCubit.postProduct(context, model);
    emit(state);
  }


  /// ===============================
  ///       PRINTING
  /// ===============================

  Future<void> printInvoice(ProductsModel model) async {
    final pdfFile = await PdfInvoiceApi.generate(model, null);
    await Printing.layoutPdf(onLayout: (_) async => pdfFile.save());
  }


  /// ===============================
  ///       DISPOSE
  /// ===============================

  @override
  Future<void> close() {
    final all = [
      nameController, phoneController, addressController,
      dateController, dateDeliveryController,
      field1Controller, field2Controller, field3Controller, field4Controller,
      fieldKom1Controller, fieldKom2Controller, fieldKom3Controller, fieldKom4Controller,
      ya2aController, taqweraController, sadrController, komController,
      glabController, ganbController, gybController,
      amountPaidController, totalController, remainingAmountController,
      prizeController, worker_costController,
      lengthController, badnLengthController1, badnLengthController2, badnLengthController3,
      hand1LengthController, hand2LengthController,
      k1LengthController, k2LengthController,
      taqwera1LengthController, taqwera2LengthController, taqwera3LengthController,
      chestLengthController, ketfLengthController, neckController,
      totalTypeController, quantityController, quantityTypeController, priceTypeController,typeController,
      komLengthController, numDressesController, codeController,
    ];

    for (var c in all) {
      c.dispose();
    }
    return super.close();
  }
}
