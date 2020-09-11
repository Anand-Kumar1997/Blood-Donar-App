import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';


Future<FirebaseUser> signInAccountAuth(GoogleSignInAccount account) async{
  GoogleSignInAuthentication googleSignInAuthentication =await account.authentication;

  AuthCredential credential = GoogleAuthProvider.getCredential(
    idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken
  );

 FirebaseUser user = await firebaseAuth.signInWithCredential(credential);

 return user;
}

Future<FirebaseUser> googleSigninMethod()  async{
  GoogleSignInAccount  googleSignInAccount = await googleSignIn.signIn();
  return await signInAccountAuth(googleSignInAccount);
}

