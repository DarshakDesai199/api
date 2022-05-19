import 'package:api/Api%20Get%20through%20Getx/Api%20get%20Service.dart';
import 'package:get/state_manager.dart';

import 'model.dart';

class PokeMonController extends GetxController {
  RxBool isLoading = true.obs;

  Pokemon? pokeList;

  @override
  void onInit() {
    apiData();
    super.onInit();
  }

  void apiData() async {
    isLoading(true);

    try {
      final data = await ApiServices.getData();
      if (data != null) {
        pokeList = data;
      }
    } finally {
      isLoading(false);
    }
  }
}
