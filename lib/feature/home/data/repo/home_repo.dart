import 'package:credpaltest/core/util/app_exception.dart';
import 'package:credpaltest/core/util/supabase_provider.dart';
import 'package:credpaltest/feature/home/data/models/featured_marchants.dart';
import 'package:credpaltest/feature/home/data/models/products_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeRepo {
  static Future<List<ProductsModel>> fetchProducts(Ref ref) async {
    List<ProductsModel> producsList = [];
    try {
      final List<Map<String, dynamic>> data =
          await ref
              .read(supabaseProvider(allowAdmin: true))
              .from('producs_data')
              .select();
      producsList = data.map((e) => ProductsModel.fromJson(e)).toList();
    } on PostgrestException catch (e) {
      throw AppException(message: e.toString());
    } catch (e) {
      throw AppException(message: e.toString());
    }

    return producsList;
  }

  static Future<List<FeaturedMarchantsModel>> fetchMarcants(Ref ref) async {
    List<FeaturedMarchantsModel> marchantsList = [];
    try {
      final List<Map<String, dynamic>> data =
          await ref
              .read(supabaseProvider(allowAdmin: true))
              .from('featured_marchants')
              .select();
      marchantsList =
          data.map((e) => FeaturedMarchantsModel.fromJson(e)).toList();
    } on PostgrestException catch (e) {
      throw AppException(message: e.toString());
    } catch (e) {
      throw AppException(message: e.toString());
    }

    return marchantsList;
  }
}
