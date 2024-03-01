abstract class CustomersMainState {}

class CustomersMainInitialState extends CustomersMainState{}
class AddCustomersLoadingState extends CustomersMainState{}
class AddCustomersSuccessState extends CustomersMainState{}

class AddCustomersErrorState extends CustomersMainState{
  final  error;

  AddCustomersErrorState(this.error);
}
class UpdateCustomersLoadingState extends CustomersMainState{}
class UpdateCustomersSuccessState extends CustomersMainState{}

class UpdateCustomersErrorState extends CustomersMainState{
  final  error;

  UpdateCustomersErrorState(this.error);
}
class GetCustomersLoadingState extends CustomersMainState{}
class  GetCustomersSuccessState extends CustomersMainState{}

class  GetCustomersErrorState extends CustomersMainState{
  final  error;

  GetCustomersErrorState(this.error);
}
class DeleteCustomersLoadingState extends CustomersMainState{}
class  DeleteCustomersSuccessState extends CustomersMainState{}

class  DeleteCustomersErrorState extends CustomersMainState{
  final  error;

  DeleteCustomersErrorState(this.error);
}
