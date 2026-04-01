import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference get users => _db.collection('users');
  CollectionReference get restaurants => _db.collection('restaurants');
  CollectionReference get menuItems => _db.collection('menu_items');
  CollectionReference get orders => _db.collection('orders');

  // Example: create restaurant
  Future<DocumentReference> createRestaurant(Map<String, dynamic> data) {
    data['createdAt'] = FieldValue.serverTimestamp();
    return restaurants.add(data);
  }

  // Example: query menu items by restaurant
  Stream<QuerySnapshot> menuItemsForRestaurant(String restaurantId) {
    return menuItems.where('restaurantId', isEqualTo: restaurantId).snapshots();
  }

  // Create order
  Future<DocumentReference> placeOrder(Map<String, dynamic> orderData) {
    orderData['createdAt'] = FieldValue.serverTimestamp();
    return orders.add(orderData);
  }
}
