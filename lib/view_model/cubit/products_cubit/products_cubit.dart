import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/add_state.dart';
import 'package:desktop_app/view_model/database/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../../../Model/category_model.dart';
import '../../../Model/products_model.dart';
import '../../database/local/cache_helper.dart';
import '../../database/network/dio-helper.dart';
import '../../database/network/dio_exceptions.dart';

class ProductCubit extends Cubit<ProductsMainState> {
  ProductCubit() : super(ProductsMainInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);
  List<ProductsModel> productsModelList = [];
  List<ProductsModel> productsSearchList = [];
  List<CategoryModel> categorySearchList = [];
  List<CategoryModel> categoryList = [];
  bool isSub=false;

  String selectedDate = DateFormat.yMd().format(DateTime.now());

  changeDate(var date) {
    selectedDate = date;
    emit(state);
  }

  // String token=  CacheHelper.get(key: 'token');

  Future postProduct(BuildContext context, ProductsModel productsModel) async {
    ToastContext().init(context);
    emit(AddProductsLoadingState());
    FormData formData = FormData.fromMap({
      'name': productsModel.name,
      "date": productsModel.date!,
      'length': productsModel.length,
      "address": productsModel.address,
      "amount_paid": productsModel.amountPaid,
      "chest_length": productsModel.chestLength,
      "created_at": DateTime.now(),
      "details": productsModel.details,
      'hand_length': productsModel.handLength,
      'image': productsModel.image,
      'k_length': productsModel.kLength,
      'm_length': productsModel.mLength,
      'num_dresses': productsModel.numDresses,
      "kom_sha3rawy_lenght4":productsModel.komSha3rawyLenght4,
      "kom_sha3rawy_lenght3":productsModel.komSha3rawyLenght3,
      "kom_sha3rawy_lenght2":productsModel.komSha3rawyLenght2,
      "kom_sha3rawy_lenght1":productsModel.komSha3rawyLenght1,
      "neck": productsModel.neck,
      "kom_balady_lenght1":productsModel.komBaladyLenght1,
      "kom_balady_lenght2":productsModel.komBaladyLenght2,
      "kom_balady_lenght3":productsModel.komBaladyLenght3,
      "kom_balady_lenght4":productsModel.komBaladyLenght4,

      "phone": productsModel.phone,
      "prize": productsModel.prize,
      "Remaining_amount": productsModel.remainingAmount,
      "taqwera": productsModel.taqwera,
      "ganb": productsModel.ganb,
      "gayb": productsModel.gayb,
      "sadr": productsModel.sadr,
      "yaqa": productsModel.yaqa,
      "glab": productsModel.glab,
      "kom": productsModel.kom,
      "kom_length": productsModel.komLength,
      "ketf_length": productsModel.ketfLength,
      "code": productsModel.code,
      "delivery_time": productsModel.deliveryTime,
      "type": productsModel.type,
      "kom_sha3rawy":productsModel.komSha3rawy,
      "kom_balady":productsModel.komBalady,
      "additional_type1": productsModel.additionalType1,
      "additional_type2": productsModel.additionalType2,
      "fyber_type": productsModel.fyberType,
      "quantity": productsModel.quantity,
      "worker_cost": productsModel.workerCost,
      "total": productsModel.total,
      "taqwera_size":productsModel.taqweraSize,
      "sadr_size":productsModel.sadrSize,
      "gayb_size":productsModel.gaybSize,
      "ganb_size":productsModel.ganbSize,
      "yaqa_size":productsModel.yaqaSize,
      "glab_size":productsModel.glabSize,
      "kom_size":productsModel.komSize,
      "k2_length":productsModel.k2Length,
      "badn_size3":productsModel.badnSize3,
      "badn_size2":productsModel.badnSize2,
      "badn_size1":productsModel.badnSize1,
      "dropp_taqwera3":productsModel.droppTaqwera3,
      "dropp_taqwera2":productsModel.droppTaqwera2,
      "dropp_taqwera1":productsModel.droppTaqwera1,
      "hand2_length":productsModel.hand2Length,
    });
    try {
      await Dio().post("${baseUrl}products", data: formData).then((value) {
        if (value.statusCode == 200) {
          ProductsModel responseBody;

          responseBody = ProductsModel.fromJson(value.data);
          print(responseBody.address);

          Toast.show("تم الاضافة بنجاح ",
              duration: Toast.lengthLong, gravity: Toast.bottom);
          emit(AddProductsSuccessState());

          return responseBody;
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'],
          duration: Toast.lengthLong, gravity: Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(AddProductsErrorState(e));

      throw errorMessage;
    }
  }
  Future updateByDeleteThenAdd(BuildContext context, ProductsModel newProduct) async {
    ToastContext().init(context);
    emit(AddProductsLoadingState());

    try {
      print("Deleted old product: ${newProduct.sId}");

      // 1) حذف المنتج القديم
      await Dio().delete("${baseUrl}products/${newProduct.sId}");
      print("Deleted old product: ${newProduct.sId}");

      // 2) إضافة المنتج الجديد
      await postProduct(context, newProduct);

      Toast.show("تم تحديث الفاتورة بنجاح",
          duration: Toast.lengthLong, gravity: Toast.bottom);

      emit(AddProductsSuccessState());
    } catch (e) {
      emit(AddProductsErrorState(e));
      rethrow;
    }
  }

  Future updateProduct(BuildContext context, ProductsModel productsModel) async {
    print(productsModel.sId);
    print(productsModel.isDelliverd);

    ToastContext().init(context);
    emit(AddProductsLoadingState());
    try {
      await Dio().patch("${baseUrl}products/${productsModel.sId}", data:  { "is_delliverd": productsModel.isDelliverd,}).then((value) {
        if (value.statusCode == 200) {
          ProductsModel responseBody;

          responseBody = ProductsModel.fromJson(value.data);
          print(responseBody.toJson());
          Toast.show("تم التحديث بنجاح ",
              duration: Toast.lengthLong, gravity: Toast.bottom);
          emit(AddProductsSuccessState());

        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'],
          duration: Toast.lengthLong, gravity: Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(AddProductsErrorState(e));

      throw errorMessage;
    }
  }

  Future getData() async {
    productsModelList = [];
    emit(GetProductsLoadingState());

    try {
      await Dio()
          .get(
        "${baseUrl}products",
      )
          .then((value) {
        if (value.statusCode == 200) {
          productsModelList = (value.data as List)
              .map((e) => ProductsModel.fromJson(e))
              .toList();
        }
      });
      emit(GetProductsSuccessState());
      return productsModelList;
    } on DioError catch (e) {
      emit(GetProductsErrorState(e));

      print(e.response!.data);
      Toast.show(e.response!.data['message'],
          duration: Toast.lengthLong, gravity: Toast.bottom);
      final errorMessage = DioExceptions.fromDioError(e).toString();

      throw errorMessage;
    }
  }

  Future deleteProduct(String id) async {
    emit(GetCategoryLoadingState());

    try {
      await Dio()
          .delete(
        "${baseUrl}products/$id",
      )
          .then((value) {
        if (value.statusCode == 200) {
          getData();
          Toast.show("تم الحذف بنجاح",
              duration: Toast.lengthLong, gravity: Toast.bottom);

          emit(AddProductsSuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'],
          duration: Toast.lengthLong, gravity: Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(AddProductsErrorState(e));

      throw errorMessage;
    }
  }

  Future postCategory(BuildContext context, CategoryModel categoryModel) async {
    ToastContext().init(context);
    print(categoryModel.price);
    emit(AddCategoryLoadingState());
var data ={
  "type": categoryModel.type,
  "price":categoryModel.price,
  "quantity": categoryModel.quantity
};
    try {
      await Dio()
          .post("${baseUrl}products/category", data:data )
          .then((value) {
        if (value.statusCode == 200) {
          CategoryModel responseBody;

          responseBody = CategoryModel.fromJson(value.data);

          Toast.show("تم الاضافة بنجاح ",
              duration: Toast.lengthLong, gravity: Toast.bottom);

          emit(AddCategorySuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'],
          duration: Toast.lengthLong, gravity: Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(AddCategoryErrorState(e));

      throw errorMessage;
    }
  }
  Future UpdateCategory(BuildContext context, CategoryModel categoryModel,String id) async {
    ToastContext().init(context);
    emit(AddCategoryLoadingState());
    var data ={
      "type": categoryModel.type,
      "price":categoryModel.price,
      "quantity": categoryModel.quantity
    };
    try {
      await Dio()
          .patch("${baseUrl}products/category/$id", data:data )
          .then((value) {
        if (value.statusCode == 200) {
          CategoryModel responseBody;

          responseBody = CategoryModel.fromJson(value.data);

          Toast.show("تم التحديث بنجاح ",
              duration: Toast.lengthLong, gravity: Toast.bottom);

          emit(AddCategorySuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'],
          duration: Toast.lengthLong, gravity: Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(AddCategoryErrorState(e));

      throw errorMessage;
    }
  }
  Future deleteCategory(String id) async {
    emit(GetCategoryLoadingState());

    try {
      await Dio()
          .delete(
        "${baseUrl}products/category/$id",
      )
          .then((value) {
        if (value.statusCode == 200) {
          getDataCategory();
          Toast.show("تم الحذف بنجاح",
              duration: Toast.lengthLong, gravity: Toast.bottom);

          emit(GetCategorySuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'],
          duration: Toast.lengthLong, gravity: Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(GetCategoryErrorState(e));

      throw errorMessage;
    }
  }

  Future getDataCategory() async {
    categoryList = [];
    emit(GetCategoryLoadingState());

    try {
      await Dio()
          .get(
        "${baseUrl}products/category",
      )
          .then((value) {
        if (value.statusCode == 200) {
          categoryList = (value.data as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList();
        }
      });
      emit(GetCategorySuccessState());
      return categoryList;
    } on DioError catch (e) {
      emit(GetCategoryErrorState(e));

      print(e.response!.data);
      Toast.show(e.response!.data['message'],
          duration: Toast.lengthLong, gravity: Toast.bottom);
      final errorMessage = DioExceptions.fromDioError(e).toString();

      throw errorMessage;
    }

  }
}
