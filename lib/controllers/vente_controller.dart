import 'package:gestion_stock_flutter/core/extension.dart';
import 'package:gestion_stock_flutter/vente/vente.dart';
import 'package:get/get.dart';
import 'package:gestion_stock_flutter/service/vente_service.dart';

class VenteController extends GetxController {
  final String appBarTitle = 'Listes des ventes';
  final VenteService _venteService = VenteService();
  RxBool isLoading = false.obs;
  RxList<VenteProduit> ventes = RxList([]);

  Future<void> refreshVentes() async {
    setIsloading(true);
    ventes.value = await _venteService.getVentesFromFirebase();
    setIsloading(false);
  }

  Future<void> getVentes() async {
    if (ventes.isEmpty) {
      refreshVentes();
    }
  }

  Future<VenteProduit?> getVente(String idVente) async {
    if (ventes.isEmpty) {
      await refreshVentes();
    }
    return ventes.singleOrNullWhere((element) => element.idVente == idVente);
  }

  Future<List<VenteProduit>?> getVenteByProduit(String idProduit) async {
    return ventes.where((element) => element.idProduit == idProduit).toList();
  }

  int getVenteTotalProduct(String idProduit) {
    if (ventes.isEmpty) {
      return 0;
    }
    int total = ventes
        .where((element) => element.idProduit == idProduit)
        .fold(0, (previousValue, element) => previousValue + element.quantite);
    return total;
  }

  Future<bool> setVente({required Vente vente}) async {
    setIsloading(true);
    await _venteService.setVenteToFirebase(vente: vente);
    setIsloading(false);
    return true;
  }

  void setIsloading(bool val) {
    isLoading.value = val;
  }

  @override
  void onInit() {
    getVentes();
    super.onInit();
  }
}
