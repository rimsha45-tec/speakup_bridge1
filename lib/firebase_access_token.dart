// import 'dart:developer';
// import 'package:googleapis_auth/auth_io.dart';
//
// class FirebaseAccessToken {
//   static String firebaseMessagingApi =
//       "https://www.googleapis.com/auth/firebase.messaging";
//
//   Future<String> generateFirebaseAccessToken() async {
//     final credentialsJson = {
//       "type": "service_account",
//       "project_id": "speakup-bridge",
//       "private_key_id": "6b133103e88676f6e723d1ed797aff5aa8b82827",
//       "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDY7j4YSdXXodgv\nLZKiv381mhU3IMFjFOGCaizjbdmmWEXO3PJVsK814tvHdOV2v2vafEL8Ry7c/7sO\ngcSao/nRS6VwhyKaJClDRaeKne3kTSGrlELETGOLLyOhvSKJxmZOmfoPGfrv4oXR\nkrfLFaYb5rjDMh61HXRrUUk5gbjmYc6lKQEjo1kN3ppdD5Xu8lyJh8jVhiZDKwJh\nEA+FalbkB4UVeJUB9sLrueh8z6xnf6hIe2tw+NgLh21SJO28pucWi+mR7MuL3SFh\nL4yXxXmNoNNudWISwvJRVDHUkskbVNxbpw7pVwKwa5ci8y0ZrN2VMO+a+mqk2r1M\nMwMi4uqfAgMBAAECggEAGtWl0sVXcZwwrO1bRUyhBNVxqGch5QrRNpvBv8R39w7W\nW9eTFqyLkAPnIg5A0GavhdB3TNPVZTsxPYMp+eMs5QoRhhEBY8XzYMH+DrSol+Q+\ntQXbGINGkRIcu0Y1PovPXgvIFhQlqYUA/sLCf5nG+Y6Z7nOFvuvM2fWtNDLq13yp\nkMqoaE3QRu3Knr6M/WVA41zOnnRGJhoG9v9jN2hlI+vSetS9Pzm26quEdHMZPKZk\nWFUxVhAuKE3Jretob2EGWFa7IaTLdilmxqGCepGL6y3GzdipbK3Z6CXjE3Wol/9O\n8Rwwq2oIOerVZvZNhNDM4GiKY3bbaU14DV1I7GVYAQKBgQDsB15WoZ6GqOKPzoDD\nSO1CsoRjQLi2UTFf2NKQJVGKe+Zsadn5R8+q7Y3qstD1Dca3yhofiaFtWSqh/cHJ\n86UYOKv90QgY9gNUkMYgsmImyPrduG5oxGCSazZ6ehOVTL0eqevv9xgtmUgHV+9p\nSOQyTyomURvYpUt62jgnM+6mnwKBgQDrSTAme6IXfpeDIo6UIGApc42k8wiYQgzt\nPn7LGuQT+7lyJAy/qeQ1MKaaencJddaXS6Y9r4cHZrxZR8j3bOFrCcv7BnYT6LcA\n4ncXVCFHcMGPKKOvZ1p+RtA3tKjR7Vo6yqxRY2XHazpyBZGo4EdGB20q3QN0+S9I\nq9niCbk8AQKBgDiwyGLsbMQROmGqCtlc4cfcUtn4CKWZuM85p9GBdSVa/wxZHEa4\njdOTPTv6+R9y0KECROYAS6qU+R1xcqNMBwJbUkwjcdt083XTVBM0ZUjFiyPIEZTO\nXhes8qfWPG/mv6Hm1EmNwtvo7hj9cP6LyGuhAhGz94lAonF+inA4FAEnAoGBANDP\n9HbC1JlLVUYhfi5CCXXgQr44ntEaFYTcKQUySWbeybdd/R6AtbLrCYEh3NE9joRZ\ntCEczZao+9G0nsvQCsLHQAv5sQN8TiXv1seSd7KChJX7+EEsVaiqShKWOBmPL7vr\nsUDOGT8BkC4veRVKbpbc8mrPGUlP+UHimo08GfQBAoGBAOnpnF9IKSbL3RmLo8aP\nJRpn11JSHwhNEF8ZynDaavK542RhCkvN44s62b09DvtO0NEQTPUcSKaSYJ/1Yckp\neQPHOwAwvNEWV/QAgCV0hwVqhzadLSIRdeXeAA0MPYVnK0reNm4/3x3rOQtrCLxa\n4GM/QXwQXJMy1s3KYkL4tGU4\n-----END PRIVATE KEY-----\n",
//       "client_email": "firebase-adminsdk-9j7tt@speakup-bridge.iam.gserviceaccount.com",
//       "client_id": "105265501300704520777",
//       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//       "token_uri": "https://oauth2.googleapis.com/token",
//       "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//       "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-9j7tt%40speakup-bridge.iam.gserviceaccount.com",
//       "universe_domain": "googleapis.com"
//     };
//
//     try {
//       final client = await clientViaServiceAccount(
//           ServiceAccountCredentials.fromJson(credentialsJson),
//           [firebaseMessagingApi]);
//       final accessToken = client.credentials.accessToken.data;
//       // log('OAuth 2.0 access token generated: $accessToken');
//       return accessToken;
//     } catch (e) {
//       log('Error generating access token: $e');
//       return '';
//     }
//   }
// }
