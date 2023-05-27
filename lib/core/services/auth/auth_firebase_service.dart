import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/core/models/chat_user.dart';
import 'dart:io';
import 'dart:async';
import 'package:chat/core/services/auth/auth_service.dart';

class AuthFirebaseService implements AuthService {
  // ignore: prefer_const_constructors

  static ChatUser? _currentUser;

  static final _userStream = Stream<ChatUser?>.multi((contoller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      contoller.add(_currentUser);
    }
  });

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> signUp(
      String name, String email, String password, File? image) async {
    final auth = FirebaseAuth.instance;

    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (credential.user == null) return;

    credential.user?.updateDisplayName(name);
    //credential.user?.updatePhotoURL(photoURL);
  }

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  static ChatUser _toChatUser(User user) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageUrl: user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
