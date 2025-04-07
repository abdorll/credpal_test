import 'package:credpaltest/feature/home/data/models/featured_marchants.dart';
import 'package:credpaltest/feature/home/data/models/products_models.dart';
import 'package:credpaltest/feature/home/data/repo/home_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// for fetching available products [List<ProductsMode>]
final fetchProductsControllerProvider =
    StateNotifierProvider<FetchProductsController, AsyncValue>(
      (ref) => FetchProductsController(ref),
    );

class FetchProductsController extends StateNotifier<AsyncValue> {
  FetchProductsController(this.ref) : super(AsyncData(<ProductsModel>[])) {
    fetchProducts();
  }
  Ref ref;
  Future<void> fetchProducts() async {
    try {
      state = AsyncLoading();
      List<ProductsModel> products = await HomeRepo.fetchProducts(ref);
      state = AsyncData(products);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

/// for fetching available featured marchants [List<FeaturedMarchantsModel>]
final fetchMarchantsControllerProvider =
    StateNotifierProvider<FetchMarchantsController, AsyncValue>(
      (ref) => FetchMarchantsController(ref),
    );

class FetchMarchantsController extends StateNotifier<AsyncValue> {
  FetchMarchantsController(this.ref)
    : super(AsyncData(<FeaturedMarchantsModel>[])) {
    fetchMarchants();
  }
  Ref ref;
  Future<void> fetchMarchants() async {
    try {
      state = AsyncLoading();
      List<FeaturedMarchantsModel> products = await HomeRepo.fetchMarcants(ref);
      state = AsyncData(products);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
