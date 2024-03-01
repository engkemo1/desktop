abstract class ProductsMainState {}

class ProductsMainInitialState extends ProductsMainState{}
class AddProductsLoadingState extends ProductsMainState{}
class AddProductsSuccessState extends ProductsMainState{}

class AddProductsErrorState extends ProductsMainState{
  final  error;

  AddProductsErrorState(this.error);
}
class GetProductsLoadingState extends ProductsMainState{}
class  GetProductsSuccessState extends ProductsMainState{}

class  GetProductsErrorState extends ProductsMainState{
  final  error;

  GetProductsErrorState(this.error);
}
class DeleteProductsLoadingState extends ProductsMainState{}
class  DeleteProductsSuccessState extends ProductsMainState{}

class  DeleteProductsErrorState extends ProductsMainState{
  final  error;

  DeleteProductsErrorState(this.error);
}
class GetCategoryLoadingState extends ProductsMainState{}
class  GetCategorySuccessState extends ProductsMainState{}

class  GetCategoryErrorState extends ProductsMainState{
  final  error;

  GetCategoryErrorState(this.error);
}

class AddCategoryLoadingState extends ProductsMainState{}
class  AddCategorySuccessState extends ProductsMainState{}

class  AddCategoryErrorState extends ProductsMainState{
  final  error;

  AddCategoryErrorState(this.error);
}
class UpdateCategoryLoadingState extends ProductsMainState{}
class  UpdateCategorySuccessState extends ProductsMainState{}

class  UpdateCategoryErrorState extends ProductsMainState{
  final  error;

  UpdateCategoryErrorState(this.error);
}