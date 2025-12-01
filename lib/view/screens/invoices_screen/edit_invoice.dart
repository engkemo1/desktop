import 'package:collection/collection.dart';
import 'package:desktop_app/Model/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Model/products_model.dart';
import '../../../constants.dart';
import '../../../view_model/cubit/products_cubit/products_cubit.dart';
import '../add_screen/add_screen.dart';
import '../add_screen/cubit/add_invoice_cubit.dart';
import '../add_screen/widgets/additions_section.dart';
import '../add_screen/widgets/customer_section.dart';
import '../add_screen/widgets/date_section.dart';
import '../add_screen/widgets/fabric_type_section.dart';
import '../add_screen/widgets/measurements_section.dart';
import '../add_screen/widgets/payment_section.dart';

class EditProductScreen extends StatefulWidget {
  final ProductsModel product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  SingingCharacter? _character;
  String? _dropDownValueA;
  String? _dropDownValueB;
  String? _dropDownValueC;
  List<CategoryModel> categoryModel = [];

  String formatDate(String? raw) {
    if (raw == null || raw.isEmpty) return "";

    try {
      final date = DateTime.parse(raw);
      return "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year}";
    } catch (e) {
      return raw; // لو كان غير قابل للبارسينج رجّع النص كما هو
    }
  }

