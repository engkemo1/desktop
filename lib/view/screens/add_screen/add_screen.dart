import 'dart:math';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:desktop_app/view/screens/all_data_screen.dart';
import 'package:desktop_app/view/screens/home_screen.dart';
import 'package:desktop_app/view_model/cubit/customer_cubit/customers_cubit.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/add_state.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/products_cubit.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hovering/hovering.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:toast/toast.dart';
import '../../../Model/category_model.dart';
import '../../../Model/customer_model.dart';
import '../../../Model/products_model.dart';
import '../../../constants.dart';
import '../../../random.dart';
import '../../widgets/customTextField.dart';
import '../main_screen.dart';
import '../pdf_invoice/pdf.dart';

enum SingingCharacter { balady, afrangy }

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  CarouselController buttonCarouselController1 = CarouselController();
  CarouselController buttonCarouselController2 = CarouselController();
  CarouselController buttonCarouselController3 = CarouselController();
  CarouselController buttonCarouselController4 = CarouselController();
  CarouselController buttonCarouselController5 = CarouselController();
  CarouselController buttonCarouselController6 = CarouselController();
  CarouselController buttonCarouselController7 = CarouselController();
  TextEditingController _dateDeliveryController = TextEditingController();

  TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController prizeController = TextEditingController();
  TextEditingController worker_costController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController priceTypeController = TextEditingController();
  TextEditingController quantityTypeController = TextEditingController();

  TextEditingController amountPaidController = TextEditingController();
  TextEditingController remainingAmountController = TextEditingController();
  TextEditingController numDressesController = TextEditingController();
  TextEditingController chestLengthController = TextEditingController();
  TextEditingController neckController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController k1LengthController = TextEditingController();
  TextEditingController k2LengthController = TextEditingController();

  TextEditingController mLengthController = TextEditingController();
  TextEditingController ketfLengthController = TextEditingController();
  TextEditingController komLengthController = TextEditingController();
  SingleValueDropDownController controller = SingleValueDropDownController();
  TextEditingController totalTypeController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController taqwera1LengthController = TextEditingController();
  TextEditingController taqwera2LengthController = TextEditingController();
  TextEditingController taqwera3LengthController = TextEditingController();

  TextEditingController badnLengthController1 = TextEditingController();
  TextEditingController badnLengthController2 = TextEditingController();
  TextEditingController badnLengthController3 = TextEditingController();
  TextEditingController hand1LengthController = TextEditingController();
  TextEditingController hand2LengthController = TextEditingController();

  String selectedDeliveryDate =
      DateFormat.yMd().format(DateTime.now().add(Duration(days: 10)));

  String _selectedDate = DateFormat.yMd().format(DateTime.now());
  bool controller1 = false;
  bool controller2 = false;
  bool controller3 = false;
  bool controller5 = false;
  bool controller4 = false;
  bool controller6 = false;
  bool controller7 = false;
  bool controller8 = false;
  SingingCharacter? _character = SingingCharacter.afrangy;
  bool val = false;
  var ONE = false;
  var TWO = false;
  String? _dropDownValueA;
  String? _dropDownValueB;
  String? _dropDownValueC;

  bool show = false;
  String? kom, glab, taqwera, ya2a, gyb, sadr, ganb;
  bool glab1 = false,
      glab2 = false,
      ya2a1 = false,
      ya2a2 = false,
      ya2a3 = false,
      gyb1 = false,
      gyb2 = false,
      gyb3 = false,
      ganb1 = false,
      ganb2 = false,
      taqwera1 = false,
      taqwera2 = false,
      taqwera3 = false,
      taqwera4 = false,
      kom1 = false,
      kom2 = false,
      kom3 = false,
      kom4 = false,
      kom5 = false,
      kom6 = false,
      kom7 = false,
      kom8 = false,
      kom9 = false,
      kom10 = false,
      sadr1 = false,
      sadr2 = false,
      sadr3 = false,
      sadr4 = false;
  var categoryPrice, categoryQuantity = "0";
  List<String> customer = [];
  List<String> category = [];
  List<CategoryModel> categoryModel = [];

  List<Customer> customerModel = [];
  var productsModel = ProductsModel();

  var controllerType;

  TextEditingController sadrController = TextEditingController();

  TextEditingController komController = TextEditingController();

  TextEditingController glabController = TextEditingController();

  TextEditingController ganbController = TextEditingController();

  TextEditingController gybController = TextEditingController();

  TextEditingController taqweraController = TextEditingController();

  TextEditingController ya2aController = TextEditingController();
  TextEditingController field1Controller = TextEditingController();
  TextEditingController field2Controller = TextEditingController();
  TextEditingController field3Controller = TextEditingController();
  TextEditingController field4Controller = TextEditingController();
  TextEditingController fieldKom1Controller = TextEditingController();
  TextEditingController fieldKom2Controller = TextEditingController();
  TextEditingController fieldKom3Controller = TextEditingController();
  TextEditingController fieldKom4Controller = TextEditingController();

  var categoryName;

  @override
  void initState() {
    ProductCubit().getData().then((value) {
      var val = RandomDigits.getInteger(2).toString();
      setState(() {
        value.forEach((element) {
          if (element.code == val) {
            val == (RandomDigits.getInteger(2) + 1).toString();
          } else {
            codeController.text = val;
          }
        });
      });
    });
    totalTypeController.text = "0.0";
    worker_costController.text = "0.0";
    show = false;
    CustomersCubit().getData().then((value) {
      setState(() {
        value.forEach((element) {
          customer.add(element.userName);
        });
      });
      setState(() {
        customerModel = value;
      });
    });
    ProductCubit().getDataCategory().then((value) {
      setState(() {
        value.forEach((element) {
          category.add(element.type);
        });
      });
      setState(() {
        categoryModel = value;
      });
    });

    // TODO: implement initState
    super.initState();
  }

  _selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      currentDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (selected != null) {
      _selectedDate = DateFormat.yMd().format(selected).toString();
      ProductCubit().changeDate(_selectedDate);
    } else {
      _selectedDate = DateFormat.yMd().format(DateTime.now()).toString();
      ProductCubit().changeDate(_selectedDate);
    }
  }

  _selectDate2(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      currentDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (selected != null) {
      setState(() {
        selectedDeliveryDate = DateFormat.yMd().format(selected).toString();
      });
      print(selectedDeliveryDate);
    } else {
      setState(() {
        selectedDeliveryDate =
            DateFormat.yMd().format(DateTime.now().add(Duration(days: 10)));
      });
      print(selectedDeliveryDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var isSmallScreen = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      body: isSmallScreen ? Mobile() : Desktop(),
    );
  }

  Directionality Desktop() {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "images/login.jpg",
          ),
          fit: BoxFit.cover,
        )),
        child: Container(
          height: double.infinity,
          color: Colors.black.withOpacity(0.8),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                            "images/login.jpg",
                          ),
                          fit: BoxFit.cover,
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MainScreen(
                                                  index: 0,
                                                )));
                                  },
                                  child: HoverAnimatedContainer(
                                    hoverWidth: 200,
                                    padding: EdgeInsets.all(20),
                                    hoverDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red.withOpacity(0.8),
                                    ),
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffBCEFC2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.home),
                                        Text(
                                          "الصفحة الرئيسية",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "اضافة فاتورة جديدة",
                                      style: TextStyle(
                                          fontSize: 35,
                                          wordSpacing: 2,
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset(
                                      "images/report.png",
                                      height: 70,
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MainScreen(
                                                  index: 1,
                                                )));
                                  },
                                  child: HoverAnimatedContainer(
                                    hoverWidth: 200,
                                    padding: EdgeInsets.all(20),
                                    hoverDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red.withOpacity(0.8),
                                    ),
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffBCEFC2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          "images/receipt.png",
                                          height: 30,
                                        ),
                                        Text(
                                          " الفواتير",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      ////////////////////////  بيانات العميل  /////////////////////////////
                      SizedBox(
                        height: 30,
                      ),
                      const Row(
                        children: [
                          Expanded(
                              child: Divider(
                            color: Colors.white,
                          )),
                          Text(
                            "     بيانات العميل    ",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Expanded(
                              child: Divider(
                            color: Colors.white,
                          )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'رقم الفاتورة',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  prefix: Icon(Icons.code),
                                  controller: codeController..text,
                                  isPhoneNumber: true,
                                  hintText: 'ادخل رقم الفاتورة',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'عميل موجود مسبقاً',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: buttonColor,
                                    ),
                                    child: DropDownTextField(
                                      padding: EdgeInsets.zero,
                                      textFieldDecoration: InputDecoration(
                                          hintText: "ادخل اسم العميل",
                                          border: InputBorder.none),
                                      // initialValue: "name4",
                                      controller: controller,
                                      clearOption: false,

                                      readOnly: false,
                                      // dropdownColor: Colors.green,
                                      searchDecoration: const InputDecoration(
                                          hintText: "ادخل اسم العميل"),
                                      validator: (value) {
                                        if (value == null) {
                                          return "Required field";
                                        } else {
                                          return null;
                                        }
                                      },
                                      dropDownItemCount: 1000,

                                      dropDownList: customer
                                          .map(
                                            (e) => DropDownValueModel(
                                                name: e, value: e),
                                          )
                                          .toList(),

                                      onChanged: (val) {
                                        Customer? c = customerModel
                                            .firstWhereOrNull((element) =>
                                                element.userName == val.name);

                                        setState(() {
                                          nameController.text =
                                              val.name.toString();
                                          addressController.text = c!.address!;
                                          phoneController.text = c.phone!;
                                          neckController
                                            ..text = c.neckLength == null
                                                ? "0"
                                                : c.neckLength.toString();
                                          hand1LengthController.text =
                                              c.handLength == null
                                                  ? "0"
                                                  : c.handLength.toString();
                                          k1LengthController.text =
                                              c.kabkLength == null
                                                  ? "0"
                                                  : c.kabkLength.toString();
                                          chestLengthController.text =
                                              c.sadrLength == null
                                                  ? "0"
                                                  : c.sadrLength.toString();
                                          lengthController.text =
                                              c.length == null
                                                  ? "0"
                                                  : c.length.toString();

                                          ketfLengthController.text =
                                              c.ketfLength == null
                                                  ? "0"
                                                  : c.ketfLength.toString();
                                          komLengthController.text =
                                              c.komLength == null
                                                  ? "0"
                                                  : c.komLength.toString();
                                        });
                                      },
                                    ),
                                  )
                                ]),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    ' اسم المشتري ',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  CustomTextField(
                                    prefix: Icon(Icons.add_reaction_outlined),
                                    controller: nameController,
                                    isFormField: true,
                                    hintText: 'ادخل اسم المشتري ',
                                    onChanged: (val) {
                                      setState(() {
                                        controller.clearDropDown();
                                      });
                                    },
                                  )
                                ]),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'رقم الهاتف',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  prefix: Icon(Icons.phone_android),
                                  controller: phoneController,
                                  isPhoneNumber: true,
                                  hintText: 'ادخل رقم الهاتف',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'العنوان',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  prefix: Icon(Icons.home_outlined),
                                  controller: addressController,
                                  textInputType: TextInputType.streetAddress,
                                  isFormField: true,
                                  hintText: 'ادخل العنوان ',
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),

                      //////////////////////// المقاسات  /////////////////////////////

                      const Row(
                        children: [
                          Expanded(
                              child: Divider(
                            color: Colors.white,
                          )),
                          Text(
                            "     المقاسات    ",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Expanded(
                              child: Divider(
                            color: Colors.white,
                          )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'عدد الاثواب',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  controller: numDressesController,
                                  textInputType: TextInputType.number,
                                  isFormField: true,
                                  hintText: 'ادخل عدد الاثواب',
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'الطول',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  controller: lengthController,
                                  textInputType: TextInputType.number,
                                  hintText: 'ادخل الطول',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'الكتف',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  controller: ketfLengthController,
                                  textInputType: TextInputType.number,
                                  hintText: 'ادخل الطول',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'طول الكم',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  controller: komLengthController,
                                  textInputType: TextInputType.number,
                                  hintText: 'ادخل الطول',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'وسع الصدر',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  controller: chestLengthController,
                                  textInputType: TextInputType.number,
                                  isFormField: true,
                                  hintText: ' ادخل وسع الصدر ',
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'الرقبة',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  controller: neckController,
                                  textInputType: TextInputType.number,
                                  hintText: 'الرقبة',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'وسع اليد',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: buttonColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: hand1LengthController,
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintText: 'ادخل المقاس',
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: hand2LengthController,
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: 'ادخل  المقاس',
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'طول الكبك',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: buttonColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: k1LengthController,
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: 'ادخل المقاس ',
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: k2LengthController,
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: 'ادخل المقاس',
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'سقوط التقويرة',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: buttonColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller:
                                                  taqwera1LengthController,
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: 'ادخل المقاس',
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            TextFormField(
                                              textAlign: TextAlign.center,
                                              controller:
                                                  taqwera2LengthController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: 'ادخل المقاس',
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            TextFormField(
                                              textAlign: TextAlign.center,
                                              controller:
                                                  taqwera3LengthController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: 'ادخل المقاس',
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'مقاس البدن',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: buttonColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              textAlign: TextAlign.center,
                                              controller: badnLengthController1,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: 'ادخل المقاس',
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: badnLengthController2,
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: 'ادخل المقاس',
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: badnLengthController3,
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: 'ادخل المقاس',
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          )
                        ],
                      ),

                      ////////////////////////  بيانات الطلب  /////////////////////////////
                      const Row(
                        children: [
                          Expanded(
                              child: Divider(
                            color: Colors.white,
                          )),
                          Text(
                            "     بيانات الطلب    ",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Expanded(
                              child: Divider(
                            color: Colors.white,
                          )),
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
                                      fontSize: 18),
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
                                            tileColor: Colors.white,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    buttonColor),
                                            selectedTileColor: Colors.white,
                                            groupValue: _character,
                                            onChanged: (value) {
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
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xffBCEFC2),
                                                      ),
                                                      child: DropdownButton(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        underline: SizedBox(),
                                                        hint:
                                                            _dropDownValueA ==
                                                                    null
                                                                ? Text(
                                                                    'اضغط للاختيار',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                : Text(
                                                                    _dropDownValueA!,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                        isExpanded: true,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20,
                                                                right: 20),
                                                        iconSize: 30.0,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        items: [
                                                          'قطري',
                                                          'سعودي',
                                                          'كويتي',
                                                          "بولاقي",
                                                          "كوم سادة عماني",
                                                          "شعراوي كوم سادة",
                                                          "سوداني كوم سادة"
                                                        ].map(
                                                          (val) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: val,
                                                              child: Text(val),
                                                            );
                                                          },
                                                        ).toList(),
                                                        onChanged: (val) {
                                                          setState(
                                                            () {
                                                              _dropDownValueA =
                                                                  val;
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  _dropDownValueA == "قطري" ||
                                                          _dropDownValueA ==
                                                              "سعودي" ||
                                                          _dropDownValueA ==
                                                              "كويتي" ||
                                                          _dropDownValueA ==
                                                              "بولاقي"
                                                      ? Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            width: 400,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Color(
                                                                  0xffBCEFC2),
                                                            ),
                                                            child:
                                                                DropdownButton(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              underline:
                                                                  SizedBox(),
                                                              hint:
                                                                  _dropDownValueB ==
                                                                          null
                                                                      ? Text(
                                                                          'اضغط للاختيار ',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold),
                                                                        )
                                                                      : Text(
                                                                          _dropDownValueB!,
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 16),
                                                                        ),
                                                              isExpanded: true,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                              iconSize: 30.0,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                              items: [
                                                                '2 كباسين كوم سادة',
                                                                '2 كباسين كوم كبك',
                                                                'جلاب كوم سادة',
                                                                'جلاب كوم كبك',
                                                                "2 كباسين كوم سادة بشليك",
                                                                "2 كباسين كوم سادة بشليك لزق مفتوح",
                                                              ].map(
                                                                (val) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value: val,
                                                                    child: Text(
                                                                        val),
                                                                  );
                                                                },
                                                              ).toList(),
                                                              onChanged: (val) {
                                                                setState(
                                                                  () {
                                                                    _dropDownValueB =
                                                                        val;
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                      Spacer()
                                    ],
                                  ),
                                ),
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
                                          fillColor: MaterialStateProperty.all(
                                              buttonColor),
                                          tileColor: Colors.white,
                                          selectedTileColor: Colors.white,
                                          visualDensity: VisualDensity.standard,
                                          onChanged: (value) {
                                            setState(() {
                                              _character = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      _character == SingingCharacter.balady
                                          ? Expanded(
                                              flex: 3,
                                              child: Container(
                                                width: 400,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xffBCEFC2),
                                                ),
                                                child: DropdownButton(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  underline: SizedBox(),
                                                  hint: _dropDownValueC == null
                                                      ? Text(
                                                          'اضغط للاختيار',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      : Text(
                                                          _dropDownValueC!,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                        ),
                                                  isExpanded: true,
                                                  padding: EdgeInsets.only(
                                                      left: 20, right: 20),
                                                  iconSize: 30.0,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  items: [
                                                    'كلفة تامة بشليك',
                                                    'كلفة تامة نص ياقة',
                                                    'قشره',
                                                    "اسطنبولي",
                                                  ].map(
                                                    (val) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: val,
                                                        child: Text(val),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (val) {
                                                    setState(
                                                      () {
                                                        _dropDownValueC = val;
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      Spacer()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          ////////////////////////  نوع  /////////////////////////////

                          const Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                color: Colors.white,
                              )),
                              Text(
                                "     نوع القماش    ",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Expanded(
                                  child: Divider(
                                color: Colors.white,
                              )),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'نوع القماش',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: buttonColor,
                                      ),
                                      child: DropDownTextField(
                                        padding: EdgeInsets.zero,
                                        textFieldDecoration: InputDecoration(
                                            hintText: "ادخل نوع القماش",
                                            border: InputBorder.none),
                                        // initialValue: "name4",
                                        controller: controllerType,
                                        clearOption: false,

                                        readOnly: false,
                                        // dropdownColor: Colors.green,
                                        searchDecoration: const InputDecoration(
                                            hintText: "اختار نوع القماش"),
                                        validator: (value) {
                                          if (value == null) {
                                            return "Required field";
                                          } else {
                                            return null;
                                          }
                                        },
                                        dropDownItemCount: 3,

                                        dropDownList: category
                                            .map(
                                              (e) => DropDownValueModel(
                                                  name: e, value: e),
                                            )
                                            .toList(),

                                        onChanged: (val) {
                                          quantityController.clear();
                                          totalTypeController.text = "0.0";
                                          print(remainingAmountController.text);

                                          print(totalController.text);

                                          categoryName = val.name;
                                          CategoryModel? c = categoryModel
                                              .firstWhereOrNull((element) =>
                                                  element.type == val.name);

                                          setState(() {
                                            quantityTypeController.text =
                                                c!.quantity.toString();
                                            categoryQuantity =
                                                c!.quantity.toString();
                                            priceTypeController.text =
                                                c.price.toString()!;
                                            categoryPrice = c.price!;
                                          });
                                          setState(() {
                                            totalController
                                                .text = ((worker_costController
                                                            .text.isEmpty
                                                        ? 0.0
                                                        : double.parse(
                                                            worker_costController
                                                                .text)) +
                                                    (prizeController
                                                            .text.isEmpty
                                                        ? 0.0
                                                        : double.parse(
                                                            prizeController
                                                                .text)) +
                                                    double.parse(
                                                        totalTypeController
                                                            .text))
                                                .toString();
                                            remainingAmountController
                                                .text = (double.parse(
                                                        totalController
                                                                .text.isEmpty
                                                            ? "0.0"
                                                            : totalController
                                                                .text) -
                                                    (amountPaidController
                                                            .text.isNotEmpty
                                                        ? double.parse(
                                                            amountPaidController
                                                                .text)
                                                        : 0.0))
                                                .toString();
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'الكمية المتاحة في المخزن',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    CustomTextField(
                                      prefix:
                                          Icon(Icons.auto_awesome_mosaic_sharp),
                                      enable: false,
                                      controller: quantityTypeController,
                                      textInputType: TextInputType.number,
                                      hintText: 'ادخل النوع',
                                      isFormField: true,
                                    ),
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'سعر المتر',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    CustomTextField(
                                      prefix:
                                          Icon(Icons.monetization_on_outlined),
                                      controller: priceTypeController,
                                      enable: false,
                                      textInputType: TextInputType.number,
                                      hintText: 'سعر المتر',
                                      isFormField: true,
                                    ),
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      ' الكمية',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    CustomTextField(
                                      prefix:
                                          Icon(Icons.auto_awesome_mosaic_sharp),
                                      controller: quantityController,
                                      onChanged: (val) {
                                        if (val.isEmpty ||
                                            priceTypeController.text.isEmpty ||
                                            quantityTypeController
                                                .text.isEmpty) {
                                          setState(() {
                                            quantityTypeController.text =
                                                categoryQuantity;
                                            totalTypeController.text = "0.0";
                                          });
                                        } else {
                                          quantityTypeController.text =
                                              (double.parse(categoryQuantity) -
                                                      double.parse(
                                                          quantityController
                                                              .text))
                                                  .toString();
                                          totalTypeController
                                              .text = (double.parse(
                                                      quantityController.text) *
                                                  double.parse(
                                                      priceTypeController.text))
                                              .toString();
                                        }

                                        totalController
                                            .text = ((worker_costController
                                                        .text.isEmpty
                                                    ? 0.0
                                                    : double.parse(
                                                        worker_costController
                                                            .text)) +
                                                (prizeController.text.isEmpty
                                                    ? 0.0
                                                    : double.parse(
                                                        prizeController.text)) +
                                                double.parse(
                                                    totalTypeController.text))
                                            .toString();
                                        remainingAmountController.text =
                                            (double.parse(totalController
                                                            .text.isEmpty
                                                        ? "0.0"
                                                        : totalController
                                                            .text) -
                                                    (amountPaidController
                                                            .text.isNotEmpty
                                                        ? double.parse(
                                                            amountPaidController
                                                                .text)
                                                        : 0.0))
                                                .toString();

                                        setState(() {});
                                      },
                                      textInputType: TextInputType.number,
                                      hintText: 'ادخل الكمية',
                                      isFormField: true,
                                    ),
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'الاجمالي',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    CustomTextField(
                                      prefix:
                                          Icon(Icons.monetization_on_outlined),
                                      controller: totalTypeController,
                                      enable: false,
                                      textInputType: TextInputType.number,
                                      hintText: 'الاجمالي',
                                      isFormField: true,
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          ),
                          ////////////////////////  الدفع  /////////////////////////////

                          const Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                color: Colors.white,
                              )),
                              Text(
                                "     الدفع    ",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Expanded(
                                  child: Divider(
                                color: Colors.white,
                              )),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'القيمة',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    CustomTextField(
                                      onChanged: (val) {
                                        setState(() {
                                          totalController
                                              .text = ((worker_costController
                                                          .text.isEmpty
                                                      ? 0.0
                                                      : double.parse(
                                                          worker_costController
                                                              .text)) +
                                                  (val.isEmpty
                                                      ? 0.0
                                                      : double.parse(val)) +
                                                  double.parse(
                                                      totalTypeController.text))
                                              .toString();
                                          remainingAmountController
                                              .text = (double.parse(
                                                      totalController.text) -
                                                  (amountPaidController
                                                          .text.isNotEmpty
                                                      ? double.parse(
                                                          amountPaidController
                                                              .text)
                                                      : 0.0))
                                              .abs()
                                              .toString();
                                        });

                                        setState(() {
                                          show = false;
                                        });
                                      },
                                      prefix: Icon(Icons.attach_money),
                                      controller: prizeController,
                                      textInputType: TextInputType.number,
                                      hintText: 'ادخل القيمة',
                                      isFormField: true,
                                    ),
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'المصنعية',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    CustomTextField(
                                      prefix: Icon(Icons.attach_money),
                                      onChanged: (val) {
                                        setState(() {
                                          totalController
                                              .text = ((worker_costController
                                                          .text.isEmpty
                                                      ? 0.0
                                                      : double.parse(
                                                          worker_costController
                                                              .text)) +
                                                  (prizeController.text.isEmpty
                                                      ? 0.0
                                                      : double.parse(
                                                          prizeController
                                                              .text)) +
                                                  double.parse(
                                                      totalTypeController.text))
                                              .toString();
                                        });

                                        remainingAmountController.text =
                                            (double.parse(
                                                        totalController.text) -
                                                    (amountPaidController
                                                            .text.isNotEmpty
                                                        ? double.parse(
                                                            amountPaidController
                                                                .text)
                                                        : 0.0))
                                                .toString();
                                        setState(() {
                                          show = false;
                                        });
                                      },
                                      controller: worker_costController,
                                      textInputType: TextInputType.number,
                                      hintText: 'ادخل مبلغ المصنعية',
                                      isFormField: true,
                                    ),
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'المبلغ المدفوع',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    CustomTextField(
                                      prefix: Icon(Icons.attach_money),
                                      onChanged: (val) {
                                        if (double.tryParse(
                                                val.isNotEmpty ? val : "0")! >
                                            double.tryParse(
                                                totalController.text)!) {
                                          remainingAmountController.text = "0";
                                          setState(() {
                                            show = true;
                                          });
                                        } else {
                                          remainingAmountController
                                              .text = (double.tryParse(
                                                      totalController.text)! -
                                                  double.tryParse(val.isNotEmpty
                                                      ? val
                                                      : "0")!)
                                              .toString();

                                          setState(() {
                                            show = false;
                                          });
                                        }
                                      },
                                      controller: amountPaidController,
                                      textInputType: TextInputType.number,
                                      isFormField: true,
                                      hintText: ' ادخل المبلغ المدفوع ',
                                    ),
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'المبلغ المتبقى',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    CustomTextField(
                                      prefix: Icon(Icons.attach_money),
                                      controller: remainingAmountController,
                                      textInputType: TextInputType.number,
                                      hintText: 'ادخل المبلغ المتبقى',
                                      isFormField: true,
                                    ),
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'الاجمالي',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    CustomTextField(
                                      prefix: Icon(Icons.attach_money),
                                      controller: totalController,
                                      textInputType: TextInputType.number,
                                      hintText: 'الاجمالي',
                                      isFormField: true,
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          ),
                          show == true
                              ? Text(
                                  ' يوجد ${(double.tryParse(amountPaidController.text.isNotEmpty ? amountPaidController.text : "0")! - double.tryParse(totalController.text.isNotEmpty ? totalController.text : "0")!)} مبلغ ذيادة',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.red),
                                )
                              : SizedBox(),

                          ////////////////////////  التاريخ  /////////////////////////////

                          const Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                color: Colors.white,
                              )),
                              Text(
                                "     التاريخ    ",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Expanded(
                                  child: Divider(
                                color: Colors.white,
                              )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'تاريخ الفاتوره',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffBCEFC2),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: Offset(0, 1))
                                              // changes position of shadow
                                            ],
                                          ),
                                          child: TextField(
                                            controller: _dateController,
                                            onTap: () {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
                                              _selectDate(context);
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,

                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              isDense: true,
                                              fillColor: Colors.black12,
                                              enabled: false,
                                              hintText:
                                                  _selectedDate.toString(),
                                              labelText:
                                                  _selectedDate.toString(),
                                              labelStyle: const TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                              // iconOrdrop: 'button',
                                              prefixIcon: const Icon(
                                                Icons.date_range_outlined,
                                                size: 25,
                                                color: accentCanvasColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'تاريخ الاستلام',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffBCEFC2),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: Offset(0, 1))
                                              // changes position of shadow
                                            ],
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());

                                              _selectDate2(context);
                                            },
                                            child: TextField(
                                              controller:
                                                  _dateDeliveryController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,

                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                isDense: true,
                                                fillColor: Colors.black12,
                                                enabled: false,
                                                hintText: selectedDeliveryDate
                                                    .toString(),
                                                labelText: selectedDeliveryDate
                                                    .toString(),
                                                labelStyle: const TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                // iconOrdrop: 'button',
                                                prefixIcon: const Icon(
                                                  Icons.date_range_outlined,
                                                  size: 25,
                                                  color: accentCanvasColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ////////////////////////  الاضافات  /////////////////////////////
                          SizedBox(
                            height: 10,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                color: Colors.white,
                              )),
                              Text(
                                "     الاضافات    ",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Expanded(
                                  child: Divider(
                                color: Colors.white,
                              )),
                            ],
                          ),
                          ExpansionTile(
                            shape: InputBorder.none,
                            collapsedBackgroundColor: buttonColor,
                            backgroundColor: buttonColor,
                            title: Text(
                              " اضفط هنا لظهور الاضافات ",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                    "images/login.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                )),
                                child: Container(
                                    color: Colors.black.withOpacity(0.8),
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    child:
                                        // _character == SingingCharacter.afrangy
                                        //     ?
                                        Wrap(
                                      spacing: 20,
                                      runSpacing: 20,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Container(
                                          width: 300,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: accentCanvasColor
                                                  .withOpacity(0.8)),
                                          child: Column(
                                            children: [
                                              CarouselSlider(
                                                  items: list6,
                                                  carouselController:
                                                      buttonCarouselController4,
                                                  options: CarouselOptions(
                                                    onPageChanged: (index, c) {
                                                      index == 1
                                                          ? sadr =
                                                              "images/صدر مخفي.png"
                                                          : index == 2
                                                              ? sadr =
                                                                  "images/صدر-عادي-مربع .png"
                                                              : index == 3
                                                                  ? sadr =
                                                                      "images/صدر عادي لون في لون 2 خط.jpg"
                                                                  : index == 4
                                                                      ? sadr =
                                                                          "images/صدر لون في لون خط واحد.png"
                                                                      : index == 0
                                                          ?  sadr =
                                                      "images/صدر عادي.png":""
                                                      ;
                                                      print(index);
                                                      print(sadr);
                                                    },
                                                    autoPlay: false,
                                                    enlargeCenterPage: true,
                                                    viewportFraction: 1,
                                                    aspectRatio: 1.0,
                                                    initialPage: 1,
                                                  )),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () =>
                                                        buttonCarouselController4
                                                            .nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                    icon: Icon(
                                                      Icons.arrow_back,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: CustomTextField(
                                                      textInputType:
                                                          TextInputType.number,
                                                      controller:
                                                          sadrController,
                                                      hintText: "ادخل المقاس",
                                                      prefix: Icon(Icons
                                                          .format_size_outlined),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      buttonCarouselController4
                                                          .previousPage(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      1),
                                                              curve: Curves
                                                                  .linear);
                                                    },
                                                    icon: Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 300,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: accentCanvasColor
                                                  .withOpacity(0.8)),
                                          child: Column(
                                            children: [
                                              CarouselSlider(
                                                  items: list7,
                                                  carouselController:
                                                      buttonCarouselController5,
                                                  options: CarouselOptions(
                                                    onPageChanged: (index, c) {
                                                      print(index);
                                                      kom = index == 0
                                                          ? "images/كم شعراوي علية زراير.jpg"
                                                          : index == 1
                                                              ? "images/كم بلدي.png"
                                                              : index == 2
                                                                  ? "images/الكم سادة+بشليك لزق.png"
                                                                  : index == 3
                                                                      ? "images/الكم سادة.png"
                                                                      : index ==
                                                                              4
                                                                          ? "images/اساورة بشليك.png"
                                                                          : index == 5
                                                                              ? "images/اساورة كسرة واحد.png"
                                                                              : index == 6
                                                                                  ? "images/اساورة 2 كسرة.jpg"
                                                                                  : index == 7
                                                                                      ? "images/اساورة مربع بدون كسرة.png"
                                                                                      : index == 8
                                                                                          ? "images/اساورة مربع كسرة واحدة.jpg"
                                                                                          : "images/اساورة مربع 2 كسرة.jpg";

                                                      print(kom);
                                                    },
                                                    autoPlay: false,
                                                    enlargeCenterPage: true,
                                                    viewportFraction: 1,
                                                    aspectRatio: 1.0,
                                                    initialPage: 2,
                                                  )),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () =>
                                                        buttonCarouselController5
                                                            .nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                    icon: Icon(
                                                      Icons.arrow_back,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: CustomTextField(
                                                      textInputType:
                                                          TextInputType.number,
                                                      controller: komController,
                                                      prefix: Icon(
                                                          Icons.format_size),
                                                      hintText: "ادخل المقاس",
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () =>
                                                        buttonCarouselController5
                                                            .previousPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                    icon: Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 300,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: accentCanvasColor
                                                  .withOpacity(0.8)),
                                          child: Stack(
                                            children: [
                                              Column(
                                                children: [
                                                  CarouselSlider(
                                                      items: list3,
                                                      carouselController:
                                                          buttonCarouselController6,
                                                      options: CarouselOptions(
                                                        onPageChanged:
                                                            (index, c) {
                                                          print(index);
                                                          glab = index == 0
                                                              ? "images/جلاب 1 زرار.png"
                                                              : "images/جلاب 2 زرار.png";
                                                          print(glab);
                                                        },
                                                        enlargeCenterPage: true,
                                                        viewportFraction: 1,
                                                        aspectRatio: 1.0,
                                                        initialPage: 2,
                                                      )),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController6.nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                        icon: Icon(
                                                          Icons.arrow_back,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: CustomTextField(
                                                          textInputType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              glabController,
                                                          prefix: Icon(Icons
                                                              .format_size),
                                                          hintText:
                                                              "ادخل المقاس",
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController6
                                                                .previousPage(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            1),
                                                                    curve: Curves
                                                                        .linear),
                                                        icon: Icon(
                                                          Icons.arrow_forward,
                                                          color: Colors.white,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 300,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: accentCanvasColor
                                                  .withOpacity(0.8)),
                                          child: Stack(
                                            children: [
                                              Column(
                                                children: [
                                                  CarouselSlider(
                                                      items: list4,
                                                      carouselController:
                                                          buttonCarouselController7,
                                                      options: CarouselOptions(
                                                        onPageChanged:
                                                            (index, c) {
                                                          print(index);
                                                          ganb = index == 0
                                                              ? "images/جانب بشليك.png"
                                                              : "images/جانب شق.png";
                                                          print(ganb);
                                                        },
                                                        autoPlay: false,
                                                        enlargeCenterPage: true,
                                                        viewportFraction: 1,
                                                        aspectRatio: 1.0,
                                                        initialPage: 1,
                                                      )),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController7.nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                        icon: Icon(
                                                          Icons.arrow_back,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: CustomTextField(
                                                          textInputType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              ganbController,
                                                          prefix: Icon(Icons
                                                              .format_size),
                                                          hintText:
                                                              "ادخل المقاس",
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController7
                                                                .previousPage(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            1),
                                                                    curve: Curves
                                                                        .linear),
                                                        icon: Icon(
                                                          Icons.arrow_forward,
                                                          color: Colors.white,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 300,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: accentCanvasColor
                                                  .withOpacity(0.8)),
                                          child: Column(
                                            children: [
                                              CarouselSlider(
                                                  items: list5,
                                                  carouselController:
                                                      buttonCarouselController3,
                                                  options: CarouselOptions(
                                                    onPageChanged: (index, c) {
                                                      print(index);
                                                      gyb = index == 0
                                                          ? "images/جيب مربع.png"
                                                          : index == 1
                                                              ? "images/جيب مربع مثلث.png"
                                                              : "images/جيب مدور.png";
                                                      print(gyb);
                                                    },
                                                    autoPlay: false,
                                                    enlargeCenterPage: true,
                                                    viewportFraction: 1,
                                                    aspectRatio: 1.0,
                                                    initialPage: 1,
                                                  )),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () =>
                                                        buttonCarouselController3
                                                            .nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                    icon: Icon(
                                                      Icons.arrow_back,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: CustomTextField(
                                                      textInputType:
                                                          TextInputType.number,
                                                      controller: gybController,
                                                      prefix: Icon(
                                                          Icons.format_size),
                                                      hintText: "ادخل المقاس",
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () =>
                                                        buttonCarouselController3
                                                            .previousPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                    icon: Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 300,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: accentCanvasColor
                                                  .withOpacity(0.8)),
                                          child: Column(
                                            children: [
                                              CarouselSlider(
                                                  items: list1,
                                                  carouselController:
                                                      buttonCarouselController1,
                                                  options: CarouselOptions(
                                                    onPageChanged: (index, c) {
                                                      print(index);
                                                      taqwera = index == 0
                                                          ? "images/كلفة تامة بشليك.png"
                                                          : index == 1
                                                              ? "images/كلفة تامة نص ياقة.png"
                                                              : index == 2
                                                                  ? "images/جلابية قشرة.png"
                                                                  : "اسطنبولي";
                                                      print(taqwera);
                                                    },
                                                    autoPlay: false,
                                                    enlargeCenterPage: true,
                                                    viewportFraction: 1,
                                                    aspectRatio: 1.0,
                                                    initialPage: 1,
                                                  )),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () =>
                                                        buttonCarouselController1
                                                            .nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                    icon: Icon(
                                                      Icons.arrow_back,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: CustomTextField(
                                                      textInputType:
                                                          TextInputType.number,
                                                      controller:
                                                          taqweraController,
                                                      prefix: Icon(
                                                          Icons.format_size),
                                                      hintText: "ادخل المقاس",
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () =>
                                                        buttonCarouselController1
                                                            .previousPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                    icon: Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 300,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: accentCanvasColor
                                                  .withOpacity(0.8)),
                                          child: Expanded(
                                            flex: 4,
                                            child: Column(
                                              children: [
                                                CarouselSlider(
                                                    items: list2,
                                                    carouselController:
                                                        buttonCarouselController2,
                                                    options: CarouselOptions(
                                                      onPageChanged:
                                                          (index, c) {
                                                        print(index);
                                                        ya2a = index == 0
                                                            ? "images/الياقة بدون زراير.png"
                                                            : index == 1
                                                                ? "images/الياقة زرار واحد.png"
                                                                : "images/الياقة 2 زرار.png";
                                                        print(ya2a);
                                                      },
                                                      autoPlay: false,
                                                      enlargeCenterPage: true,
                                                      viewportFraction: 1,
                                                      aspectRatio: 1.0,
                                                      initialPage: 1,
                                                    )),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () =>
                                                          buttonCarouselController2
                                                              .nextPage(
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          1),
                                                                  curve: Curves
                                                                      .linear),
                                                      icon: Icon(
                                                        Icons.arrow_back,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 5,
                                                      child: CustomTextField(
                                                        controller:
                                                            ya2aController,
                                                        textInputType:
                                                            TextInputType
                                                                .number,
                                                        prefix: Icon(
                                                            Icons.format_size),
                                                        hintText: "ادخل المقاس",
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () =>
                                                          buttonCarouselController2
                                                              .previousPage(
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          1),
                                                                  curve: Curves
                                                                      .linear),
                                                      icon: Icon(
                                                        Icons.arrow_forward,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 300,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: accentCanvasColor
                                                  .withOpacity(0.8)),
                                          child: Expanded(
                                            flex: 4,
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  child: Image.asset(
                                                      "images/new.png"),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                Positioned(
                                                    top: 60,
                                                    right: 13,
                                                    child: SizedBox(
                                                        height: 50,
                                                        width: 60,
                                                        child: TextField(
                                                          controller:
                                                              field1Controller,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ))),
                                                Positioned(
                                                    top: 60,
                                                    right: 120,
                                                    child: SizedBox(
                                                        height: 50,
                                                        width: 60,
                                                        child: TextField(
                                                          controller:
                                                              field2Controller,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ))),
                                                Positioned(
                                                    top: 60,
                                                    left: 17,
                                                    child: SizedBox(
                                                        height: 50,
                                                        width: 60,
                                                        child: TextField(
                                                          controller:
                                                              field3Controller,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ))),
                                                Positioned(
                                                    top: 165,
                                                    right: 30,
                                                    child: SizedBox(
                                                        height: 50,
                                                        width: 60,
                                                        child: TextField(
                                                          controller:
                                                              field4Controller,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ))),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 300,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: accentCanvasColor
                                                  .withOpacity(0.8)),
                                          child: Expanded(
                                            flex: 4,
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  child: Image.asset(
                                                      "images/كم-بلدي1.png"),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                Positioned(
                                                    top: 75,
                                                    right: 8,
                                                    child: SizedBox(
                                                        height: 50,
                                                        width: 60,
                                                        child: TextField(
                                                          controller:
                                                              fieldKom1Controller,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ))),
                                                Positioned(
                                                    top: 75,
                                                    right: 115,
                                                    child: SizedBox(
                                                        height: 50,
                                                        width: 60,
                                                        child: TextField(
                                                          controller:
                                                              fieldKom2Controller,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ))),
                                                Positioned(
                                                    top: 75,
                                                    left: 15,
                                                    child: SizedBox(
                                                        height: 50,
                                                        width: 60,
                                                        child: TextField(
                                                          controller:
                                                              fieldKom3Controller,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ))),
                                                Positioned(
                                                    top: 165,
                                                    right: 30,
                                                    child: SizedBox(
                                                        height: 50,
                                                        width: 60,
                                                        child: TextField(
                                                          controller:
                                                              fieldKom4Controller,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ))),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                    // : Wrap(
                                    //     runSpacing: 20,
                                    //     spacing: 20,
                                    //     children: [
                                    //       Container(
                                    //         width: 300,
                                    //         decoration: BoxDecoration(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(20),
                                    //             color: accentCanvasColor
                                    //                 .withOpacity(0.8)),
                                    //         child: Column(
                                    //           children: [
                                    //             CarouselSlider(
                                    //                 items: list1,
                                    //                 carouselController:
                                    //                     buttonCarouselController1,
                                    //                 options:
                                    //                     CarouselOptions(
                                    //                   onPageChanged:
                                    //                       (index, c) {
                                    //                     print(index);
                                    //                     taqwera = index ==
                                    //                             0
                                    //                         ? "كلفة تامة بشليك"
                                    //                         : index == 1
                                    //                             ? "كلفة تامة نص ياقة"
                                    //                             : index ==
                                    //                                     2
                                    //                                 ? "جلابية قشرة"
                                    //                                 : "اسطنبولي";
                                    //                     print(taqwera);
                                    //                   },
                                    //                   autoPlay: false,
                                    //                   enlargeCenterPage:
                                    //                       true,
                                    //                   viewportFraction:
                                    //                    1,
                                    //                   aspectRatio: 1.0,
                                    //                   initialPage: 1,
                                    //                 )),
                                    //             Row(
                                    //               children: [
                                    //                 IconButton(
                                    //                   onPressed: () =>
                                    //                       buttonCarouselController1
                                    //                           .nextPage(
                                    //                           duration: Duration(
                                    //                               milliseconds:
                                    //                               1),
                                    //                           curve: Curves
                                    //                               .linear),
                                    //                   icon: Icon(
                                    //                     Icons.arrow_back,
                                    //                     color: Colors.white,
                                    //                     size: 30,
                                    //                   ),
                                    //                 ),
                                    //
                                    //                 Expanded(
                                    //                   flex:5,
                                    //                   child: CustomTextField(
                                    //                     textInputType:
                                    //                     TextInputType
                                    //                         .number,
                                    //                     controller:
                                    //                     taqweraController,
                                    //                     prefix: Icon(Icons
                                    //                         .format_size),
                                    //                     hintText:
                                    //                     "ادخل المقاس",
                                    //                   ),
                                    //                 ),
                                    //                 IconButton(
                                    //                   onPressed: () =>
                                    //                       buttonCarouselController1
                                    //                           .previousPage(
                                    //                           duration: Duration(
                                    //                               milliseconds:
                                    //                               1),
                                    //                           curve: Curves
                                    //                               .linear),
                                    //                   icon: Icon(
                                    //                     Icons
                                    //                         .arrow_forward,
                                    //                     color: Colors.white,
                                    //                     size: 30,
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //
                                    //             SizedBox(
                                    //               height: 5,
                                    //             )
                                    //           ],
                                    //         ),
                                    //       ),
                                    //
                                    //       Container(
                                    //         width: 300,
                                    //         decoration: BoxDecoration(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(20),
                                    //             color: accentCanvasColor
                                    //                 .withOpacity(0.8)),
                                    //         child: Expanded(
                                    //           flex: 4,
                                    //           child: Column(
                                    //             children: [
                                    //               CarouselSlider(
                                    //                   items: list2,
                                    //                   carouselController:
                                    //                       buttonCarouselController2,
                                    //                   options:
                                    //                       CarouselOptions(
                                    //                     onPageChanged:
                                    //                         (index, c) {
                                    //                       print(index);
                                    //                       ya2a = index ==
                                    //                               0
                                    //                           ? "الياقة بدون زراير"
                                    //                           : index == 1
                                    //                               ? "الياقة زرار واحد"
                                    //                               : "الياقة 2 زرار";
                                    //                       print(ya2a);
                                    //                     },
                                    //                     autoPlay: false,
                                    //                     enlargeCenterPage:
                                    //                         true,
                                    //                     viewportFraction:
                                    //                       1,
                                    //                     aspectRatio: 1.0,
                                    //                     initialPage: 1,
                                    //                   )),
                                    //               Row(
                                    //                 children: [
                                    //                   IconButton(
                                    //                     onPressed: () =>
                                    //                         buttonCarouselController2
                                    //                             .nextPage(
                                    //                             duration: Duration(
                                    //                                 milliseconds:
                                    //                                 1),
                                    //                             curve: Curves
                                    //                                 .linear),
                                    //                     icon: Icon(
                                    //                       Icons.arrow_back,
                                    //                       color: Colors.white,
                                    //                       size: 30,
                                    //                     ),
                                    //                   ),
                                    //                   Expanded(
                                    //                     flex:5,
                                    //                     child: CustomTextField(
                                    //                       controller:
                                    //                       ya2aController,
                                    //                       textInputType:
                                    //                       TextInputType
                                    //                           .number,
                                    //                       prefix: Icon(Icons
                                    //                           .format_size),
                                    //                       hintText:
                                    //                       "ادخل المقاس",
                                    //                     ),
                                    //                   ),
                                    //
                                    //                   IconButton(
                                    //                     onPressed: () =>
                                    //                         buttonCarouselController2
                                    //                             .previousPage(
                                    //                             duration: Duration(
                                    //                                 milliseconds:
                                    //                                 1),
                                    //                             curve: Curves
                                    //                                 .linear),
                                    //                     icon: Icon(
                                    //                       Icons
                                    //                           .arrow_forward,
                                    //                       color: Colors.white,
                                    //                       size: 30,
                                    //                     ),
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 5,
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    ),
                              )
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: BlocProvider(
                                      create: (context) => ProductCubit(),
                                      child: BlocConsumer<ProductCubit,
                                              ProductsMainState>(
                                          listener: (BuildContext context,
                                              state) async {
                                        if (state is AddProductsLoadingState) {
                                          SmartDialog.showLoading();
                                          await Future.delayed(
                                              Duration(seconds: 2));
                                          SmartDialog.dismiss();
                                        }
                                      }, builder:
                                              (BuildContext context, state) {
                                        var product = ProductCubit.get(context);
                                        return ElevatedButton(
                                            onPressed: () {
                                              var p = (double.tryParse(
                                                      amountPaidController
                                                              .text.isNotEmpty
                                                          ? amountPaidController
                                                              .text
                                                          : "0")! -
                                                  double.tryParse(
                                                      totalController
                                                              .text.isNotEmpty
                                                          ? totalController.text
                                                          : "0")!);
                                              setState(() {
                                                productsModel = ProductsModel(
                                                  komSha3rawyLenght1:
                                                      double.tryParse(
                                                          field1Controller
                                                              .text),

                                                  komSha3rawyLenght2:
                                                      double.tryParse(
                                                          field2Controller
                                                              .text),
                                                  komSha3rawyLenght3:
                                                      double.tryParse(
                                                          field3Controller
                                                              .text),
                                                  komSha3rawyLenght4:
                                                      double.tryParse(
                                                          field4Controller
                                                              .text),
                                                  komBaladyLenght1:  double.tryParse(
                                                      fieldKom1Controller.text
                                                          ),
                                                  komBaladyLenght2:  double.tryParse(
                                                      fieldKom2Controller.text
                                                  ),  komBaladyLenght3:  double.tryParse(
                                                    fieldKom3Controller.text
                                                ),  komBaladyLenght4:  double.tryParse(
                                                    fieldKom4Controller.text
                                                ),
                                                  name: nameController.text,
                                                  date: _selectedDate,
                                                  length: double.tryParse(
                                                      lengthController.text),
                                                  badnSize1: double.tryParse(
                                                      badnLengthController1
                                                          .text),
                                                  badnSize2: double.tryParse(
                                                      badnLengthController2
                                                          .text),
                                                  badnSize3: double.tryParse(
                                                      badnLengthController3
                                                          .text),
                                                  droppTaqwera1: double.tryParse(
                                                      taqwera1LengthController
                                                          .text),
                                                  droppTaqwera2: double.tryParse(
                                                      taqwera2LengthController
                                                          .text),
                                                  droppTaqwera3: double.tryParse(
                                                      taqwera3LengthController
                                                          .text),
                                                  hand2Length: double.tryParse(
                                                      hand2LengthController
                                                          .text),
                                                  k2Length: double.tryParse(
                                                      k2LengthController.text),
                                                  taqweraSize: double.tryParse(
                                                      taqweraController.text),
                                                  ganbSize: double.tryParse(
                                                      ganbController.text),
                                                  glabSize: double.tryParse(
                                                      glabController.text),
                                                  komSize: double.tryParse(
                                                      komController.text),
                                                  yaqaSize: double.tryParse(
                                                      ya2aController.text),
                                                  gaybSize: double.tryParse(
                                                      gybController.text),
                                                  sadrSize: double.tryParse(
                                                      sadrController.text),
                                                  address:
                                                      addressController.text,
                                                  amountPaid: double.tryParse(
                                                      amountPaidController
                                                          .text),
                                                  additionalType2: _character ==
                                                          SingingCharacter
                                                              .afrangy
                                                      ? _dropDownValueB ?? ""
                                                      : "",
                                                  chestLength: double.tryParse(
                                                      chestLengthController
                                                          .text),
                                                  createdAt:
                                                      DateTime.now().toString(),
                                                  details:
                                                      detailsController.text,
                                                  handLength: double.tryParse(
                                                      hand1LengthController
                                                          .text),
                                                  image: "ds",
                                                  kLength: double.tryParse(
                                                      k1LengthController.text),
                                                  mLength: double.tryParse(
                                                      mLengthController.text),
                                                  numDresses: double.tryParse(
                                                      numDressesController
                                                          .text),
                                                  neck: double.tryParse(
                                                      neckController.text),
                                                  phone: phoneController.text,
                                                  prize: double.tryParse(
                                                      totalController.text),
                                                  remainingAmount: double.tryParse(
                                                      remainingAmountController
                                                          .text),
                                                  ganb: ganb,
                                                  gayb: gyb,
                                                  taqwera: taqwera,
                                                  yaqa: ya2a,
                                                  kom: kom,
                                                  komBalady: "images/كم-بلدي1.png",
                                                  komSha3rawy: "images/png.png",
                                                  additionalType1: _character ==
                                                          SingingCharacter
                                                              .afrangy
                                                      ? _dropDownValueA
                                                      : _dropDownValueC,
                                                  glab: glab,
                                                  sadr: sadr,
                                                  workerCost:
                                                      worker_costController
                                                          .text,
                                                  total: totalController.text,
                                                  code: codeController.text,
                                                  quantity:
                                                      quantityController.text,
                                                  type: _character ==
                                                          SingingCharacter
                                                              .afrangy
                                                      ? "افرنجي"
                                                      : "بلدي",
                                                  fyberType: categoryName,
                                                  deliveryTime:
                                                      selectedDeliveryDate,
                                                  ketfLength: double.tryParse(
                                                      ketfLengthController
                                                          .text),
                                                  komLength: double.tryParse(
                                                      komLengthController.text),
                                                );
                                              });

                                              product
                                                  .postProduct(
                                                      context, productsModel)
                                                  .then((value) {
                                                print(value);
                                                Customer? c = customerModel
                                                    .firstWhereOrNull(
                                                        (element) =>
                                                            element.userName ==
                                                            nameController
                                                                .text);

                                                if (c != null) {
                                                  Customer model = Customer(
                                                      userName: c?.userName,
                                                      address: c?.address!,
                                                      phone: c!.phone,
                                                      code: c.code,
                                                      length: c.length,
                                                      kabkLength: c.kabkLength,
                                                      ketfLength: c.ketfLength,
                                                      komLength: c.kabkLength,
                                                      neckLength: c.neckLength,
                                                      sadrLength: c.sadrLength,
                                                      handLength: c.handLength,
                                                      customerAmount: show ==
                                                              true
                                                          ? c.customerAmount + p
                                                          : c.customerAmount,
                                                      remainingAmount: c
                                                              .remainingAmount! +
                                                          double.tryParse(
                                                              remainingAmountController
                                                                  .text)!);
                                                  // if (show == true &&c.remainingAmount!=0) {
                                                  //   SmartDialog.show(
                                                  //       backDismiss: true,
                                                  //       onDismiss: () {},
                                                  //       builder: (context) {
                                                  //         return Container(
                                                  //           padding:
                                                  //               EdgeInsets.all(
                                                  //                   20),
                                                  //           width: 300,
                                                  //           height: 300,
                                                  //           decoration:
                                                  //               BoxDecoration(
                                                  //             color:
                                                  //                 buttonColor,
                                                  //             borderRadius:
                                                  //                 BorderRadius
                                                  //                     .circular(
                                                  //                         10),
                                                  //           ),
                                                  //           alignment: Alignment
                                                  //               .center,
                                                  //           child: Column(
                                                  //             mainAxisAlignment:
                                                  //                 MainAxisAlignment
                                                  //                     .spaceEvenly,
                                                  //             children: [
                                                  //               Text(
                                                  //                 ' يوجد ${p} مبلغ ذيادة',
                                                  //                 style: TextStyle(
                                                  //                     fontWeight:
                                                  //                         FontWeight
                                                  //                             .w500,
                                                  //                     fontSize:
                                                  //                         15,
                                                  //                     color: Colors
                                                  //                         .red),
                                                  //               ),
                                                  //               Text(
                                                  //                   "${model.userName} مديون ب ${c.remainingAmount!}"),
                                                  //               Text(
                                                  //                 'هل تريد خصم المبلغ الذيادة من المبلغ المديون به ؟ ',
                                                  //                 style: TextStyle(
                                                  //                     fontWeight:
                                                  //                         FontWeight
                                                  //                             .w500,
                                                  //                     fontSize:
                                                  //                         15,
                                                  //                     color: Colors
                                                  //                         .blue,),textAlign: TextAlign.center,
                                                  //               ),
                                                  //               Row(
                                                  //                 mainAxisAlignment:
                                                  //                     MainAxisAlignment
                                                  //                         .spaceBetween,
                                                  //                 children: [
                                                  //                   SizedBox(
                                                  //                       width:
                                                  //                           100,
                                                  //                       child: ElevatedButton(
                                                  //                           onPressed: () async {
                                                  //
                                                  //                               print(c.customerAmount);
                                                  //                               print(c.remainingAmount);
                                                  //
                                                  //                               if(p>=model.remainingAmount){
                                                  //                                 model.remainingAmount=0;
                                                  //                                 model.customerAmount=c.customerAmount+(model.remainingAmount-p);
                                                  //
                                                  //                               }else{
                                                  //                                 model.remainingAmount=model.remainingAmount-p;
                                                  //                                 model.customerAmount=c.customerAmount;
                                                  //                               }
                                                  //                               print(c.customerAmount);
                                                  //                               print(c.remainingAmount);
                                                  //                               setState(() {
                                                  //                             });
                                                  //                             CustomersCubit()
                                                  //                                 .updateCustomer2(
                                                  //                                 context,
                                                  //                                 model,
                                                  //                                 c.sId!).then((value) => Navigator.pop(context));
                                                  //                           },
                                                  //                           style: ButtonStyle(backgroundColor: MaterialStateProperty.all(accentCanvasColor)),
                                                  //                           child: Text('نعم', style: TextStyle(color: Colors.white)))),
                                                  //                   SizedBox(
                                                  //                       width:
                                                  //                           100,
                                                  //                       child: ElevatedButton(
                                                  //                           onPressed: () async {
                                                  //                             Navigator.pop(context);
                                                  //                           },
                                                  //                           style: ButtonStyle(backgroundColor: MaterialStateProperty.all(accentCanvasColor)),
                                                  //                           child: Text('لا', style: TextStyle(color: Colors.white)))),
                                                  //                 ],
                                                  //               )
                                                  //             ],
                                                  //           ),
                                                  //         );
                                                  //       });
                                                  // } else {
                                                  CustomersCubit()
                                                      .updateCustomer2(context,
                                                          model, c.sId!);
                                                }

                                                _formKey.currentState!.reset();
                                                nameController.clear();
                                                addressController.clear();
                                                totalController.text = "0.0";
                                                amountPaidController.clear();
                                                chestLengthController.clear();
                                                k1LengthController.clear();
                                                phoneController.clear();
                                                detailsController.clear();
                                                mLengthController.clear();
                                                neckController.clear();
                                                remainingAmountController
                                                    .clear();
                                                prizeController.clear();
                                                numDressesController.clear();
                                                hand1LengthController.clear();
                                                lengthController.clear();
                                                setState(() {
                                                  ya2a = null;
                                                  gyb = null;
                                                  glab = null;
                                                  taqwera = null;
                                                  ganb = null;
                                                  kom = null;
                                                  taqwera = null;
                                                  sadr = null;
                                                  glab1 = false;
                                                  glab2 = false;
                                                  ya2a1 = false;
                                                  ya2a2 = false;
                                                  ya2a3 = false;
                                                  gyb1 = false;
                                                  gyb2 = false;
                                                  gyb3 = false;
                                                  ganb1 = false;
                                                  ganb2 = false;
                                                  taqwera1 = false;
                                                  taqwera2 = false;
                                                  taqwera3 = false;
                                                  kom1 = false;
                                                  kom2 = false;
                                                  kom3 = false;
                                                  kom4 = false;
                                                  kom5 = false;
                                                  kom6 = false;
                                                  kom7 = false;
                                                  kom8 = false;
                                                  kom9 = false;
                                                  kom10 = false;
                                                  sadr1 = false;
                                                  sadr2 = false;
                                                  sadr3 = false;
                                                  sadr4 = false;
                                                });
                                              });
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        backgroundColor)),
                                            child: const Text(
                                              'اضافة',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ));
                                      }))),
                              SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        final pdfFile =
                                            await PdfInvoiceApi.generate(
                                                productsModel, null);

                                        await Printing.layoutPdf(
                                            onLayout:
                                                (PdfPageFormat format) async =>
                                                    pdfFile.save());
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  backgroundColor)),
                                      child: Text('طباعة',
                                          style:
                                              TextStyle(color: Colors.white)))),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ])),
          ),
        ),
      ),
    );
  }

  Mobile() {
    return SafeArea(
      child: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "images/login.jpg",
            ),
            fit: BoxFit.cover,
          )),
          child: Container(
            height: double.infinity,
            color: Colors.black.withOpacity(0.8),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                              "images/login.jpg",
                            ),
                            fit: BoxFit.cover,
                          )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => HomeScreen()));
                                    },
                                    child: HoverAnimatedContainer(
                                      hoverWidth: 200,
                                      padding: EdgeInsets.all(10),
                                      hoverDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red.withOpacity(0.8),
                                      ),
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xffBCEFC2),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.home,
                                            size: 25,
                                          ),
                                          Text(
                                            "الصفحة الرئيسية",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => AllDataScreen()));
                                    },
                                    child: HoverAnimatedContainer(
                                      hoverWidth: 200,
                                      padding: EdgeInsets.all(10),
                                      hoverDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red.withOpacity(0.8),
                                      ),
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xffBCEFC2),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "images/receipt.png",
                                            height: 25,
                                          ),
                                          Text(
                                            " الفواتير",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "اضافة فاتورة جديدة",
                                    style: TextStyle(
                                        fontSize: 25,
                                        wordSpacing: 2,
                                        color: Colors.white.withOpacity(0.8),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset("images/report.png", height: 50),
                                ],
                              ),
                            ],
                          ),
                        ),

                        ////////////////////////  بيانات العميل  /////////////////////////////
                        SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Expanded(
                                child: Divider(
                              color: Colors.white,
                            )),
                            Text(
                              "     بيانات العميل    ",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Expanded(
                                child: Divider(
                              color: Colors.white,
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'رقم الفاتورة',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17),
                                      ),
                                      CustomTextField(
                                        prefix: Icon(Icons.code),
                                        controller: codeController..text,
                                        isPhoneNumber: true,
                                        hintText: 'ادخل رقم الفاتورة',
                                        isFormField: true,
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'عدد الاثواب',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  CustomTextField(
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    controller: numDressesController,
                                    textInputType: TextInputType.number,
                                    isFormField: true,
                                    hintText: 'ادخل عدد الاثواب',
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'عميل موجود مسبقاً',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: buttonColor,
                                          ),
                                          child: DropDownTextField(
                                            padding: EdgeInsets.zero,
                                            textFieldDecoration:
                                                InputDecoration(
                                                    hintText: "ادخل اسم العميل",
                                                    border: InputBorder.none),
                                            // initialValue: "name4",
                                            controller: controller,
                                            clearOption: false,

                                            readOnly: false,
                                            // dropdownColor: Colors.green,
                                            searchDecoration:
                                                const InputDecoration(
                                                    hintText:
                                                        "ادخل اسم العميل"),
                                            validator: (value) {
                                              if (value == null) {
                                                return "Required field";
                                              } else {
                                                return null;
                                              }
                                            },
                                            dropDownItemCount: 1000,

                                            dropDownList: customer
                                                .map(
                                                  (e) => DropDownValueModel(
                                                      name: e, value: e),
                                                )
                                                .toList(),

                                            onChanged: (val) {
                                              Customer? c = customerModel
                                                  .firstWhereOrNull((element) =>
                                                      element.userName ==
                                                      val.name);

                                              setState(() {
                                                nameController.text =
                                                    val.name.toString();
                                                addressController.text =
                                                    c!.address!;
                                                phoneController.text = c.phone!;
                                                neckController
                                                  ..text = c.neckLength == null
                                                      ? "0"
                                                      : c.neckLength.toString();
                                                hand1LengthController.text =
                                                    c.handLength == null
                                                        ? "0"
                                                        : c.handLength
                                                            .toString();
                                                k1LengthController.text =
                                                    c.kabkLength == null
                                                        ? "0"
                                                        : c.kabkLength
                                                            .toString();
                                                chestLengthController.text =
                                                    c.sadrLength == null
                                                        ? "0"
                                                        : c.sadrLength
                                                            .toString();
                                                lengthController.text =
                                                    c.length == null
                                                        ? "0"
                                                        : c.length.toString();

                                                ketfLengthController.text =
                                                    c.ketfLength == null
                                                        ? "0"
                                                        : c.ketfLength
                                                            .toString();
                                                komLengthController.text =
                                                    c.komLength == null
                                                        ? "0"
                                                        : c.komLength
                                                            .toString();
                                              });
                                            },
                                          ),
                                        )
                                      ]),
                                )),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          ' اسم المشتري ',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                        CustomTextField(
                                          prefix:
                                              Icon(Icons.add_reaction_outlined),
                                          controller: nameController,
                                          isFormField: true,
                                          hintText: 'ادخل اسم المشتري ',
                                          onChanged: (val) {
                                            setState(() {
                                              controller.clearDropDown();
                                            });
                                          },
                                        )
                                      ]),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'رقم الهاتف',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  CustomTextField(
                                    prefix: Icon(Icons.phone_android),
                                    controller: phoneController,
                                    isPhoneNumber: true,
                                    hintText: 'ادخل رقم الهاتف',
                                    isFormField: true,
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'العنوان',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  CustomTextField(
                                    prefix: Icon(Icons.home_outlined),
                                    controller: addressController,
                                    textInputType: TextInputType.streetAddress,
                                    isFormField: true,
                                    hintText: 'ادخل العنوان ',
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                        //////////////////////// المقاسات  /////////////////////////////

                        const Row(
                          children: [
                            Expanded(
                                child: Divider(
                              color: Colors.white,
                            )),
                            Text(
                              "     المقاسات    ",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Expanded(
                                child: Divider(
                              color: Colors.white,
                            )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'الطول',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                  CustomTextField(
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    controller: lengthController,
                                    textInputType: TextInputType.number,
                                    hintText: 'ادخل الطول',
                                    isFormField: true,
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'الكتف',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                  CustomTextField(
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    controller: ketfLengthController,
                                    textInputType: TextInputType.number,
                                    hintText: 'ادخل الطول',
                                    isFormField: true,
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'طول الكم',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                  CustomTextField(
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    controller: komLengthController,
                                    textInputType: TextInputType.number,
                                    hintText: 'ادخل الطول',
                                    isFormField: true,
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'وسع الصدر',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                  CustomTextField(
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    controller: chestLengthController,
                                    textInputType: TextInputType.number,
                                    isFormField: true,
                                    hintText: ' ادخل وسع الصدر ',
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'الرقبة',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                  CustomTextField(
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    controller: neckController,
                                    textInputType: TextInputType.number,
                                    hintText: 'الرقبة',
                                    isFormField: true,
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'وسع اليد',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: buttonColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller:
                                                    hand1LengthController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  hintText: 'ادخل المقاس',
                                                  hintStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              TextFormField(
                                                controller:
                                                    hand2LengthController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  hintText: 'ادخل  المقاس',
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  hintStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'طول الكبك',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: buttonColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: k1LengthController,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            hintText: 'ادخل المقاس ',
                                            contentPadding: EdgeInsets.all(10),
                                            hintStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: k2LengthController,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            hintText: 'ادخل المقاس',
                                            contentPadding: EdgeInsets.all(10),
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'سقوط التقويرة',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: buttonColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: taqwera1LengthController,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            hintText: 'ادخل المقاس',
                                            contentPadding: EdgeInsets.all(10),
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TextFormField(
                                          textAlign: TextAlign.center,
                                          controller: taqwera2LengthController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'ادخل المقاس',
                                            contentPadding: EdgeInsets.all(10),
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TextFormField(
                                          textAlign: TextAlign.center,
                                          controller: taqwera3LengthController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'ادخل المقاس',
                                            contentPadding: EdgeInsets.all(10),
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'مقاس البدن',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: buttonColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          textAlign: TextAlign.center,
                                          controller: badnLengthController1,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'ادخل المقاس',
                                            contentPadding: EdgeInsets.all(10),
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: badnLengthController2,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            hintText: 'ادخل المقاس',
                                            contentPadding: EdgeInsets.all(10),
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: badnLengthController3,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            hintText: 'ادخل المقاس',
                                            contentPadding: EdgeInsets.all(10),
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                          ],
                        ),
                        ////////////////////////  بيانات الطلب  /////////////////////////////
                        const Row(
                          children: [
                            Expanded(
                                child: Divider(
                              color: Colors.white,
                            )),
                            Text(
                              "     بيانات الطلب    ",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Expanded(
                                child: Divider(
                              color: Colors.white,
                            )),
                          ],
                        ),

                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'نوع التفصيل : ',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: RadioListTile(
                                                title: const Text(
                                                  'بلدي',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                value: SingingCharacter.balady,
                                                groupValue: _character,
                                                activeColor: buttonColor,
                                                fillColor:
                                                    MaterialStateProperty.all(
                                                        buttonColor),
                                                tileColor: Colors.white,
                                                selectedTileColor: Colors.white,
                                                visualDensity:
                                                    VisualDensity.standard,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _character = value!;
                                                  });
                                                },
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
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
                                                        value: SingingCharacter
                                                            .afrangy,
                                                        activeColor:
                                                            buttonColor,
                                                        tileColor: Colors.white,
                                                        fillColor:
                                                            MaterialStateProperty
                                                                .all(
                                                                    buttonColor),
                                                        selectedTileColor:
                                                            Colors.white,
                                                        groupValue: _character,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _character = value;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  _character == SingingCharacter.balady
                                      ? Container(
                                          margin: EdgeInsets.all(10),
                                          width: 400,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xffBCEFC2),
                                          ),
                                          child: DropdownButton(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            underline: SizedBox(),
                                            hint: _dropDownValueC == null
                                                ? Text(
                                                    'اضغط للاختيار',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : Text(
                                                    _dropDownValueC!,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                            isExpanded: true,
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            iconSize: 30.0,
                                            style:
                                                TextStyle(color: Colors.black),
                                            items: [
                                              'كلفة تامة بشليك',
                                              'كلفة تامة نص ياقة',
                                              'قشره',
                                              "اسطنبولي",
                                            ].map(
                                              (val) {
                                                return DropdownMenuItem<String>(
                                                  value: val,
                                                  child: Text(val),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (val) {
                                              setState(
                                                () {
                                                  _dropDownValueC = val;
                                                },
                                              );
                                            },
                                          ),
                                        )
                                      : _character == SingingCharacter.afrangy
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color(0xffBCEFC2),
                                                    ),
                                                    child: DropdownButton(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      underline: SizedBox(),
                                                      hint: _dropDownValueA ==
                                                              null
                                                          ? Text(
                                                              'اضغط للاختيار',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Text(
                                                              _dropDownValueA!,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16),
                                                            ),
                                                      isExpanded: true,
                                                      padding: EdgeInsets.only(
                                                          left: 20, right: 20),
                                                      iconSize: 30.0,
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      items: [
                                                        'قطري',
                                                        'سعودي',
                                                        'كويتي',
                                                        "بولاقي",
                                                        "كوم سادة عماني",
                                                        "شعراوي كوم سادة",
                                                        "سوداني كوم سادة"
                                                      ].map(
                                                        (val) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: val,
                                                            child: Text(val),
                                                          );
                                                        },
                                                      ).toList(),
                                                      onChanged: (val) {
                                                        setState(
                                                          () {
                                                            _dropDownValueA =
                                                                val;
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                _dropDownValueA == "قطري" ||
                                                        _dropDownValueA ==
                                                            "سعودي" ||
                                                        _dropDownValueA ==
                                                            "كويتي" ||
                                                        _dropDownValueA ==
                                                            "بولاقي"
                                                    ? Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          width: 400,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Color(
                                                                0xffBCEFC2),
                                                          ),
                                                          child: DropdownButton(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            underline:
                                                                SizedBox(),
                                                            hint:
                                                                _dropDownValueB ==
                                                                        null
                                                                    ? Text(
                                                                        'اضغط للاختيار ',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )
                                                                    : Text(
                                                                        _dropDownValueB!,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 16),
                                                                      ),
                                                            isExpanded: true,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 20),
                                                            iconSize: 30.0,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                            items: [
                                                              '2 كباسين كوم سادة',
                                                              '2 كباسين كوم كبك',
                                                              'جلاب كوم سادة',
                                                              'جلاب كوم كبك',
                                                              "2 كباسين كوم سادة بشليك",
                                                              "2 كباسين كوم سادة بشليك لزق مفتوح",
                                                            ].map(
                                                              (val) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value: val,
                                                                  child:
                                                                      Text(val),
                                                                );
                                                              },
                                                            ).toList(),
                                                            onChanged: (val) {
                                                              setState(
                                                                () {
                                                                  _dropDownValueB =
                                                                      val;
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            )
                                          : SizedBox(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            ////////////////////////  نوع  /////////////////////////////

                            const Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  color: Colors.white,
                                )),
                                Text(
                                  "     نوع القماش    ",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Expanded(
                                    child: Divider(
                                  color: Colors.white,
                                )),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'نوع القماش',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: buttonColor,
                                        ),
                                        child: DropDownTextField(
                                          padding: EdgeInsets.zero,
                                          textFieldDecoration: InputDecoration(
                                              hintText: "ادخل نوع القماش",
                                              border: InputBorder.none),
                                          // initialValue: "name4",
                                          controller: controllerType,
                                          clearOption: false,

                                          readOnly: false,
                                          // dropdownColor: Colors.green,
                                          searchDecoration:
                                              const InputDecoration(
                                                  hintText: "اختار نوع القماش"),
                                          validator: (value) {
                                            if (value == null) {
                                              return "Required field";
                                            } else {
                                              return null;
                                            }
                                          },
                                          dropDownItemCount: 3,

                                          dropDownList: category
                                              .map(
                                                (e) => DropDownValueModel(
                                                    name: e, value: e),
                                              )
                                              .toList(),

                                          onChanged: (val) {
                                            quantityController.clear();
                                            totalTypeController.text = "0.0";
                                            print(
                                                remainingAmountController.text);

                                            print(totalController.text);

                                            categoryName = val.name;
                                            CategoryModel? c = categoryModel
                                                .firstWhereOrNull((element) =>
                                                    element.type == val.name);

                                            setState(() {
                                              quantityTypeController.text =
                                                  c!.quantity.toString();
                                              categoryQuantity =
                                                  c!.quantity.toString();
                                              priceTypeController.text =
                                                  c.price.toString()!;
                                              categoryPrice = c.price!;
                                            });
                                            setState(() {
                                              totalController
                                                  .text = ((worker_costController
                                                              .text.isEmpty
                                                          ? 0.0
                                                          : double.parse(
                                                              worker_costController
                                                                  .text)) +
                                                      (prizeController
                                                              .text.isEmpty
                                                          ? 0.0
                                                          : double.parse(
                                                              prizeController
                                                                  .text)) +
                                                      double.parse(
                                                          totalTypeController
                                                              .text))
                                                  .toString();
                                              remainingAmountController
                                                  .text = (double.parse(
                                                          totalController
                                                                  .text.isEmpty
                                                              ? "0.0"
                                                              : totalController
                                                                  .text) -
                                                      (amountPaidController
                                                              .text.isNotEmpty
                                                          ? double.parse(
                                                              amountPaidController
                                                                  .text)
                                                          : 0.0))
                                                  .toString();
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'الكمية المتاحة في المخزن',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      CustomTextField(
                                        prefix: Icon(
                                            Icons.auto_awesome_mosaic_sharp),
                                        enable: false,
                                        controller: quantityTypeController,
                                        textInputType: TextInputType.number,
                                        hintText: 'ادخل النوع',
                                        isFormField: true,
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'سعر المتر',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      CustomTextField(
                                        prefix: Icon(
                                            Icons.monetization_on_outlined),
                                        controller: priceTypeController,
                                        enable: false,
                                        textInputType: TextInputType.number,
                                        hintText: 'سعر المتر',
                                        isFormField: true,
                                      ),
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        ' الكمية',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      CustomTextField(
                                        prefix: Icon(
                                            Icons.auto_awesome_mosaic_sharp),
                                        controller: quantityController,
                                        onChanged: (val) {
                                          if (val.isEmpty ||
                                              priceTypeController
                                                  .text.isEmpty ||
                                              quantityTypeController
                                                  .text.isEmpty) {
                                            setState(() {
                                              quantityTypeController.text =
                                                  categoryQuantity;
                                              totalTypeController.text = "0.0";
                                            });
                                          } else {
                                            quantityTypeController.text =
                                                (double.parse(
                                                            categoryQuantity) -
                                                        double.parse(
                                                            quantityController
                                                                .text))
                                                    .toString();
                                            totalTypeController.text =
                                                (double.parse(quantityController
                                                            .text) *
                                                        double.parse(
                                                            priceTypeController
                                                                .text))
                                                    .toString();
                                          }

                                          totalController
                                              .text = ((worker_costController
                                                          .text.isEmpty
                                                      ? 0.0
                                                      : double.parse(
                                                          worker_costController
                                                              .text)) +
                                                  (prizeController.text.isEmpty
                                                      ? 0.0
                                                      : double.parse(
                                                          prizeController
                                                              .text)) +
                                                  double.parse(
                                                      totalTypeController.text))
                                              .toString();
                                          remainingAmountController
                                              .text = (double.parse(
                                                      totalController
                                                              .text.isEmpty
                                                          ? "0.0"
                                                          : totalController
                                                              .text) -
                                                  (amountPaidController
                                                          .text.isNotEmpty
                                                      ? double.parse(
                                                          amountPaidController
                                                              .text)
                                                      : 0.0))
                                              .toString();

                                          setState(() {});
                                        },
                                        textInputType: TextInputType.number,
                                        hintText: 'ادخل الكمية',
                                        isFormField: true,
                                      ),
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'الاجمالي',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      CustomTextField(
                                        prefix: Icon(
                                            Icons.monetization_on_outlined),
                                        controller: totalTypeController,
                                        enable: false,
                                        textInputType: TextInputType.number,
                                        hintText: 'الاجمالي',
                                        isFormField: true,
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            ////////////////////////  الدفع  /////////////////////////////

                            const Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  color: Colors.white,
                                )),
                                Text(
                                  "     الدفع    ",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Expanded(
                                    child: Divider(
                                  color: Colors.white,
                                )),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'القيمة',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      CustomTextField(
                                        onChanged: (val) {
                                          setState(() {
                                            totalController
                                                .text = ((worker_costController
                                                            .text.isEmpty
                                                        ? 0.0
                                                        : double.parse(
                                                            worker_costController
                                                                .text)) +
                                                    (val.isEmpty
                                                        ? 0.0
                                                        : double.parse(val)) +
                                                    double.parse(
                                                        totalTypeController
                                                            .text))
                                                .toString();
                                            remainingAmountController
                                                .text = (double.parse(
                                                        totalController.text) -
                                                    (amountPaidController
                                                            .text.isNotEmpty
                                                        ? double.parse(
                                                            amountPaidController
                                                                .text)
                                                        : 0.0))
                                                .abs()
                                                .toString();
                                          });

                                          setState(() {
                                            show = false;
                                          });
                                        },
                                        prefix: Icon(Icons.attach_money),
                                        controller: prizeController,
                                        textInputType: TextInputType.number,
                                        hintText: '0.0\$ ',
                                        isFormField: true,
                                      ),
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'المصنعية',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      CustomTextField(
                                        prefix: Icon(Icons.attach_money),
                                        onChanged: (val) {
                                          setState(() {
                                            totalController
                                                .text = ((worker_costController
                                                            .text.isEmpty
                                                        ? 0.0
                                                        : double.parse(
                                                            worker_costController
                                                                .text)) +
                                                    (prizeController
                                                            .text.isEmpty
                                                        ? 0.0
                                                        : double.parse(
                                                            prizeController
                                                                .text)) +
                                                    double.parse(
                                                        totalTypeController
                                                            .text))
                                                .toString();
                                          });

                                          remainingAmountController
                                              .text = (double.parse(
                                                      totalController.text) -
                                                  (amountPaidController
                                                          .text.isNotEmpty
                                                      ? double.parse(
                                                          amountPaidController
                                                              .text)
                                                      : 0.0))
                                              .toString();
                                          setState(() {
                                            show = false;
                                          });
                                        },
                                        controller: worker_costController,
                                        textInputType: TextInputType.number,
                                        hintText: 'ادخل مبلغ المصنعية',
                                        isFormField: true,
                                      ),
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'المبلغ المدفوع',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      CustomTextField(
                                        prefix: Icon(Icons.attach_money),
                                        onChanged: (val) {
                                          if (double.tryParse(
                                                  val.isNotEmpty ? val : "0")! >
                                              double.tryParse(
                                                  totalController.text)!) {
                                            remainingAmountController.text =
                                                "0";
                                            setState(() {
                                              show = true;
                                            });
                                          } else {
                                            remainingAmountController
                                                .text = (double.tryParse(
                                                        totalController.text)! -
                                                    double.tryParse(
                                                        val.isNotEmpty
                                                            ? val
                                                            : "0")!)
                                                .toString();

                                            setState(() {
                                              show = false;
                                            });
                                          }
                                        },
                                        controller: amountPaidController,
                                        textInputType: TextInputType.number,
                                        isFormField: true,
                                        hintText: '0.0\$ ',
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'المبلغ المتبقى',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      CustomTextField(
                                        prefix: Icon(Icons.attach_money),
                                        controller: remainingAmountController,
                                        textInputType: TextInputType.number,
                                        hintText: 'ادخل المبلغ المتبقى',
                                        isFormField: true,
                                      ),
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'الاجمالي',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      CustomTextField(
                                        prefix: Icon(Icons.attach_money),
                                        controller: totalController,
                                        textInputType: TextInputType.number,
                                        hintText: 'الاجمالي',
                                        isFormField: true,
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            show == true
                                ? Text(
                                    ' يوجد ${(double.tryParse(amountPaidController.text.isNotEmpty ? amountPaidController.text : "0")! - double.tryParse(totalController.text.isNotEmpty ? totalController.text : "0")!)} مبلغ ذيادة',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.red),
                                  )
                                : SizedBox(),

                            ////////////////////////  التاريخ  /////////////////////////////

                            const Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  color: Colors.white,
                                )),
                                Text(
                                  "     التاريخ    ",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Expanded(
                                    child: Divider(
                                  color: Colors.white,
                                )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'تاريخ الفاتوره',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _selectDate(context);
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(0xffBCEFC2),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 3,
                                                    offset: Offset(0, 1))
                                                // changes position of shadow
                                              ],
                                            ),
                                            child: TextField(
                                              controller: _dateController,
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                                _selectDate(context);
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,

                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                isDense: true,
                                                fillColor: Colors.black12,
                                                enabled: false,
                                                hintText:
                                                    _selectedDate.toString(),
                                                labelText:
                                                    _selectedDate.toString(),
                                                labelStyle: const TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                // iconOrdrop: 'button',
                                                prefixIcon: const Icon(
                                                  Icons.date_range_outlined,
                                                  size: 25,
                                                  color: accentCanvasColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'تاريخ الاستلام',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _selectDate(context);
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(0xffBCEFC2),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 3,
                                                    offset: Offset(0, 1))
                                                // changes position of shadow
                                              ],
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());

                                                _selectDate2(context);
                                              },
                                              child: TextField(
                                                controller:
                                                    _dateDeliveryController,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,

                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15),
                                                  isDense: true,
                                                  fillColor: Colors.black12,
                                                  enabled: false,
                                                  hintText: selectedDeliveryDate
                                                      .toString(),
                                                  labelText:
                                                      selectedDeliveryDate
                                                          .toString(),
                                                  labelStyle: const TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  // iconOrdrop: 'button',
                                                  prefixIcon: const Icon(
                                                    Icons.date_range_outlined,
                                                    size: 25,
                                                    color: accentCanvasColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ////////////////////////  الاضافات  /////////////////////////////
                            SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  color: Colors.white,
                                )),
                                Text(
                                  "     الاضافات    ",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Expanded(
                                    child: Divider(
                                  color: Colors.white,
                                )),
                              ],
                            ),
                            ExpansionTile(
                              shape: InputBorder.none,
                              collapsedBackgroundColor: buttonColor,
                              backgroundColor: buttonColor,
                              title: Text(
                                " اضفط هنا لظهور الاضافات ",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage(
                                      "images/login.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.8),
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    child: _character ==
                                            SingingCharacter.afrangy
                                        ? Wrap(
                                            spacing: 20,
                                            runSpacing: 20,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Container(
                                                width: 400,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: accentCanvasColor
                                                        .withOpacity(0.8)),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController4.nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                        icon: Icon(
                                                          Icons.chevron_left,
                                                          color: Colors.white,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        children: [
                                                          CarouselSlider(
                                                              items: list6,
                                                              carouselController:
                                                                  buttonCarouselController4,
                                                              options:
                                                                  CarouselOptions(
                                                                onPageChanged:
                                                                    (index,
                                                                        c) {},
                                                                autoPlay: false,
                                                                enlargeCenterPage:
                                                                    true,
                                                                viewportFraction:
                                                                    0.9,
                                                                aspectRatio:
                                                                    2.0,
                                                                initialPage: 2,
                                                              )),
                                                          CustomTextField(
                                                            textInputType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                sadrController,
                                                            hintText:
                                                                "ادخل المقاس",
                                                            prefix: Icon(Icons
                                                                .format_size_outlined),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          buttonCarouselController4
                                                              .previousPage(
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          1),
                                                                  curve: Curves
                                                                      .linear);
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_left_sharp,
                                                          color: Colors.white,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 300,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: accentCanvasColor
                                                        .withOpacity(0.8)),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController5.nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                        icon: Icon(
                                                          Icons.chevron_left,
                                                          color: Colors.white,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        children: [
                                                          CarouselSlider(
                                                              items: list7,
                                                              carouselController:
                                                                  buttonCarouselController5,
                                                              options:
                                                                  CarouselOptions(
                                                                onPageChanged:
                                                                    (index, c) {
                                                                  print(index);
                                                                  kom = index ==
                                                                          0
                                                                      ? "كم شعراوي علية زراير"
                                                                      : index ==
                                                                              1
                                                                          ? "كم بلدي"
                                                                          : index == 2
                                                                              ? "الكم سادة+بشليك لزق"
                                                                              : index == 3
                                                                                  ? "الكم سادة"
                                                                                  : index == 4
                                                                                      ? "اساورة بشليك"
                                                                                      : index == 5
                                                                                          ? "اساورة كسرة واحد"
                                                                                          : index == 6
                                                                                              ? "اساورة مربع بدون كسرة"
                                                                                              : index == 7
                                                                                                  ? "اساورة مربع كسرة واحدة"
                                                                                                  : index == 8
                                                                                                      ? "اساورة مربع بدون كسرة"
                                                                                                      : "اساورة مربع 2 كسرة";
                                                                  print(kom);
                                                                },
                                                                autoPlay: false,
                                                                enlargeCenterPage:
                                                                    true,
                                                                viewportFraction:
                                                                    0.9,
                                                                aspectRatio:
                                                                    2.0,
                                                                initialPage: 2,
                                                              )),
                                                          CustomTextField(
                                                            textInputType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                komController,
                                                            prefix: Icon(Icons
                                                                .format_size),
                                                            hintText:
                                                                "ادخل المقاس",
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController5
                                                                .previousPage(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            1),
                                                                    curve: Curves
                                                                        .linear),
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_left_sharp,
                                                          color: Colors.white,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 300,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: accentCanvasColor
                                                        .withOpacity(0.8)),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController6.nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                        icon: Icon(
                                                          Icons.chevron_left,
                                                          size: 50,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Column(
                                                        children: [
                                                          CarouselSlider(
                                                              items: list3,
                                                              carouselController:
                                                                  buttonCarouselController6,
                                                              options:
                                                                  CarouselOptions(
                                                                onPageChanged:
                                                                    (index, c) {
                                                                  print(index);
                                                                  glab = index ==
                                                                          0
                                                                      ? "جلاب 1 زرار"
                                                                      : "جلاب 2 زرار";
                                                                  print(glab);
                                                                },
                                                                autoPlay: false,
                                                                enlargeCenterPage:
                                                                    true,
                                                                viewportFraction:
                                                                    0.9,
                                                                aspectRatio:
                                                                    1.0,
                                                                initialPage: 2,
                                                              )),
                                                          CustomTextField(
                                                            textInputType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                glabController,
                                                            prefix: Icon(Icons
                                                                .format_size),
                                                            hintText:
                                                                "ادخل المقاس",
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController6
                                                                .previousPage(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            1),
                                                                    curve: Curves
                                                                        .linear),
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_left_sharp,
                                                          color: Colors.white,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 300,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: accentCanvasColor
                                                        .withOpacity(0.8)),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController7.nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                        icon: Icon(
                                                          Icons.chevron_left,
                                                          size: 50,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        children: [
                                                          CarouselSlider(
                                                              items: list4,
                                                              carouselController:
                                                                  buttonCarouselController7,
                                                              options:
                                                                  CarouselOptions(
                                                                onPageChanged:
                                                                    (index, c) {
                                                                  print(index);
                                                                  ganb = index ==
                                                                          0
                                                                      ? "جانب بشليك"
                                                                      : "جانب شق";
                                                                  print(ganb);
                                                                },
                                                                autoPlay: false,
                                                                enlargeCenterPage:
                                                                    true,
                                                                viewportFraction:
                                                                    0.9,
                                                                aspectRatio:
                                                                    1.0,
                                                                initialPage: 2,
                                                              )),
                                                          SizedBox(
                                                            height: 5,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController7
                                                                .previousPage(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            1),
                                                                    curve: Curves
                                                                        .linear),
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_left_sharp,
                                                          color: Colors.white,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 400,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: accentCanvasColor
                                                        .withOpacity(0.8)),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController3.nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                        icon: Icon(
                                                          Icons.chevron_left,
                                                          color: Colors.white,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        children: [
                                                          CarouselSlider(
                                                              items: list5,
                                                              carouselController:
                                                                  buttonCarouselController3,
                                                              options:
                                                                  CarouselOptions(
                                                                onPageChanged:
                                                                    (index, c) {
                                                                  print(index);
                                                                  gyb = index ==
                                                                          0
                                                                      ? "جيب مربع"
                                                                      : index ==
                                                                              1
                                                                          ? "جيب مربع مثلث"
                                                                          : "جيب مدور";
                                                                  print(gyb);
                                                                },
                                                                autoPlay: false,
                                                                enlargeCenterPage:
                                                                    true,
                                                                viewportFraction:
                                                                    0.9,
                                                                aspectRatio:
                                                                    2.0,
                                                                initialPage: 2,
                                                              )),
                                                          CustomTextField(
                                                            textInputType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                gybController,
                                                            prefix: Icon(Icons
                                                                .format_size),
                                                            hintText:
                                                                "ادخل المقاس",
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController3
                                                                .previousPage(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            1),
                                                                    curve: Curves
                                                                        .linear),
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_left_sharp,
                                                          color: Colors.white,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : Wrap(
                                            runSpacing: 20,
                                            spacing: 20,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(20),
                                                width: 400,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: accentCanvasColor
                                                        .withOpacity(0.8)),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController1.nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                        icon: Icon(
                                                          Icons.chevron_left,
                                                          color: Colors.white,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        children: [
                                                          CarouselSlider(
                                                              items: list1,
                                                              carouselController:
                                                                  buttonCarouselController1,
                                                              options:
                                                                  CarouselOptions(
                                                                onPageChanged:
                                                                    (index, c) {
                                                                  print(index);
                                                                  taqwera = index ==
                                                                          0
                                                                      ? "كلفة تامة بشليك"
                                                                      : index ==
                                                                              1
                                                                          ? "كلفة تامة نص ياقة"
                                                                          : index == 2
                                                                              ? "جلابية قشرة"
                                                                              : "اسطنبولي";
                                                                  print(
                                                                      taqwera);
                                                                },
                                                                autoPlay: false,
                                                                enlargeCenterPage:
                                                                    true,
                                                                viewportFraction:
                                                                    0.9,
                                                                aspectRatio:
                                                                    2.0,
                                                                initialPage: 2,
                                                              )),
                                                          CustomTextField(
                                                            textInputType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                taqweraController,
                                                            prefix: Icon(Icons
                                                                .format_size),
                                                            hintText:
                                                                "ادخل المقاس",
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController1
                                                                .previousPage(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            1),
                                                                    curve: Curves
                                                                        .linear),
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_left_sharp,
                                                          color: Colors.white,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 60,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(20),
                                                width: 400,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: accentCanvasColor
                                                        .withOpacity(0.8)),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController2.nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1),
                                                                curve: Curves
                                                                    .linear),
                                                        icon: Icon(
                                                          Icons.chevron_left,
                                                          color: Colors.white,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        children: [
                                                          CarouselSlider(
                                                              items: list2,
                                                              carouselController:
                                                                  buttonCarouselController2,
                                                              options:
                                                                  CarouselOptions(
                                                                onPageChanged:
                                                                    (index, c) {
                                                                  print(index);
                                                                  ya2a = index ==
                                                                          0
                                                                      ? "الياقة بدون زراير"
                                                                      : index ==
                                                                              1
                                                                          ? "الياقة زرار واحد"
                                                                          : "الياقة 2 زرار";
                                                                  print(ya2a);
                                                                },
                                                                autoPlay: false,
                                                                enlargeCenterPage:
                                                                    true,
                                                                viewportFraction:
                                                                    0.9,
                                                                aspectRatio:
                                                                    2.0,
                                                                initialPage: 2,
                                                              )),
                                                          CustomTextField(
                                                            controller:
                                                                ya2aController,
                                                            textInputType:
                                                                TextInputType
                                                                    .number,
                                                            prefix: Icon(Icons
                                                                .format_size),
                                                            hintText:
                                                                "ادخل المقاس",
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            buttonCarouselController2
                                                                .previousPage(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            1),
                                                                    curve: Curves
                                                                        .linear),
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_left_sharp,
                                                          color: Colors.white,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                )
                              ],
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width: 150,
                                    height: 50,
                                    child: BlocProvider(
                                        create: (context) => ProductCubit(),
                                        child: BlocConsumer<ProductCubit,
                                                ProductsMainState>(
                                            listener: (BuildContext context,
                                                state) async {
                                          if (state
                                              is AddProductsLoadingState) {
                                            SmartDialog.showLoading();
                                            await Future.delayed(
                                                Duration(seconds: 2));
                                            SmartDialog.dismiss();
                                          }
                                        }, builder:
                                                (BuildContext context, state) {
                                          var product =
                                              ProductCubit.get(context);
                                          return ElevatedButton(
                                              onPressed: () {
                                                var p = (double.tryParse(
                                                        amountPaidController
                                                                .text.isNotEmpty
                                                            ? amountPaidController
                                                                .text
                                                            : "0")! -
                                                    double.tryParse(
                                                        totalController
                                                                .text.isNotEmpty
                                                            ? totalController
                                                                .text
                                                            : "0")!);
                                                setState(() {
                                                  productsModel = ProductsModel(
                                                    name: nameController.text,
                                                    date: _selectedDate,
                                                    length: double.tryParse(
                                                        lengthController.text),
                                                    badnSize1: double.tryParse(
                                                        badnLengthController1
                                                            .text),
                                                    badnSize2: double.tryParse(
                                                        badnLengthController2
                                                            .text),
                                                    badnSize3: double.tryParse(
                                                        badnLengthController3
                                                            .text),
                                                    droppTaqwera1: double.tryParse(
                                                        taqwera1LengthController
                                                            .text),
                                                    droppTaqwera2: double.tryParse(
                                                        taqwera2LengthController
                                                            .text),
                                                    droppTaqwera3: double.tryParse(
                                                        taqwera3LengthController
                                                            .text),
                                                    hand2Length: double.tryParse(
                                                        hand2LengthController
                                                            .text),
                                                    k2Length: double.tryParse(
                                                        k2LengthController
                                                            .text),
                                                    taqweraSize:
                                                        double.tryParse(
                                                            taqweraController
                                                                .text),
                                                    ganbSize: double.tryParse(
                                                        ganbController.text),
                                                    glabSize: double.tryParse(
                                                        glabController.text),
                                                    komSize: double.tryParse(
                                                        komController.text),
                                                    yaqaSize: double.tryParse(
                                                        ya2aController.text),
                                                    gaybSize: double.tryParse(
                                                        gybController.text),
                                                    sadrSize: double.tryParse(
                                                        sadrController.text),
                                                    address:
                                                        addressController.text,
                                                    amountPaid: double.tryParse(
                                                        amountPaidController
                                                            .text),
                                                    additionalType2:
                                                        _character ==
                                                                SingingCharacter
                                                                    .afrangy
                                                            ? _dropDownValueB ??
                                                                ""
                                                            : "",
                                                    chestLength: double.tryParse(
                                                        chestLengthController
                                                            .text),
                                                    createdAt: DateTime.now()
                                                        .toString(),
                                                    details:
                                                        detailsController.text,
                                                    handLength: double.tryParse(
                                                        hand1LengthController
                                                            .text),
                                                    image: "ds",
                                                    kLength: double.tryParse(
                                                        k1LengthController
                                                            .text),
                                                    mLength: double.tryParse(
                                                        mLengthController.text),
                                                    numDresses: double.tryParse(
                                                        numDressesController
                                                            .text),
                                                    neck: double.tryParse(
                                                        neckController.text),
                                                    phone: phoneController.text,
                                                    prize: double.tryParse(
                                                        totalController.text),
                                                    remainingAmount:
                                                        double.tryParse(
                                                            remainingAmountController
                                                                .text),
                                                    ganb: ganb,
                                                    gayb: gyb,
                                                    taqwera: taqwera,
                                                    yaqa: ya2a,
                                                    kom: kom,
                                                    additionalType1:
                                                        _character ==
                                                                SingingCharacter
                                                                    .afrangy
                                                            ? _dropDownValueA
                                                            : _dropDownValueC,
                                                    glab: glab,
                                                    sadr: sadr,
                                                    workerCost:
                                                        worker_costController
                                                            .text,
                                                    total: totalController.text,
                                                    code: codeController.text,
                                                    quantity:
                                                        quantityController.text,
                                                    type: _character ==
                                                            SingingCharacter
                                                                .afrangy
                                                        ? "افرنجي"
                                                        : "بلدي",
                                                    fyberType: categoryName,
                                                    deliveryTime:
                                                        selectedDeliveryDate,
                                                    ketfLength: double.tryParse(
                                                        ketfLengthController
                                                            .text),
                                                    komLength: double.tryParse(
                                                        komLengthController
                                                            .text),
                                                  );
                                                });

                                                product
                                                    .postProduct(
                                                        context, productsModel)
                                                    .then((value) {
                                                  print(value);
                                                  Customer? c = customerModel
                                                      .firstWhereOrNull(
                                                          (element) =>
                                                              element
                                                                  .userName ==
                                                              nameController
                                                                  .text);

                                                  if (c != null) {
                                                    Customer model = Customer(
                                                        userName: c?.userName,
                                                        address: c?.address!,
                                                        phone: c!.phone,
                                                        code: c.code,
                                                        length: c.length,
                                                        kabkLength:
                                                            c.kabkLength,
                                                        ketfLength:
                                                            c.ketfLength,
                                                        komLength: c.kabkLength,
                                                        neckLength:
                                                            c.neckLength,
                                                        sadrLength:
                                                            c.sadrLength,
                                                        handLength:
                                                            c.handLength,
                                                        customerAmount: show ==
                                                                true
                                                            ? c.customerAmount +
                                                                p
                                                            : c.customerAmount,
                                                        remainingAmount: c
                                                                .remainingAmount! +
                                                            double.tryParse(
                                                                remainingAmountController
                                                                    .text)!);
                                                    // if (show == true &&c.remainingAmount!=0) {
                                                    //   SmartDialog.show(
                                                    //       backDismiss: true,
                                                    //       onDismiss: () {},
                                                    //       builder: (context) {
                                                    //         return Container(
                                                    //           padding:
                                                    //               EdgeInsets.all(
                                                    //                   20),
                                                    //           width: 300,
                                                    //           height: 300,
                                                    //           decoration:
                                                    //               BoxDecoration(
                                                    //             color:
                                                    //                 buttonColor,
                                                    //             borderRadius:
                                                    //                 BorderRadius
                                                    //                     .circular(
                                                    //                         10),
                                                    //           ),
                                                    //           alignment: Alignment
                                                    //               .center,
                                                    //           child: Column(
                                                    //             mainAxisAlignment:
                                                    //                 MainAxisAlignment
                                                    //                     .spaceEvenly,
                                                    //             children: [
                                                    //               Text(
                                                    //                 ' يوجد ${p} مبلغ ذيادة',
                                                    //                 style: TextStyle(
                                                    //                     fontWeight:
                                                    //                         FontWeight
                                                    //                             .w500,
                                                    //                     fontSize:
                                                    //                         15,
                                                    //                     color: Colors
                                                    //                         .red),
                                                    //               ),
                                                    //               Text(
                                                    //                   "${model.userName} مديون ب ${c.remainingAmount!}"),
                                                    //               Text(
                                                    //                 'هل تريد خصم المبلغ الذيادة من المبلغ المديون به ؟ ',
                                                    //                 style: TextStyle(
                                                    //                     fontWeight:
                                                    //                         FontWeight
                                                    //                             .w500,
                                                    //                     fontSize:
                                                    //                         15,
                                                    //                     color: Colors
                                                    //                         .blue,),textAlign: TextAlign.center,
                                                    //               ),
                                                    //               Row(
                                                    //                 mainAxisAlignment:
                                                    //                     MainAxisAlignment
                                                    //                         .spaceBetween,
                                                    //                 children: [
                                                    //                   SizedBox(
                                                    //                       width:
                                                    //                           100,
                                                    //                       child: ElevatedButton(
                                                    //                           onPressed: () async {
                                                    //
                                                    //                               print(c.customerAmount);
                                                    //                               print(c.remainingAmount);
                                                    //
                                                    //                               if(p>=model.remainingAmount){
                                                    //                                 model.remainingAmount=0;
                                                    //                                 model.customerAmount=c.customerAmount+(model.remainingAmount-p);
                                                    //
                                                    //                               }else{
                                                    //                                 model.remainingAmount=model.remainingAmount-p;
                                                    //                                 model.customerAmount=c.customerAmount;
                                                    //                               }
                                                    //                               print(c.customerAmount);
                                                    //                               print(c.remainingAmount);
                                                    //                               setState(() {
                                                    //                             });
                                                    //                             CustomersCubit()
                                                    //                                 .updateCustomer2(
                                                    //                                 context,
                                                    //                                 model,
                                                    //                                 c.sId!).then((value) => Navigator.pop(context));
                                                    //                           },
                                                    //                           style: ButtonStyle(backgroundColor: MaterialStateProperty.all(accentCanvasColor)),
                                                    //                           child: Text('نعم', style: TextStyle(color: Colors.white)))),
                                                    //                   SizedBox(
                                                    //                       width:
                                                    //                           100,
                                                    //                       child: ElevatedButton(
                                                    //                           onPressed: () async {
                                                    //                             Navigator.pop(context);
                                                    //                           },
                                                    //                           style: ButtonStyle(backgroundColor: MaterialStateProperty.all(accentCanvasColor)),
                                                    //                           child: Text('لا', style: TextStyle(color: Colors.white)))),
                                                    //                 ],
                                                    //               )
                                                    //             ],
                                                    //           ),
                                                    //         );
                                                    //       });
                                                    // } else {
                                                    CustomersCubit()
                                                        .updateCustomer2(
                                                            context,
                                                            model,
                                                            c.sId!);
                                                  }

                                                  _formKey.currentState!
                                                      .reset();
                                                  nameController.clear();
                                                  addressController.clear();
                                                  totalController.text = "0.0";
                                                  amountPaidController.clear();
                                                  chestLengthController.clear();
                                                  k1LengthController.clear();
                                                  phoneController.clear();
                                                  detailsController.clear();
                                                  mLengthController.clear();
                                                  neckController.clear();
                                                  remainingAmountController
                                                      .clear();
                                                  prizeController.clear();
                                                  numDressesController.clear();
                                                  hand1LengthController.clear();
                                                  lengthController.clear();
                                                  setState(() {
                                                    ya2a = null;
                                                    gyb = null;
                                                    glab = null;
                                                    taqwera = null;
                                                    ganb = null;
                                                    kom = null;
                                                    taqwera = null;
                                                    sadr = null;
                                                    glab1 = false;
                                                    glab2 = false;
                                                    ya2a1 = false;
                                                    ya2a2 = false;
                                                    ya2a3 = false;
                                                    gyb1 = false;
                                                    gyb2 = false;
                                                    gyb3 = false;
                                                    ganb1 = false;
                                                    ganb2 = false;
                                                    taqwera1 = false;
                                                    taqwera2 = false;
                                                    taqwera3 = false;
                                                    kom1 = false;
                                                    kom2 = false;
                                                    kom3 = false;
                                                    kom4 = false;
                                                    kom5 = false;
                                                    kom6 = false;
                                                    kom7 = false;
                                                    kom8 = false;
                                                    kom9 = false;
                                                    kom10 = false;
                                                    sadr1 = false;
                                                    sadr2 = false;
                                                    sadr3 = false;
                                                    sadr4 = false;
                                                  });
                                                });
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          backgroundColor)),
                                              child: const Text(
                                                'اضافة',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ));
                                        }))),
                                SizedBox(
                                    width: 150,
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          final pdfFile =
                                              await PdfInvoiceApi.generate(
                                                  productsModel, null);

                                          await Printing.layoutPdf(
                                              onLayout: (PdfPageFormat
                                                      format) async =>
                                                  pdfFile.save());
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    backgroundColor)),
                                        child: Text('طباعة',
                                            style: TextStyle(
                                                color: Colors.white)))),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ])),
            ),
          ),
        ),
      ),
    );
  }

  var list1 = [
    ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      child: Image.asset("images/كلفة تامة بشليك.png",
          height: 300, width: 300, scale: 300, fit: BoxFit.contain),
    ),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset("images/كلفة تامة نص ياقة.png",
            height: 300, width: 300, scale: 300, fit: BoxFit.contain)),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset("images/جلابية قشرة.png",
            height: 300, width: 300, scale: 300, fit: BoxFit.contain)),
  ];
  var list2 = [
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset("images/الياقة بدون زراير.png",
            height: 300, width: 300, scale: 300, fit: BoxFit.contain)),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            child: Image.asset("images/الياقة زرار واحد.png",
                height: 300, width: 300, scale: 300, fit: BoxFit.contain))),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset("images/الياقة 2 زرار.png",
            height: 300, width: 300, scale: 300, fit: BoxFit.contain)),
  ];
  var list3 = [
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/جلاب 1 زرار.png",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      child: Image.asset("images/جلاب 2 زرار.png",
          height: 300, width: 300, scale: 300, fit: BoxFit.contain),
    ),
  ];
  var list4 = [
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset("images/جانب بشليك.png",
            height: 300, width: 300, scale: 300, fit: BoxFit.contain)),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset("images/جانب شق.png",
            height: 300, width: 300, scale: 300, fit: BoxFit.contain)),
  ];
  var list5 = [
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/جيب مربع.png",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/جيب مربع مثلث.png",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/جيب مدور.png",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
  ];
  var list6 = [
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/صدر عادي.png",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/صدر مخفي.png",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/صدر-عادي-مربع .png",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/صدر عادي لون في لون 2 خط.jpg",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/صدر لون في لون خط واحد.png",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
  ];
  var list7 = [
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/كم شعراوي علية زراير.jpg",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/كم بلدي.png",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/الكم سادة+بشليك لزق.png",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/الكم سادة.png",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/اساورة بشليك.png",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/اساورة كسره واحد.jpg",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/اساورة 2 كسرة.jpg",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/اساورة مربع بدون كسرة.png",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/اساورة مربع كسرة واحدة.jpg",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
    ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Image.asset(
          "images/اساورة مربع 2 كسرة.jpg",
          height: 300,
          width: 300,
          scale: 300,
          fit: BoxFit.contain,
        )),
  ];
}
