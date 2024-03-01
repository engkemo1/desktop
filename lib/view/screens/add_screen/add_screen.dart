import 'dart:math';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
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
  TextEditingController taqwera1LengthController=TextEditingController();
  TextEditingController taqwera2LengthController=TextEditingController();
  TextEditingController taqwera3LengthController=TextEditingController();

  TextEditingController badnLengthController1=TextEditingController();
  TextEditingController badnLengthController2=TextEditingController();
  TextEditingController badnLengthController3=TextEditingController();
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

  TextEditingController sadrController =TextEditingController();

  TextEditingController komController =TextEditingController();

  TextEditingController glabController =TextEditingController();

  TextEditingController ganbController =TextEditingController();

  TextEditingController gybController=TextEditingController();

  TextEditingController taqweraController =TextEditingController();

  TextEditingController ya2aController=TextEditingController();

  var categoryName
  ;



  @override
  void initState() {

    ProductCubit().getData().then((value) {var val=RandomDigits.getInteger(2).toString();
      setState(() {
        value.forEach((element) {
          if(          element.code==   val
          ){
            val==(RandomDigits.getInteger(2)+1).toString();
          }else{
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
                         child: Row(children: [   Expanded(
                             child: Padding(
                               padding: const EdgeInsets.only(left:8.0,right: 8),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   const Text(
                                     'وسع اليد',
                                     style: TextStyle(
                                         color: Colors.white70,
                                         fontWeight: FontWeight.w500,
                                         fontSize: 15),
                                   ),
                                   Container(decoration: BoxDecoration(
                                       color:buttonColor,
                                       borderRadius: BorderRadius.circular(10)
                                   ),
                                     child: Column(
                                       children: [

                                         TextFormField(                                  controller: hand1LengthController,
                                           keyboardType: TextInputType.number,
                                           textAlign: TextAlign.center,

                                           decoration: InputDecoration(
                                             contentPadding: EdgeInsets.all(10),
                                             hintText: 'ادخل المقاس',

                                             hintStyle: TextStyle(
                                                 fontSize: 14,
                                                 fontWeight: FontWeight.bold),
                                           ),
                                         ),
                                         TextFormField(                                  controller: hand2LengthController,
                                           keyboardType: TextInputType.number,
                                           textAlign: TextAlign.center,

                                           decoration: InputDecoration(
                                             hintText: 'ادخل  المقاس',
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
                                 padding: const EdgeInsets.only(left:8.0,right: 8),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     const Text(
                                       'طول الكبك',
                                       style: TextStyle(
                                           color: Colors.white70,
                                           fontWeight: FontWeight.w500,
                                           fontSize: 15),
                                     ),
                                     Container(decoration: BoxDecoration(
                                         color:buttonColor,
                                         borderRadius: BorderRadius.circular(10)
                                     ),
                                       child: Column(
                                         children: [

                                           TextFormField(                                  controller: k1LengthController,
                                             keyboardType: TextInputType.number,
                                             textAlign: TextAlign.center,

                                             decoration: InputDecoration(
                                               hintText: 'ادخل المقاس ',
                                               contentPadding: EdgeInsets.all(10),

                                               hintStyle: TextStyle(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.bold),
                                             ),
                                           ),
                                           TextFormField(                                  controller: k2LengthController,
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
                                 padding: const EdgeInsets.only(left:8.0,right: 8),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     const Text(
                                       'سقوط التقويرة',
                                       style: TextStyle(
                                           color: Colors.white70,
                                           fontWeight: FontWeight.w500,
                                           fontSize: 12),
                                     ),
                                     SizedBox(height: 5,),
                                     Container(decoration: BoxDecoration(
                                         color:buttonColor,
                                         borderRadius: BorderRadius.circular(10)
                                     ),
                                       child: Column(
                                         children: [

                                           TextFormField(                                  controller: taqwera1LengthController,
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
                                 padding: const EdgeInsets.only(left:8.0,right: 8),
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
                                     SizedBox(height: 5,),

                                     Container(decoration: BoxDecoration(
                                         color:buttonColor,
                                         borderRadius: BorderRadius.circular(10)
                                     ),
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
                                           TextFormField(                                  controller: badnLengthController2,
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
                                           TextFormField(                                  controller: badnLengthController3,
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
                               )),],),
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
                                        totalTypeController.text="0.0";
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
                                                (prizeController.text.isEmpty
                                                    ? 0.0
                                                    : double.parse(prizeController.text)) +
                                                double.parse(
                                                    totalTypeController.text))
                                                .toString();
                                            remainingAmountController.text =
                                                (double.parse(
                                                    totalController.text.isEmpty?"0.0": totalController.text)
                                                    -
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
                                                : double.parse(prizeController.text)) +
                                            double.parse(
                                                totalTypeController.text))
                                            .toString();
                                        remainingAmountController.text = (double.parse(
                                            totalController.text.isEmpty?"0.0":  totalController.text)
                                            -
                                            (amountPaidController
                                                .text.isNotEmpty
                                                ? double.parse(
                                                amountPaidController
                                                    .text)
                                                : 0.0))
                                            .toString();


                                        setState(() {

});

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
                                  enable: false   ,
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
                                          remainingAmountController.text = (double.parse(
                                              totalController.text)
                                               -
                                              (amountPaidController
                                                  .text.isNotEmpty
                                                  ? double.parse(
                                                  amountPaidController
                                                      .text)
                                                  : 0.0)).abs()
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
                                  child: _character == SingingCharacter.afrangy
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
                                                      BorderRadius.circular(20),
                                                  color: accentCanvasColor
                                                      .withOpacity(0.8)),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                      onPressed: () =>
                                                          buttonCarouselController4
                                                              .nextPage(
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
                                                                  (index, c) {

                                                              },
                                                              autoPlay: false,
                                                              enlargeCenterPage:
                                                                  true,
                                                              viewportFraction:
                                                                  0.9,
                                                              aspectRatio: 2.0,
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
                                              width: 400,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: accentCanvasColor
                                                      .withOpacity(0.8)),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                      onPressed: () =>
                                                          buttonCarouselController5
                                                              .nextPage(
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
                                                                kom = index == 0
                                                                    ? "كم شعراوي علية زراير"
                                                                    : index == 1
                                                                        ? "كم بلدي"
                                                                        : index ==
                                                                                2
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
                                                              aspectRatio: 2.0,
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
                                                      BorderRadius.circular(20),
                                                  color: accentCanvasColor
                                                      .withOpacity(0.8)),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: IconButton(
                                                      onPressed: () =>
                                                          buttonCarouselController6
                                                              .nextPage(
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
                                                              aspectRatio: 1.0,
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
                                              width: 400,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: accentCanvasColor
                                                      .withOpacity(0.8)),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                      onPressed: () =>
                                                          buttonCarouselController7
                                                              .nextPage(
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
                                                              aspectRatio: 2.0,
                                                              initialPage: 2,
                                                            )),
                                                        CustomTextField(
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
                                                      BorderRadius.circular(20),
                                                  color: accentCanvasColor
                                                      .withOpacity(0.8)),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                      onPressed: () =>
                                                          buttonCarouselController3
                                                              .nextPage(
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
                                                                gyb = index == 0
                                                                    ? "جيب مربع"
                                                                    : index == 1
                                                                        ? "جيب مربع مثلث"
                                                                        : "جيب مدور";
                                                                print(gyb);
                                                              },
                                                              autoPlay: false,
                                                              enlargeCenterPage:
                                                                  true,
                                                              viewportFraction:
                                                                  0.9,
                                                              aspectRatio: 2.0,
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
                                                      BorderRadius.circular(20),
                                                  color: accentCanvasColor
                                                      .withOpacity(0.8)),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                      onPressed: () =>
                                                          buttonCarouselController1
                                                              .nextPage(
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
                                                                    : index == 1
                                                                        ? "كلفة تامة نص ياقة"
                                                                        : index ==
                                                                                2
                                                                            ? "جلابية قشرة"
                                                                            : "اسطنبولي";
                                                                print(taqwera);
                                                              },
                                                              autoPlay: false,
                                                              enlargeCenterPage:
                                                                  true,
                                                              viewportFraction:
                                                                  0.9,
                                                              aspectRatio: 2.0,
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
                                                      BorderRadius.circular(20),
                                                  color: accentCanvasColor
                                                      .withOpacity(0.8)),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                      onPressed: () =>
                                                          buttonCarouselController2
                                                              .nextPage(
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
                                                                    : index == 1
                                                                        ? "الياقة زرار واحد"
                                                                        : "الياقة 2 زرار";
                                                                print(ya2a);
                                                              },
                                                              autoPlay: false,
                                                              enlargeCenterPage:
                                                                  true,
                                                              viewportFraction:
                                                                  0.9,
                                                              aspectRatio: 2.0,
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
                                                  name: nameController.text,
                                                  date: _selectedDate,
                                                  length: double.tryParse(
                                                      lengthController.text),
                                                  badnSize1:  double.tryParse(badnLengthController1.text),
                                                  badnSize2: double.tryParse( badnLengthController2.text),
                                                  badnSize3: double.tryParse(badnLengthController3.text),
                                                  droppTaqwera1: double.tryParse(taqwera1LengthController.text),
                                                  droppTaqwera2: double.tryParse(taqwera2LengthController.text),
                                                  droppTaqwera3: double.tryParse(taqwera3LengthController.text),

                                                  hand2Length: double.tryParse(hand2LengthController.text),
                                                  k2Length: double.tryParse(k2LengthController.text),
                                                  taqweraSize:double.tryParse(taqweraController.text),
                                                  ganbSize: double.tryParse(ganbController.text),
                                                  glabSize: double.tryParse(glabController.text),
                                                  komSize: double.tryParse(komController.text),
                                                  yaqaSize: double.tryParse(ya2aController.text),
                                                  gaybSize:double.tryParse(gybController.text) ,
                                                  sadrSize:double.tryParse(sadrController.text) ,
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
                                                      customerAmount:show == true?c.customerAmount+p:c.customerAmount,
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

                                                _formKey.currentState!.reset();
                                                nameController.clear();
                                                addressController.clear();
                                                totalController.text="0.0";
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

  Directionality Mobile() {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'images/very big logo.svg',
                        width: 100,
                      ),
                      const Text(
                        "اضافة فاتورة",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'الاسم',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          CustomTextField(
                            prefix: Icon(Icons.add_reaction_outlined),
                            suffix: PopupMenuButton(
                              onSelected: (val) {
                                Customer? c = customerModel.firstWhereOrNull(
                                    (element) => element.userName == val);

                                setState(() {
                                  nameController.text = val.toString();
                                  addressController.text = c!.address!;
                                  phoneController.text = c.phone!;
                                });
                              },
                              child: const Icon(Icons.arrow_drop_down),
                              itemBuilder: (context) => customer
                                  .map((c) =>
                                      PopupMenuItem(value: c, child: Text(c)))
                                  .toList(),
                            ),
                            controller: nameController,
                            isFormField: true,
                            hintText: 'ادخل اسم المشتري',
                          )
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'رقم الهاتف',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        CustomTextField(
                          prefix: Icon(Icons.phone_android),
                          controller: phoneController,
                          textInputType: TextInputType.number,
                          hintText: 'ادخل رقم الهاتف',
                          isFormField: true,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'العنوان',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'القيمة',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        CustomTextField(
                          prefix: Icon(Icons.attach_money),
                          controller: prizeController,
                          textInputType: TextInputType.number,
                          hintText: 'ادخل القيمة',
                          isFormField: true,
                        ),
                      ],
                    ),
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
                              'المبلغ المدفوع',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            CustomTextField(
                              prefix: Icon(Icons.attach_money),
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
                                  fontWeight: FontWeight.w500, fontSize: 15),
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
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'التاريخ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 1))
                              // changes position of shadow
                            ],
                          ),
                          child: TextField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              border: InputBorder.none,

                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              isDense: true,
                              fillColor: Colors.black12,
                              enabled: false,
                              hintText: _selectedDate.toString(),
                              labelText: _selectedDate.toString(),
                              labelStyle: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              // iconOrdrop: 'button',
                              prefixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.date_range,
                                    color: accentCanvasColor,
                                  ),
                                  onPressed: () {
                                    _selectDate(context);
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Text(
                        "     المقاسات    ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Expanded(child: Divider()),
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
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            CustomTextField(
                              controller: numDressesController,
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
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            CustomTextField(
                              controller: lengthController,
                              textInputType: TextInputType.number,
                              hintText: 'ادخل الطول',
                              isFormField: true,
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
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'الكتف',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            CustomTextField(
                              controller: ketfLengthController,
                              isFormField: true,
                              hintText: 'ادخل الطول ',
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
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            CustomTextField(
                              controller: komLengthController,
                              textInputType: TextInputType.number,
                              hintText: 'ادخل الطول',
                              isFormField: true,
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
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'وسع الصدر',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            CustomTextField(
                              controller: chestLengthController,
                              textInputType: TextInputType.streetAddress,
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
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            CustomTextField(
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
                              'وسع اليد',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            CustomTextField(
                              controller: hand1LengthController,
                              textInputType: TextInputType.number,
                              isFormField: true,
                              hintText: ' ادخل وسع اليد ',
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
                              'طول الكيك ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            CustomTextField(
                              controller: k1LengthController,
                              textInputType: TextInputType.number,
                              hintText: 'ادخل طول الكيك',
                              isFormField: true,
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
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'مفصل',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            CustomTextField(
                              controller: mLengthController,
                              textInputType: TextInputType.streetAddress,
                              isFormField: true,
                              hintText: ' المفصل ',
                            ),
                          ],
                        ),
                      )),
                      const Spacer()
                    ],
                  ),
                  const Divider(),
                  ExpansionTile(
                    expandedAlignment: Alignment.center,
                    expandedCrossAxisAlignment: CrossAxisAlignment.center,
                    shape: Border(),
                    collapsedBackgroundColor:
                        glab == null ? null : Colors.blue.withOpacity(0.2),
                    initiallyExpanded: controller1,
                    key: GlobalKey(),
                    leading: glab == null
                        ? null
                        : const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                          ),
                    onExpansionChanged: (val) {
                      setState(() {
                        controller1 = val;
                        controller2 = false;
                        controller3 = false;
                        controller4 = false;
                        controller5 = false;
                        controller6 = false;
                        controller7 = false;
// update here on change
                      });
                    },
                    title: Column(children: [
                      glab == null
                          ? SvgPicture.asset(
                              'images/جلاب 2 زرار.svg',
                              height: 80,
                            )
                          : SvgPicture.asset(
                              'images/${glab}.svg',
                              height: 80,
                            ),
                      Text(glab == null ? 'جلاب' : glab!),
                    ]),
                    children: [
                      Wrap(
                        children: [
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      glab1 = newValue;
                                      glab2 = false;
                                    });
                                    setState(() {
                                      glab =
                                          glab1 == true ? "جلاب 2 زرار" : null;
                                    });
                                  },
                                  selected: glab1,
                                  child: SvgPicture.asset(
                                    "images/جلاب 2 زرار.svg",
                                    height: 60,
                                  ),
                                ),
                                Text('جلاب 2 زرار')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      glab2 = newValue;
                                      glab1 = false;
                                    });
                                    setState(() {
                                      glab =
                                          glab2 == true ? "جلاب 1 زرار" : null;
                                    });
                                  },
                                  selected: glab2,
                                  child: SvgPicture.asset(
                                    "images/جلاب 1 زرار.jpg",
                                    height: 60,
                                  ),
                                ),
                                Text('جلاب 1 زرار')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  ExpansionTile(
                    expandedAlignment: Alignment.center,
                    expandedCrossAxisAlignment: CrossAxisAlignment.center,
                    collapsedBackgroundColor:
                        ya2a == null ? null : Colors.blue.withOpacity(0.2),
                    leading: ya2a == null
                        ? null
                        : Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                          ),
                    key: GlobalKey(),
                    initiallyExpanded: controller2,
                    onExpansionChanged: (val) {
                      setState(() {
                        controller2 = val;
                        controller1 = false;
                        controller3 = false;
                        controller4 = false;
                        controller5 = false;
                        controller6 = false;
                        controller7 = false;
// update here on change
                      });
                    },
                    shape: Border(),
                    title: Column(children: [
                      SvgPicture.asset(
                          ya2a == null
                              ? 'images/الياقة بدون زراير.svg'
                              : 'images/${ya2a}.svg',
                          height: 80,
                          semanticsLabel: 'Acme Logo'),
                      Text(ya2a == null ? 'الياقة' : ya2a!),
                    ]),
                    children: [
                      Wrap(
                        children: [
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      ya2a1 = newValue;
                                      ya2a3 = false;
                                      ya2a2 = false;
                                    });
                                    setState(() {
                                      ya2a = ya2a1 == true
                                          ? "الياقة بدون زراير"
                                          : null;
                                    });
                                  },
                                  selected: ya2a1,
                                  child: SvgPicture.asset(
                                    "images/الياقة بدون زراير.svg",
                                    height: 60,
                                  ),
                                ),
                                Text('الياقة بدون زراير')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      ya2a2 = newValue;
                                      ya2a1 = false;
                                      ya2a3 = false;
                                    });
                                    setState(() {
                                      ya2a = ya2a2 == true
                                          ? "الياقة 2 زرار"
                                          : null;
                                    });
                                  },
                                  selected: ya2a2,
                                  child: SvgPicture.asset(
                                    "images/الياقة 2 زرار.svg",
                                    height: 60,
                                  ),
                                ),
                                Text('الياقة 2 زرار')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      ya2a3 = newValue;
                                      ya2a1 = false;
                                      ya2a2 = false;
                                    });
                                    setState(() {
                                      ya2a = ya2a3 == true
                                          ? "الياقة زرار واحد"
                                          : null;
                                    });
                                  },
                                  selected: ya2a3,
                                  child: SvgPicture.asset(
                                    "images/الياقة زرار واحد.svg",
                                    height: 60,
                                  ),
                                ),
                                Text('الياقة زرار واحد')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  ExpansionTile(
                    expandedAlignment: Alignment.center,
                    expandedCrossAxisAlignment: CrossAxisAlignment.center,
                    collapsedBackgroundColor:
                        gyb == null ? null : Colors.blue.withOpacity(0.2),
                    leading: gyb == null
                        ? null
                        : Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                          ),
                    key: GlobalKey(),
                    initiallyExpanded: controller3,
                    onExpansionChanged: (val) {
                      setState(() {
                        controller3 = val;
                        controller1 = false;
                        controller2 = false;
                        controller4 = false;
                        controller5 = false;
                        controller6 = false;
                        controller7 = false;
// update here on change
                      });
                    },
                    shape: Border(),
                    title: Column(children: [
                      SvgPicture.asset(
                          gyb == null
                              ? 'images/جيب مدور.svg'
                              : 'images/${gyb}.svg',
                          height: 80,
                          semanticsLabel: 'Acme Logo'),
                      Text(gyb == null ? 'الجيب' : gyb!),
                    ]),
                    children: [
                      Wrap(
                        children: [
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      gyb1 = newValue;
                                      gyb2 = false;
                                      gyb3 = false;
                                    });
                                    setState(() {
                                      gyb = gyb1 == true ? "جيب مدور" : null;
                                    });
                                  },
                                  selected: gyb1,
                                  child: SvgPicture.asset(
                                    "images/جيب مدور.svg",
                                    height: 60,
                                  ),
                                ),
                                Text('جيب مدور')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      gyb2 = newValue;
                                      gyb1 = false;
                                      gyb3 = false;
                                    });
                                    setState(() {
                                      gyb =
                                          gyb2 == true ? "جيب مربع مثلث" : null;
                                    });
                                  },
                                  selected: gyb2,
                                  child: SvgPicture.asset(
                                    "images/جيب مربع مثلث.svg",
                                    height: 60,
                                  ),
                                ),
                                Text('جيب مربع مثلث')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      gyb3 = newValue;
                                      gyb1 = false;
                                      gyb2 = false;
                                    });
                                    setState(() {
                                      gyb = gyb3 == true ? "جيب مربع" : null;
                                    });
                                  },
                                  selected: gyb3,
                                  child: SvgPicture.asset(
                                    "images/جيب مربع.svg",
                                    height: 60,
                                  ),
                                ),
                                Text('جيب مربع')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  ExpansionTile(
                    expandedAlignment: Alignment.center,
                    expandedCrossAxisAlignment: CrossAxisAlignment.center,
                    key: GlobalKey(),
                    collapsedBackgroundColor:
                        ganb == null ? null : Colors.blue.withOpacity(0.2),
                    leading: ganb == null
                        ? null
                        : Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                          ),
                    initiallyExpanded: controller4,
                    onExpansionChanged: (val) {
                      setState(() {
                        controller4 = val;
                        controller1 = false;
                        controller2 = false;
                        controller3 = false;
                        controller5 = false;
                        controller6 = false;

                        controller7 = false;
// update here on change
                      });
                    },
                    shape: Border(),
                    title: Column(children: [
                      SvgPicture.asset(
                          ganb == null ? 'images/1.svg' : 'images/${ganb}.svg',
                          height: 80,
                          semanticsLabel: 'Acme Logo'),
                      Text(ganb == null ? 'الجانب' : ganb!),
                    ]),
                    children: [
                      Wrap(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      ganb1 = newValue;
                                      ganb2 = false;
                                    });
                                    setState(() {
                                      ganb = ganb1 == true ? "جانب شق" : null;
                                    });
                                  },
                                  selected: ganb1,
                                  child: SvgPicture.asset(
                                    "images/جانب شق.svg",
                                    height: 60,
                                  ),
                                ),
                                Text('جانب شق')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      ganb2 = newValue;
                                      ganb1 = false;
                                    });
                                    setState(() {
                                      ganb =
                                          ganb2 == true ? "جانب بشليك" : null;
                                    });
                                  },
                                  selected: ganb2,
                                  child: SvgPicture.asset(
                                    "images/جانب بشليك.svg",
                                    height: 60,
                                  ),
                                ),
                                Text('جانب بشليك')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  ExpansionTile(
                    expandedAlignment: Alignment.center,
                    expandedCrossAxisAlignment: CrossAxisAlignment.center,
                    key: GlobalKey(),
                    collapsedBackgroundColor:
                        taqwera == null ? null : Colors.blue.withOpacity(0.2),
                    leading: taqwera == null
                        ? null
                        : Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                          ),
                    initiallyExpanded: controller5,
                    onExpansionChanged: (val) {
                      setState(() {
                        controller5 = val;
                        controller1 = false;
                        controller2 = false;
                        controller4 = false;
                        controller3 = false;
                        controller6 = false;
                        controller7 = false;
// update here on change
                      });
                    },
                    shape: Border(),
                    title: Column(children: [
                      SvgPicture.asset(
                          taqwera == null
                              ? 'images/كلفة تامة بشليك.svg'
                              : 'images/${taqwera}.svg',
                          height: 80,
                          semanticsLabel: 'Acme Logo'),
                      Text(taqwera == null ? 'التقويره' : taqwera!),
                    ]),
                    children: [
                      Wrap(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      taqwera1 = newValue;
                                      taqwera2 = false;
                                      taqwera3 = false;
                                    });
                                    setState(() {
                                      taqwera = taqwera1 == true
                                          ? "كلفة تامة بشليك"
                                          : null;
                                    });
                                  },
                                  selected: taqwera1,
                                  child: SvgPicture.asset(
                                    "images/كلفة تامة بشليك.svg",
                                    height: 60,
                                  ),
                                ),
                                Text('كلفة تامة بشليك')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      taqwera2 = newValue;
                                      taqwera1 = false;
                                      taqwera3 = false;
                                    });
                                    setState(() {
                                      taqwera = taqwera2 == true
                                          ? "كلفة تامة نص ياقة"
                                          : null;
                                    });
                                  },
                                  selected: taqwera2,
                                  child: SvgPicture.asset(
                                    "images/كلفة تامة نص ياقة.svg",
                                    height: 60,
                                  ),
                                ),
                                const Text('كلفة تامة نص ياقة')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      taqwera3 = newValue;
                                      taqwera2 = false;
                                      taqwera1 = false;
                                    });
                                    setState(() {
                                      taqwera = taqwera3 == true
                                          ? "جلابية قشرة"
                                          : null;
                                    });
                                  },
                                  selected: taqwera3,
                                  child: SvgPicture.asset(
                                    "images/جلابية قشرة.svg",
                                    height: 60,
                                  ),
                                ),
                                Text('جلابية قشرة')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  ExpansionTile(
                    expandedAlignment: Alignment.center,
                    expandedCrossAxisAlignment: CrossAxisAlignment.center,
                    key: GlobalKey(),
                    collapsedBackgroundColor:
                        sadr == null ? null : Colors.blue.withOpacity(0.2),
                    leading: sadr == null
                        ? null
                        : Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                          ),
                    initiallyExpanded: controller6,
                    onExpansionChanged: (val) {
                      setState(() {
                        controller6 = val;
                        controller1 = false;
                        controller2 = false;
                        controller3 = false;
                        controller4 = false;
                        controller5 = false;
                        controller7 = false;
// update here on change
                      });
                    },
                    shape: Border(),
                    title: Column(children: [
                      SvgPicture.asset(
                          sadr == null
                              ? 'images/صدر مخفي.svg'
                              : 'images/${sadr}.svg',
                          height: 80,
                          semanticsLabel: 'Acme Logo'),
                      Text(sadr == null ? 'الصدر' : sadr!),
                    ]),
                    children: [
                      Wrap(
                        children: [
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      sadr1 = newValue;
                                      sadr2 = false;
                                      sadr3 = false;
                                      sadr4 = false;
                                    });
                                    setState(() {
                                      sadr = sadr1 == true
                                          ? "صدر لون في لون خط واحد"
                                          : null;
                                    });
                                  },
                                  selected: sadr1,
                                  child: SvgPicture.asset(
                                    "images/صدر عادي.svg",
                                    height: 60,
                                  ),
                                ),
                                const Text(
                                  'صدر لون في لون خط واحد',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      sadr2 = newValue;
                                      sadr1 = false;
                                      sadr3 = false;
                                      sadr4 = false;
                                    });
                                    setState(() {
                                      sadr = sadr2 == true
                                          ? "صدر عادي لون في لون 2 خط"
                                          : null;
                                    });
                                  },
                                  selected: sadr2,
                                  child: SvgPicture.asset(
                                    "images/صدر عادي لون في لون 2 خط.svg",
                                    height: 60,
                                  ),
                                ),
                                Text(
                                  'صدر عادي لون في لون 2 خط',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      sadr3 = newValue;
                                      sadr2 = false;
                                      sadr1 = false;
                                      sadr4 = false;
                                    });
                                    setState(() {
                                      sadr = sadr3 == true ? "صدر عادي" : null;
                                    });
                                  },
                                  selected: sadr3,
                                  child: SvgPicture.asset(
                                    "images/صدر عادي.svg",
                                    height: 60,
                                  ),
                                ),
                                Text('صدر عادي')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      sadr4 = newValue;
                                      sadr1 = false;
                                      sadr3 = false;
                                      sadr2 = false;
                                    });
                                    setState(() {
                                      sadr = sadr4 == true ? "صدر مخفي" : null;
                                    });
                                  },
                                  selected: sadr4,
                                  child: SvgPicture.asset(
                                    "images/صدر مخفي.svg",
                                    height: 60,
                                  ),
                                ),
                                Text('صدر مخفي')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  ExpansionTile(
                    expandedAlignment: Alignment.center,
                    expandedCrossAxisAlignment: CrossAxisAlignment.center,
                    key: GlobalKey(),
                    collapsedBackgroundColor:
                        kom == null ? null : Colors.blue.withOpacity(0.2),
                    leading: kom == null
                        ? null
                        : Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                          ),
                    initiallyExpanded: controller7,
                    onExpansionChanged: (val) {
                      setState(() {
                        controller1 = false;
                        controller2 = false;
                        controller3 = false;
                        controller4 = false;
                        controller5 = false;
                        controller6 = false;

                        controller7 = val; // update here on change
                      });
                    },
                    shape: Border(),
                    title: Column(children: [
                      SvgPicture.asset(
                          kom == null
                              ? 'images/كم بلدي.svg'
                              : 'images/${kom}.svg',
                          height: 80,
                          semanticsLabel: 'Acme Logo'),
                      Text(kom == null ? 'الكم' : kom!),
                    ]),
                    children: [
                      Wrap(
                        children: [
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      kom1 = newValue;
                                      kom2 = false;
                                      kom7 = false;
                                      kom3 = false;
                                      kom4 = false;
                                      kom9 = false;
                                      kom5 = false;
                                      kom10 = false;
                                      kom6 = false;
                                      kom8 = false;
                                    });
                                    setState(() {
                                      kom = kom1 == true
                                          ? "اساورة مربع كسرة واحدة"
                                          : null;
                                    });
                                  },
                                  selected: kom1,
                                  child: SvgPicture.asset(
                                    "images/اساورة مربع كسرة واحدة.svg",
                                    height: 60,
                                  ),
                                ),
                                Text(
                                  'اساورة مربع كسرة واحدة',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      kom2 = newValue;
                                      kom3 = false;
                                      kom1 = false;
                                      kom7 = false;
                                      kom4 = false;
                                      kom9 = false;
                                      kom5 = false;
                                      kom10 = false;
                                      kom6 = false;
                                      kom8 = false;
                                    });
                                    setState(() {
                                      kom = kom2 == true
                                          ? "اساورة مربع 2 كسرة"
                                          : null;
                                    });
                                  },
                                  selected: kom2,
                                  child: SvgPicture.asset(
                                    "images/اساورة مربع 2 كسرة.svg",
                                    height: 60,
                                  ),
                                ),
                                Text(
                                  'اساورة مربع 2 كسرة',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      kom3 = newValue;
                                      kom2 = false;
                                      kom7 = false;
                                      kom1 = false;
                                      kom4 = false;
                                      kom9 = false;
                                      kom5 = false;
                                      kom10 = false;
                                      kom6 = false;
                                      kom8 = false;
                                    });
                                    setState(() {
                                      kom = kom3 == true
                                          ? "اساورة مربع بدون كسرة"
                                          : null;
                                    });
                                  },
                                  selected: kom3,
                                  child: SvgPicture.asset(
                                    "images/اساورة مربع بدون كسرة.svg",
                                    height: 60,
                                  ),
                                ),
                                Text(
                                  'اساورة مربع بدون كسرة',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      kom4 = newValue;
                                      kom2 = false;
                                      kom3 = false;
                                      kom1 = false;
                                      kom7 = false;
                                      kom9 = false;
                                      kom5 = false;
                                      kom10 = false;
                                      kom6 = false;
                                      kom8 = false;
                                    });
                                    setState(() {
                                      kom =
                                          kom4 == true ? "اساورة 2 كسرة" : null;
                                    });
                                  },
                                  selected: kom4,
                                  child: SvgPicture.asset(
                                    "images/اساورة مربع 2 كسرة.svg",
                                    height: 70,
                                  ),
                                ),
                                Text(
                                  'اساورة 2 كسرة',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      kom5 = newValue;
                                      kom7 = false;
                                      kom3 = false;
                                      kom1 = false;
                                      kom4 = false;
                                      kom9 = false;
                                      kom2 = false;
                                      kom10 = false;
                                      kom6 = false;
                                      kom8 = false;
                                    });
                                    setState(() {
                                      kom = kom5 == true
                                          ? "اساورة كسرة واحد"
                                          : null;
                                    });
                                  },
                                  selected: kom5,
                                  child: SvgPicture.asset(
                                    "images/اساورة كسرة واحد.svg",
                                    height: 60,
                                  ),
                                ),
                                Text(
                                  'اساورة كسرة واحد',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      kom6 = newValue;
                                      kom7 = false;
                                      kom3 = false;
                                      kom1 = false;
                                      kom4 = false;
                                      kom9 = false;
                                      kom5 = false;
                                      kom10 = false;
                                      kom2 = false;
                                      kom8 = false;
                                    });
                                    setState(() {
                                      kom =
                                          kom6 == true ? "اساورة بشليك" : null;
                                    });
                                  },
                                  selected: kom6,
                                  child: SvgPicture.asset(
                                    "images/اساورة بشليك.svg",
                                    height: 60,
                                  ),
                                ),
                                Text(
                                  "اساورة بشليك",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      kom7 = newValue;
                                      kom2 = false;
                                      kom3 = false;
                                      kom1 = false;
                                      kom4 = false;
                                      kom9 = false;
                                      kom5 = false;
                                      kom10 = false;
                                      kom6 = false;
                                      kom8 = false;
                                    });
                                    setState(() {
                                      kom = kom7 == true ? "الكم سادة" : null;
                                    });
                                  },
                                  selected: kom7,
                                  child: SvgPicture.asset(
                                    "images/الكم سادة.svg",
                                    height: 60,
                                  ),
                                ),
                                Text(
                                  "الكم سادة",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      kom8 = newValue;
                                      kom3 = false;
                                      kom7 = false;
                                      kom1 = false;
                                      kom4 = false;
                                      kom9 = false;
                                      kom5 = false;
                                      kom10 = false;
                                      kom6 = false;
                                      kom2 = false;
                                    });
                                    setState(() {
                                      kom = kom8 == true
                                          ? "الكم سادة+بشليك لزق"
                                          : null;
                                    });
                                  },
                                  selected: kom8,
                                  child: SvgPicture.asset(
                                    "images/الكم سادة+بشليك لزق.svg",
                                    height: 60,
                                  ),
                                ),
                                Text(
                                  "الكم سادة+بشليك لزق",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      kom9 = newValue;
                                      kom3 = false;
                                      kom7 = false;
                                      kom1 = false;
                                      kom4 = false;
                                      kom2 = false;
                                      kom5 = false;
                                      kom10 = false;
                                      kom6 = false;
                                      kom8 = false;
                                    });
                                    setState(() {
                                      kom = kom9 == true ? "كم بلدي" : null;
                                    });
                                  },
                                  selected: kom9,
                                  child: SvgPicture.asset(
                                    "images/كم بلدي.svg",
                                    height: 60,
                                  ),
                                ),
                                Text(
                                  'كم بلدي',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 120,
                            child: Column(
                              children: [
                                SelectableContainer(
                                  onValueChanged: (newValue) {
                                    setState(() {
                                      kom10 = newValue;
                                      kom3 = false;
                                      kom7 = false;
                                      kom1 = false;
                                      kom4 = false;
                                      kom9 = false;
                                      kom5 = false;
                                      kom2 = false;
                                      kom6 = false;
                                      kom8 = false;
                                    });
                                    setState(() {
                                      kom = kom10 == true
                                          ? "كم شعراوي علية زراير"
                                          : null;
                                    });
                                  },
                                  selected: kom10,
                                  child: SvgPicture.asset(
                                    "images/كم شعراوي علية زراير.svg",
                                    height: 60,
                                  ),
                                ),
                                Text(
                                  'كم شعراوي علية زراير',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ملاحظات',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        CustomTextField(
                          controller: detailsController,
                          maxLine: 4,
                          textInputType: TextInputType.text,
                          isFormField: true,
                          hintText: '  ',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  productsModel = ProductsModel(
                                    name: nameController.text,
                                    date: _selectedDate,
                                    length:
                                        double.tryParse(lengthController.text),
                                    address: addressController.text,
                                    amountPaid: double.tryParse(
                                        amountPaidController.text),
                                    chestLength: double.tryParse(
                                        chestLengthController.text),
                                    createdAt: DateTime.now().toString(),
                                    details: detailsController.text,
                                    handLength: double.tryParse(
                                        hand1LengthController.text),
                                    image: "ds",
                                    kLength:
                                        double.tryParse(k1LengthController.text),
                                    mLength:
                                        double.tryParse(mLengthController.text),
                                    numDresses: double.tryParse(
                                        numDressesController.text),
                                    neck: double.tryParse(neckController.text),
                                    phone: phoneController.text,
                                    prize:
                                        double.tryParse(prizeController.text),
                                    remainingAmount: double.tryParse(
                                        remainingAmountController.text),
                                    ganb: ganb,
                                    gayb: gyb,
                                    taqwera: taqwera,
                                    yaqa: ya2a,
                                    kom: kom,
                                    glab: glab,
                                    sadr: sadr,
                                    ketfLength: double.tryParse(
                                        ketfLengthController.text),
                                    komLength: double.tryParse(
                                        komLengthController.text),
                                  );
                                });

                                ProductCubit()
                                    .postProduct(context, productsModel)
                                    .then((value) {
                                  Customer? c = customerModel.firstWhereOrNull(
                                      (element) =>
                                          element.userName ==
                                          nameController.text);

                                  if (c != null) {
                                    Customer model = Customer(
                                        userName: c?.userName,
                                        address: c?.address!,
                                        phone: c!.phone,
                                        remainingAmount: c.remainingAmount! +
                                            int.tryParse(
                                                remainingAmountController
                                                    .text)!);

                                    CustomersCubit().updateCustomer2(
                                        context, model, c.sId!);
                                  }
                                  _formKey.currentState!.reset();
                                  nameController.clear();
                                  addressController.clear();
                                  amountPaidController.clear();
                                  chestLengthController.clear();
                                  k1LengthController.clear();
                                  phoneController.clear();
                                  detailsController.clear();
                                  mLengthController.clear();
                                  neckController.clear();
                                  remainingAmountController.clear();
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
                              child: Text(
                                'اضافة',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      accentCanvasColor)))),
                      SizedBox(
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text('طباعة',
                                  style: TextStyle(color: Colors.white)),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      accentCanvasColor)))),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  var list1 = [
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/كلفة تامة بشليك.svg",
            height: 80,
          ),
          Text(
            'كلفة تامة بشليك',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/كلفة تامة نص ياقة.svg",
            height: 80,
          ),
          const Text(
            'كلفة تامة نص ياقة',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/جلابية قشرة.svg",
            height: 80,
          ),
          Text(
            'جلابية قشرة',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Center(
          child: Text(
        'اسطنبولي',
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      )),
    ),
  ];
  var list2 = [
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/الياقة بدون زراير.svg",
            height: 80,
          ),
          Text(
            'الياقة بدون زراير',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/الياقة زرار واحد.svg",
            height: 80,
          ),
          Text(
            'الياقة زرار واحد',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/الياقة 2 زرار.svg",
            height: 80,
          ),
          Text(
            'الياقة 2 زرار',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  ];
  var list3 = [


          Image.asset(
            "images/جلاب 1 زرار.jpg",height: 300,width: 300,scale: 300,fit: BoxFit.contain,
          ),



    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/جلاب 2 زرار.svg",
            height: 90,
          ),

        ],
      ),
    ),
  ];
  var list4 = [
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/جانب بشليك.svg",
            height: 90,
          ),
          Text(
            'جانب بشليك',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/جانب شق.svg",
            height: 90,
          ),
          Text(
            'جانب شق',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  ];
  var list5 = [
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/جيب مربع.svg",
            height: 90,
          ),
          Text(
            'جيب مربع',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/جيب مربع مثلث.svg",
            height: 90,
          ),
          Text(
            'جيب مربع مثلث',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/جيب مدور.svg",
            height: 90,
          ),
          Text(
            'جيب مدور',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  ];
  var list6 = [
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/صدر عادي.svg",
            height: 90,
          ),
          Text(
            'صدر عادي',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/صدر عادي لون في لون 2 خط.svg",
            height: 90,
          ),
          Text(
            'صدر عادي لون في لون 2 خط',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/صدر لون في لون خط واحد.svg",
            height: 90,
          ),
          const Text(
            'صدر لون في لون خط واحد',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  ];
  var list7 = [
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/كم شعراوي علية زراير.svg",
            height: 90,
          ),
          Text(
            'كم شعراوي علية زراير',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/كم بلدي.svg",
            height: 90,
          ),
          Text(
            'كم بلدي',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/الكم سادة+بشليك لزق.svg",
            height: 90,
          ),
          Text(
            "الكم سادة+بشليك لزق",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/الكم سادة.svg",
            height: 90,
          ),
          Text(
            "الكم سادة",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/اساورة بشليك.svg",
            height: 90,
          ),
          Text(
            "اساورة بشليك",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/اساورة كسرة واحد.svg",
            height: 90,
          ),
          Text(
            'اساورة كسرة واحد',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/اساورة مربع بدون كسرة.svg",
            height: 90,
          ),
          Text(
            'اساورة مربع بدون كسرة',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/اساورة مربع كسرة واحدة.svg",
            height: 90,
          ),
          Text(
            'اساورة مربع كسرة واحدة',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/اساورة مربع بدون كسرة.svg",
            height: 90,
          ),
          Text(
            'اساورة مربع بدون كسرة',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: buttonColor),
      child: Column(
        children: [
          SvgPicture.asset(
            "images/اساورة مربع 2 كسرة.svg",
            height: 90,
          ),
          Text(
            'اساورة مربع 2 كسرة',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  ];
}
