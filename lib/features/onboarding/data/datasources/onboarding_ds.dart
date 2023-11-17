import 'dart:developer';

import 'package:eden_user_app/core/storage/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class OnboardingDS {
  Future<User?> signInWithEmail(Map<String, dynamic> data);
  Future<User?> signInWithGoogle();
  Future<User?> signInWithGithub();
}

class OnboardingDSImpl implements OnboardingDS {
  FirebaseAuth auth = FirebaseAuth.instance;
  GithubAuthProvider githubProvider = GithubAuthProvider();
  final Storage storage;
  OnboardingDSImpl({required this.storage});

  @override
  Future<User?> signInWithEmail(data) async {
    try {
      final response = await auth
          .signInWithEmailAndPassword(
              email: data["email"], password: data["password"])
          .onError((error, stackTrace) => FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: data["email"], password: data["password"]));
      log(response.toString(), name: "email sign in");
      if (response.user?.uid != null) {
        await storage.saveToken(value: response.user!.uid);
        return response.user;
      } else {
        throw Exception();
      }
    } on PlatformException catch (e) {
      log(e.toString(), name: "email sign in error");
      rethrow;
    }
  }

  @override
  Future<User?> signInWithGithub() async {
    try {
      final response =
          await FirebaseAuth.instance.signInWithProvider(githubProvider);

      log(response.toString(), name: "github sign in");
      if (response.user?.uid != null) {
        await storage.saveToken(value: response.user!.uid);
        return response.user;
      } else {
        throw Exception();
      }
    } on PlatformException catch (e) {
      log(e.toString(), name: "github sign in error");
      rethrow;
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final response = await auth.signInWithCredential(credential);

      log(response.toString(), name: "google sign in");
      if (response.user?.uid != null) {
        await storage.saveToken(value: response.user!.uid);
        return response.user;
      } else {
        throw Exception();
      }
    } on PlatformException catch (e) {
      if (e.code == GoogleSignIn.kNetworkError) {
        String errorMessage =
            "A network error (such as timeout, interrupted connection or unreachable host) has occurred.";
        log(e.toString(), name: "google sign in error");
        throw errorMessage;
      } else {
        String errorMessage = "Something went wrong.";
        log(e.toString(), name: "google sign in error");
        throw errorMessage;
      }
    }
  }
}
