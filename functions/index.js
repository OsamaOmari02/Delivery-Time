const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
exports.orderTrigger = functions.firestore
  .document('allOrders/{orderId}').onCreate(
  async (snapShot, context) =>
  {
     var payload = {notification: {title: 'طلب جديد',body: snapShot.data().resName,sound: 'default', badge: '1'},
     data: {click_action: 'FLUTTER_NOTIFICATION_CLICK'}}
     const response = await admin.messaging().sendToTopic('Admin',payload);
  });