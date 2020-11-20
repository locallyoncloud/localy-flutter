import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locally_flutter_app/base_classes/home_base.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/models/order.dart';
import 'package:locally_flutter_app/models/product.dart';
import 'package:locally_flutter_app/repositories/home_repository.dart';

class HomePageVM extends ChangeNotifier with HomeBase{
  bool hideCarousel  = false;
  List<Company> companyList = [];
  List<String> categoryList = [];
  String currentFilter="";
  Position currentPosition;

  setCarouselVisibility(bool carouselStatus){
    hideCarousel = carouselStatus;
    notifyListeners();
  }

  selectFilter(String filter){
    currentFilter = filter;
    notifyListeners();
  }

  setCurrentPosition() async{
    currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Future<List<Company>> getCompanyList() async {
    return await getIt<HomeRepository>().getCompanyList();
  }

  @override
  Future<LoyaltyCard> getClientSideLoyaltyCard(String company_id) async {
    return await getIt<HomeRepository>().getClientSideLoyaltyCard(company_id);
  }

  @override
  Stream getLoyaltyProgress(String loyaltyCardUid, String userMail) {
    return  getIt<HomeRepository>().getLoyaltyProgress(loyaltyCardUid, userMail);
  }

  @override
  Future<void> openLoyaltyCardForUser(String loyaltyCardUid, String userMail, List<String> notificationIds) async {
    return await getIt<HomeRepository>().openLoyaltyCardForUser(loyaltyCardUid, userMail, notificationIds);
  }

  @override
  Future<List<Product>> getAllProducts(String companyId) async {
    String categoryName = "";
    List<Product> productList = await getIt<HomeRepository>().getAllProducts(companyId);
    productList.forEach((product) {
      if(product.category != categoryName && !categoryList.contains(product.category)){
        categoryName = product.category;
        categoryList.add(categoryName);
      }
    });
    notifyListeners();
    return productList;
  }

  @override
  Future<Company> getCompanyDetails(String companyId) async {
    return await getIt<HomeRepository>().getCompanyDetails(companyId);
  }

  @override
  Stream<LoyaltyProgress> getUserLoyalty(String loyaltyCardUid, String userMail) {
    return  getIt<HomeRepository>().getUserLoyalty(loyaltyCardUid, userMail);
  }

  @override
  Future<void> submitOrder(Order order) async {
    return await getIt<HomeRepository>().submitOrder(order);
  }

  @override
  Stream<List<Order>> getActiveOrders(String userMail) {
    return  getIt<HomeRepository>().getActiveOrders(userMail);
  }

  @override
  Future<List<Order>> getAllCustomerPreviousOrders(String userMail) async {
    return await getIt<HomeRepository>().getAllCustomerPreviousOrders(userMail);
  }

  @override
  Stream<List<Order>> getAllAdminSideOrders(String companyId) {
    return  getIt<HomeRepository>().getAllAdminSideOrders(companyId);
  }

  @override
  Stream<List<Order>> getAllClientSideOrders(String userMail) {
    return  getIt<HomeRepository>().getAllClientSideOrders(userMail);
  }

}