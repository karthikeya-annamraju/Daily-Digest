// Step 1: Firebase Authentication Setup
// Ensure you have Firebase configured in your Flutter project.

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // Email & Password Login
//   Future<User?> signInWithEmail(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print("Login Error: $e");
//       return null;
//     }
//   }
//
//   // Google Sign-In
//   Future<User?> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) return null;
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//       return userCredential.user;
//     } catch (e) {
//       print("Google Sign-In Error: $e");
//       return null;
//     }
//   }
//
//   // Logout
//   Future<void> signOut() async {
//     await _auth.signOut();
//     await GoogleSignIn().signOut();
//   }
// }
//
// // Step 2: Preference Selection Screen with Chip Widgets
// class PreferenceScreen extends StatefulWidget {
//   final String userId;
//   PreferenceScreen({required this.userId});
//
//   @override
//   _PreferenceScreenState createState() => _PreferenceScreenState();
// }
//
// class _PreferenceScreenState extends State<PreferenceScreen> {
//   List<String> categories = ["Technology", "Sports", "Health", "Business", "Entertainment"];
//   List<String> selectedCategories = [];
//
//   void savePreferences() async {
//     await FirebaseFirestore.instance.collection("users").doc(widget.userId).set({
//       "preferences": {"categories": selectedCategories}
//     }, SetOptions(merge: true));
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewsFeedScreen(userId: widget.userId)));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Select Your Preferences")),
//       body: Column(
//         children: [
//           Wrap(
//             children: categories.map((category) {
//               return Padding(
//                 padding: EdgeInsets.all(5),
//                 child: ChoiceChip(
//                   label: Text(category),
//                   selected: selectedCategories.contains(category),
//                   onSelected: (selected) {
//                     setState(() {
//                       selected ? selectedCategories.add(category) : selectedCategories.remove(category);
//                     });
//                   },
//                 ),
//               );
//             }).toList(),
//           ),
//           ElevatedButton(onPressed: savePreferences, child: Text("Save Preferences"))
//         ],
//       ),
//     );
//   }
// }
//
// // Step 3: Fetch and Display Personalized News
// class NewsFeedScreen extends StatefulWidget {
//   final String userId;
//   NewsFeedScreen({required this.userId});
//
//   @override
//   _NewsFeedScreenState createState() => _NewsFeedScreenState();
// }
//
// class _NewsFeedScreenState extends State<NewsFeedScreen> {
//   List<Map<String, dynamic>> newsList = [];
//
//   Future<void> fetchNews() async {
//     var userDoc = await FirebaseFirestore.instance.collection("users").doc(widget.userId).get();
//     var preferences = userDoc.data()?['preferences'] ?? {};
//     String categories = (preferences['categories'] ?? []).join(",");
//     String apiKey = "YOUR_NEWSAPI_KEY";
//     String apiUrl = "https://newsapi.org/v2/top-headlines?category=$categories&apiKey=$apiKey";
//
//     var response = await http.get(Uri.parse(apiUrl));
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       setState(() {
//         newsList = List<Map<String, dynamic>>.from(data['articles']);
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchNews();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Personalized News")),
//       body: newsList.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: newsList.length,
//         itemBuilder: (context, index) {
//           var news = newsList[index];
//           return ListTile(
//             title: Text(news['title'] ?? "No Title"),
//             subtitle: Text(news['description'] ?? "No Description"),
//             onTap: () => print("Open news: ${news['url']}"),
//           );
//         },
//       ),
//     );
//   }
// }
