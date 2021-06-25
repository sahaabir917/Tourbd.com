import 'package:get/state_manager.dart';
import 'package:shopx/models/TourModel.dart';
import 'package:shopx/models/product.dart';
import 'package:shopx/services/remote_services.dart';

import '../services/remote_services.dart';

class TourController extends GetxController {
  var isLoading = true.obs;
  var productList = List<Product>().obs;
  var tourModel = List<Datum>().obs;

  @override
  void onInit() {
    fetchTours();
    super.onInit();
  }

  void fetchTours() async {
    try{
      isLoading(true);
      var tours = await RemoteServices.fetchTours();
      if(tours.data.data!=null){
        tourModel = tours.data.data.obs;
      }
    }
    finally{
      isLoading(false);
    }
  }

  // void fetchProducts() async {
  //   try {
  //     isLoading(true);
  //     var products = await RemoteServices.fetchProducts();
  //     if (products != null) {
  //       productList.value = products;
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}