  @override
  void initState() {
    super.initState();

    final cubit = context.read<AddInvoiceCubit>();
    final p = widget.product;

    /// ===============================
    ///      BASIC INFORMATION
    /// ===============================
    ///
    print(widget.product.type);
    _character = widget.product.type == "بلدي"
        ? SingingCharacter.balady
        : SingingCharacter.afrangy;

    _dropDownValueA = widget.product.additionalType1;
    _dropDownValueB = widget.product.additionalType2;
    _dropDownValueC = widget.product.additionalType1;

    cubit.codeController.text = p.code.toString() ?? "";
    cubit.categoryName = p.type.toString() ?? "";
    cubit.nameController.text = p.name ?? "";
    cubit.phoneController.text = p.phone ?? "";
    cubit.addressController.text = p.address ?? "";
    cubit.dateController.text = formatDate(p.date ?? "");
    cubit.dateDeliveryController.text = formatDate(p.deliveryTime);

    /// ===============================
    ///      PAYMENT SECTION
    /// ===============================

    cubit.totalController.text = p.total?.toString() ?? "";
    cubit.amountPaidController.text = p.amountPaid?.toString() ?? "";
    cubit.remainingAmountController.text = p.remainingAmount?.toString() ?? "";
    cubit.prizeController.text = p.prize?.toString() ?? "";
    cubit.worker_costController.text = p.workerCost?.toString() ?? "";

    /// ===============================
    ///        MEASUREMENTS
    /// ===============================

    cubit.lengthController.text = p.length?.toString() ?? "";
    cubit.glabController.text = p.length?.toString() ?? "";

    cubit.badnLengthController1.text = p.badnSize1?.toString() ?? "";
    cubit.badnLengthController2.text = p.badnSize2?.toString() ?? "";
    cubit.badnLengthController3.text = p.badnSize3?.toString() ?? "";

    cubit.hand1LengthController.text = p.handLength?.toString() ?? "";
    cubit.hand2LengthController.text = p.hand2Length?.toString() ?? "";

    cubit.k1LengthController.text = p.kLength?.toString() ?? "";
    cubit.k2LengthController.text = p.k2Length?.toString() ?? "";

    cubit.taqwera1LengthController.text = p.droppTaqwera1?.toString() ?? "";
    cubit.taqwera2LengthController.text = p.droppTaqwera2?.toString() ?? "";
    cubit.taqwera3LengthController.text = p.droppTaqwera3?.toString() ?? "";

    cubit.chestLengthController.text = p.chestLength?.toString() ?? "";
    cubit.ketfLengthController.text = p.ketfLength?.toString() ?? "";
    cubit.neckController.text = p.neck?.toString() ?? "";

    cubit.komLengthController.text = p.komLength?.toString() ?? "";
    cubit.numDressesController.text = p.numDresses?.toString() ?? "";

    /// ===============================
    ///        FABRIC SECTION
    /// ===============================

    cubit.typeController.text = p.fyberType ?? "";
    print(categoryModel);

    ProductCubit().getDataCategory().then((value) {
      final selected = value.where((e) => e.type == p.fyberType);
      final item = selected.isNotEmpty ? selected.first : null;
      print(item);
      print(item);
      if (item != null) {
        cubit.totalTypeController.text =
            (p.quantity ?? 0 * item?.price ?? 0).toString() ?? "";
        cubit.quantityTypeController.text = item?.quantity.toString() ?? "";
        cubit.priceTypeController.text = item?.price.toString() ?? "";
        print(item.price);
        print(item.price);
        print(item.price);
        print(p.fyberType);
      } else {
        cubit.totalTypeController.text = "";
        cubit.quantityTypeController.text = "";
        cubit.priceTypeController.text = "";
      }
    });

    cubit.quantityController.text = p.quantity.toString() ?? "";

    cubit.categoryName = p.fyberType;

    /// ===============================
    ///        ADDITIONS SECTION
    /// ===============================

    cubit.sadrController.text = p.sadrSize?.toString() ?? "";
    cubit.komController.text = p.komSize?.toString() ?? "";
    cubit.glabController.text = p.glabSize?.toString() ?? "";
    cubit.ganbController.text = p.ganbSize?.toString() ?? "";
    cubit.gybController.text = p.gaybSize?.toString() ?? "";
    cubit.taqweraController.text = p.taqweraSize?.toString() ?? "";
    cubit.ya2aController.text = p.yaqaSize?.toString() ?? "";

    /// selected images
    cubit.sadrPath = p.sadr;
    cubit.komPath = p.kom;
    cubit.glabPath = p.glab;
    cubit.ganbPath = p.ganb;
    cubit.gybPath = p.gayb;
    cubit.yaqaPath = p.yaqa;
    cubit.taqweraPath = p.taqwera;

    /// ===============================
    ///        SHA3RAWY FIELDS
    /// ===============================

    cubit.field1Controller.text = p.komSha3rawyLenght1?.toString() ?? "";
    cubit.field2Controller.text = p.komSha3rawyLenght2?.toString() ?? "";
    cubit.field3Controller.text = p.komSha3rawyLenght3?.toString() ?? "";
    cubit.field4Controller.text = p.komSha3rawyLenght4?.toString() ?? "";
    print(cubit.field1Controller.text);
    print(cubit.field2Controller.text);
    print(cubit.field3Controller.text);
    print(cubit.field4Controller.text);

    /// ===============================
    ///        BALADY FIELDS
    /// ===============================

    cubit.fieldKom1Controller.text = p.komBaladyLenght1?.toString() ?? "";
    cubit.fieldKom2Controller.text = p.komBaladyLenght2?.toString() ?? "";
    cubit.fieldKom3Controller.text = p.komBaladyLenght3?.toString() ?? "";
    cubit.fieldKom4Controller.text = p.komBaladyLenght4?.toString() ?? "";
    print(cubit.fieldKom1Controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddInvoiceCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text("تعديل الفاتورة رقم ${widget.product.code}",style: TextStyle(color: Colors.white),),
        backgroundColor: primaryColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/login.jpg"), fit: BoxFit.cover),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                /// بيانات العميل
                CustomerSection(),

                const SizedBox(height: 20),

                /// قسم المقاسات
                const MeasurementsSection(),

                const SizedBox(height: 20),

                _buildOrderSection(),

                const SizedBox(height: 20),

                /// نوع القماش
                const FabricTypeSection(),

                const SizedBox(height: 20),

                /// قسم الدفع
                const PaymentSection(),

                const SizedBox(height: 20),

                /// التاريخ
                const DateSection(),

                const SizedBox(height: 20),

                /// الإضافات
                const AdditionsSection(),

                const SizedBox(height: 40),

                /// زر حفظ التعديلات
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      backgroundColor: Colors.green,
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    final cubit = context.read<AddInvoiceCubit>();

                    // حساب الفرق بين المدفوع والإجمالي
                    double total =
                        double.tryParse(cubit.totalController.text) ?? 0.0;
                    double paid =
                        double.tryParse(cubit.amountPaidController.text) ?? 0.0;
                    double remaining = total - paid;
                    double overpay = paid - total;

                    // بناء الـ ProductsModel
                    final product = ProductsModel(
                      sId: widget.product.sId,
                      name: cubit.nameController.text,
                      date: cubit.dateController.text,
                      deliveryTime: cubit.dateDeliveryController.text,
                      length: double.tryParse(cubit.lengthController.text),
                      ketfLength:
                          double.tryParse(cubit.ketfLengthController.text),
                      komLength:
                          double.tryParse(cubit.komLengthController.text),
                      chestLength:
                          double.tryParse(cubit.chestLengthController.text),
                      neck: double.tryParse(cubit.neckController.text),
                      handLength:
                          double.tryParse(cubit.hand1LengthController.text),
                      hand2Length:
                          double.tryParse(cubit.hand2LengthController.text),
                      kLength: double.tryParse(cubit.k1LengthController.text),
                      k2Length: double.tryParse(cubit.k2LengthController.text),
                      taqweraSize:
                          double.tryParse(cubit.taqweraController.text),
                      droppTaqwera1:
                          double.tryParse(cubit.taqwera1LengthController.text),
                      droppTaqwera2:
                          double.tryParse(cubit.taqwera2LengthController.text),
                      droppTaqwera3:
                          double.tryParse(cubit.taqwera3LengthController.text),
                      badnSize1:
                          double.tryParse(cubit.badnLengthController1.text),
                      badnSize2:
                          double.tryParse(cubit.badnLengthController2.text),
                      badnSize3:
                          double.tryParse(cubit.badnLengthController3.text),
                      glabSize: double.tryParse(cubit.glabController.text),
                      ganbSize: double.tryParse(cubit.ganbController.text),
                      gaybSize: double.tryParse(cubit.gybController.text),
                      yaqaSize: double.tryParse(cubit.ya2aController.text),
                      sadrSize: double.tryParse(cubit.sadrController.text),
                      komSize: double.tryParse(cubit.komController.text),
                      kom:cubit.komPath,
                      sadr: cubit.sadrPath,
                      gayb: cubit.gybPath,
                      ganb: cubit.ganbPath,
                      taqwera: cubit.taqweraPath,
                      yaqa: cubit.yaqaPath,
                      glab: cubit.glabPath,
                      komBalady: "images/كم-بلدي1.png",
                      komSha3rawy: "images/png.png",
                      komBaladyLenght1:cubit.fieldKom1Controller.text ,
                      komBaladyLenght2:cubit.fieldKom2Controller.text ,
                      komBaladyLenght3:cubit.fieldKom3Controller.text ,
                      komBaladyLenght4:cubit.fieldKom4Controller.text ,
                      komSha3rawyLenght1:cubit.field1Controller.text ,
                      komSha3rawyLenght2:cubit.field2Controller.text ,
                      komSha3rawyLenght3:cubit.field3Controller.text ,
                      komSha3rawyLenght4:cubit.field4Controller.text ,
                      image: "ds",
                      // ممكن تعدل حسب الصورة
                      address: cubit.addressController.text,
                      phone: cubit.phoneController.text,
                      numDresses:
                          double.tryParse(cubit.numDressesController.text),
                      amountPaid: paid,
                      remainingAmount: remaining,
                      quantity: double.tryParse(cubit.quantityController.text),
                      prize: double.tryParse(cubit.prizeController.text),
                      workerCost: cubit.worker_costController.text,
                      total: cubit.totalController.text,
                      code: cubit.codeController.text,
                      type: _character ==
                          SingingCharacter
                              .afrangy
                          ? "افرنجي"
                          : "بلدي",
                      fyberType: cubit.typeController.text,
                      additionalType1: _character == SingingCharacter.afrangy
                          ? _dropDownValueA
                          : _dropDownValueC,
                      additionalType2: _dropDownValueB,
                      createdAt: DateTime.now().toString(),
                    );

                    // ارسال البيانات للـ API
                    await ProductCubit()
                        .updateByDeleteThenAdd(context, product).then((onValue){  Navigator.pop(context);
                    Navigator.pop(context);});
                  },
                  child: const Text("حفظ التعديلات"),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSection() {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(child: Divider(color: Colors.white)),
              Text(
                "     بيانات الطلب    ",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Expanded(child: Divider(color: Colors.white)),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    const Text(
                      'نوع التفصيل : ',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),

                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              child: RadioListTile(
                                title: const Text(
                                  'افرنجي',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                value: SingingCharacter.afrangy,
                                activeColor: buttonColor,
                                groupValue: _character,
                                onChanged: (value) {
                                  final cubit = context.read<AddInvoiceCubit>();
                                  cubit.updateCategory(value?.name ?? "");
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          _character == SingingCharacter.afrangy
                              ? Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xffBCEFC2),
                                          ),
                                          child: DropdownButton(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            underline: SizedBox(),
                                            hint: _dropDownValueA == null
                                                ? Text(
                                                    'اضغط للاختيار',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : Text(
                                                    _dropDownValueA!,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                            isExpanded: true,
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            items: [
                                              'قطري',
                                              'سعودي',
                                              'كويتي',
                                              "بولاقي",
                                              "كوم سادة عماني",
                                              "شعراوي كوم سادة",
                                              "سوداني كوم سادة"
                                            ]
                                                .map(
                                                  (val) =>
                                                      DropdownMenuItem<String>(
                                                    value: val,
                                                    child: Text(val),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (val) {
                                              setState(
                                                  () => _dropDownValueA = val);
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      (_dropDownValueA == "قطري" ||
                                              _dropDownValueA == "سعودي" ||
                                              _dropDownValueA == "كويتي" ||
                                              _dropDownValueA == "بولاقي")
                                          ? Expanded(
                                              flex: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xffBCEFC2),
                                                ),
                                                child: DropdownButton(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  underline: SizedBox(),
                                                  hint: _dropDownValueB == null
                                                      ? Text(
                                                          'اضغط للاختيار ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      : Text(
                                                          _dropDownValueB!,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                        ),
                                                  isExpanded: true,
                                                  padding: EdgeInsets.only(
                                                      left: 20, right: 20),
                                                  items: [
                                                    '2 كباسين كوم سادة',
                                                    '2 كباسين كوم كبك',
                                                    'جلاب كوم سادة',
                                                    'جلاب كوم كبك',
                                                    "2 كباسين كوم سادة بشليك",
                                                    "2 كباسين كوم سادة بشليك لزق مفتوح",
                                                  ]
                                                      .map(
                                                        (val) =>
                                                            DropdownMenuItem(
                                                          value: val,
                                                          child: Text(val),
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged: (val) {
                                                    setState(() =>
                                                        _dropDownValueB = val);
                                                  },
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          Spacer(),
                        ],
                      ),
                    ),

                    /// ================================
                    ///            بلدي
                    /// ================================
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: RadioListTile(
                              title: const Text(
                                'بلدي',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: SingingCharacter.balady,
                              groupValue: _character,
                              activeColor: buttonColor,
                              onChanged: (value) {
                                final cubit = context.read<AddInvoiceCubit>();
                                cubit.updateCategory(value?.name ?? "");
                                print(cubit.categoryName);
                                setState(() => _character = value);
                              },
                            ),
                          ),
                          _character == SingingCharacter.balady
                              ? Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffBCEFC2),
                                    ),
                                    child: DropdownButton(
                                      borderRadius: BorderRadius.circular(10),
                                      underline: SizedBox(),
                                      hint: _dropDownValueC == null
                                          ? Text(
                                              'اضغط للاختيار',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              _dropDownValueC!,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                      isExpanded: true,
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      items: [
                                        'كلفة تامة بشليك',
                                        'كلفة تامة نص ياقة',
                                        'قشره',
                                        "اسطنبولي",
                                      ]
                                          .map(
                                            (val) => DropdownMenuItem(
                                              value: val,
                                              child: Text(val),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (val) {
                                        setState(() => _dropDownValueC = val);
                                      },
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
