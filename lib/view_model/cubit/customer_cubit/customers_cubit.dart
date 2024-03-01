import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../../../Model/customer_model.dart';
import '../../database/network/dio_exceptions.dart';
import '../../database/network/end_points.dart';
import 'customer_state.dart';

class CustomersCubit extends Cubit<CustomersMainState> {
  CustomersCubit() : super(CustomersMainInitialState());

  static CustomersCubit get(context) => BlocProvider.of(context);
  List<Customer> customerModelList = [];

  Future postCustomer(BuildContext context, Customer customerModel) async {
    print(customerModel.address);
    ToastContext().init(context);

    emit(AddCustomersLoadingState());

    try {
      print(customerModel.toJson());
      await Dio().post("${baseUrl}products/customers", data: {
        'userName': customerModel.userName,
        "address": customerModel.address,
        "phone": customerModel.phone,
        "Remaining_amount": customerModel.remainingAmount,
        "code": customerModel.code,
        "customer_amount":0,
        "length": customerModel.length,
        "ketf_length": customerModel.ketfLength,
        "kom_length": customerModel.komLength,
        "sadr_length": customerModel.sadrLength,
        "neck_length": customerModel.neckLength,
        "hand_length": customerModel.handLength,
        "kabk_length": customerModel.kabkLength,
      }).then((value) {
        if (value.statusCode == 200) {
          Toast.show("تم الاضافة بنجاح ",
              duration: Toast.lengthLong, gravity: Toast.bottom);

          emit(AddCustomersSuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'],
          duration: Toast.lengthLong, gravity: Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(AddCustomersErrorState(e));

      throw errorMessage;
    }
  }

  Future updateCustomer(
      BuildContext context, Customer customerModel, String id) async {
    print(customerModel.address);
    ToastContext().init(context);

    emit(GetCustomersLoadingState());

    try {
      print(customerModel.toJson());
      await Dio().patch("${baseUrl}products/customers/$id", data: {
        'userName': customerModel.userName,
        "address": customerModel.address,
        "phone": customerModel.phone,
        "Remaining_amount": customerModel.remainingAmount,
        "code": customerModel.code,
        "customer_amount":customerModel.customerAmount,
        "length": customerModel.length,
        "ketf_length": customerModel.ketfLength,
        "kom_length": customerModel.komLength,
        "sadr_length": customerModel.sadrLength,
        "neck_length": customerModel.neckLength,
        "hand_length": customerModel.handLength,
        "kabk_length": customerModel.kabkLength,
      }).then((value) {
        if (value.statusCode == 200) {
          getData();

          Toast.show("تم التحديث بنجاح ",
              duration: Toast.lengthLong, gravity: Toast.bottom);

          emit(GetCustomersSuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'],
          duration: Toast.lengthLong, gravity: Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(GetCustomersErrorState(e));

      throw errorMessage;
    }
  }

  Future updateCustomer2(
      BuildContext context, Customer customerModel, String id) async {
    try {
      await Dio().patch("${baseUrl}products/customers/$id", data: {
        'userName': customerModel.userName,
        "address": customerModel.address,
        "phone": customerModel.phone,
        "Remaining_amount": customerModel.remainingAmount,
        "code": customerModel.code,
        "customer_amount":customerModel.customerAmount,
        "length": customerModel.length,
        "ketf_length": customerModel.ketfLength,
        "kom_length": customerModel.komLength,
        "sadr_length": customerModel.sadrLength,
        "neck_length": customerModel.neckLength,
        "hand_length": customerModel.handLength,
        "kabk_length": customerModel.kabkLength,
      });

    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();

      throw errorMessage;
    }
  }

  Future getData() async {
    customerModelList = [];
    emit(GetCustomersLoadingState());

    try {
      await Dio()
          .get(
        "${baseUrl}products/customers",
      )
          .then((value) {
        if (value.statusCode == 200) {
          customerModelList =
              (value.data as List).map((e) => Customer.fromJson(e)).toList();
          print(customerModelList);

          emit(GetCustomersSuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'],
          duration: Toast.lengthLong, gravity: Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(GetCustomersErrorState(e));

      throw errorMessage;
    }
    return customerModelList;
  }

  Future deleteCustomer(String id) async {
    emit(GetCustomersLoadingState());

    try {
      await Dio()
          .delete(
        "${baseUrl}products/customers/$id",
      )
          .then((value) {
        if (value.statusCode == 200) {
          getData();
          Toast.show("تم الحذف بنجاح",
              duration: Toast.lengthLong, gravity: Toast.bottom);

          emit(GetCustomersSuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'],
          duration: Toast.lengthLong, gravity: Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(GetCustomersErrorState(e));

      throw errorMessage;
    }
  }
}
