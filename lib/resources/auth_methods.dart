import 'dart:io';
import 'dart:typed_data';
//import 'dart:html';
import 'package:auy27/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final currentUser = FirebaseAuth.instance.currentUser;
  //signup user
  Future<String> signUpUser({
    required String email,
    required String password,
  }) async {
    String res = 'Please enter all the fields';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);
        print('User created successfuly');
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
      if (err.code == 'invalid-email') {
        res = 'Wrong email format';
      } else if (err.code == 'weak-password') {
        res = 'Password cannot be less than 6 characters';
      } else if (err.code == 'email-already-in-use') {
        res = 'User already exist';
      } else if (err.code == 'network-request-failed') {
        res = 'Network error';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
      if (err.code == 'invalid-email') {
        res = 'Wrong email format';
      } else if (err.code == 'INVALID_LOGIN_CREDENTIALS') {
        res = 'Invalid Login Credentials';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //save political group
  Future<String> savePoliticalGroup(
      {required String name,
      required String phone,
      required String address,
      required String members,
      required String lga,
      required String ward,
      //  required String polling_unit,
      required String party,
      required String status,
      required String polls,
      String? nin,
      String? bvn,
      String? voter,
      required Uint8List file}) async {
    String res = 'Please enter all the fields';
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      if (name.isNotEmpty &&
          phone.isNotEmpty &&
          address.isNotEmpty &&
          members.isNotEmpty &&
          //  polling_unit.isNotEmpty &&
          status.isNotEmpty &&
          polls.isNotEmpty &&
          party.isNotEmpty &&
          // nin.isNotEmpty &&
          // bvn.isNotEmpty &&
          // voter.isNotEmpty &&
          file != null &&
          lga != null &&
          ward != null) {
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('political_group_images', file, false);
        //add to database
        await _firestore.collection('Political Group').add({
          'name': name,
          'phone': phone,
          'address': address,
          'members': members,
          'lga': lga,
          'ward': ward,
          //  'polling_unit': polling_unit,
          'party': party,
          'status': status,
          'polls': polls,
          'nin': nin,
          'bvn': bvn,
          'voter': voter,
          'id': DateTime.now().microsecondsSinceEpoch.toString(),
          'uid': uid,
          'photoUrl': photoUrl,
        });
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //save residence
  Future<String> saveResidence(
      {required String name,
      required String phone,
      required String address,
      required String lga,
      String? nin,
      String? bvn,
      String? voter,
      required String party,
      //   required String polling,
      required String status,
      required String polls,
      required Uint8List file}) async {
    // print(file == null);
    String res = 'Please enter all the fields';
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      if (name.isNotEmpty &&
          phone.isNotEmpty &&
          address.isNotEmpty &&
          party.isNotEmpty &&
          //  polling.isNotEmpty &&
          status.isNotEmpty &&
          polls.isNotEmpty &&
          file != null &&
          lga != null) {
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('residence_images', file, false);
        print(photoUrl);
        //add to database
        await _firestore.collection('Residence').add({
          'name': name,
          'phone': phone,
          'address': address,
          'nin': nin,
          'bvn': bvn,
          'voter': voter,
          'party': party,
          //  'polling': polling,
          'status': status,
          'polls': polls,
          'lga': lga,
          'latitude': '',
          'id': DateTime.now().microsecondsSinceEpoch.toString(),
          'uid': uid,
          'photoUrl': photoUrl,
        });
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
    } catch (err) {
      res = err.toString();
      print(err);
    }
    return res;
  }

  //save islamiya
  Future<String> saveIslamiya({
    required String name,
    required String nameRep,
    required String phone,
    required String address,
    required String members,
    required String denomination,
    required String lga,
    required String polls,
    String? nin,
    String? bvn,
    String? voter,
    required Uint8List file,
    File? file2,
  }) async {
    String res = 'Please enter all the fields';
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      if (name.isNotEmpty &&
          nameRep.isNotEmpty &&
          phone.isNotEmpty &&
          address.isNotEmpty &&
          members.isNotEmpty &&
          denomination.isNotEmpty &&
          polls.isNotEmpty &&
          file != null &&
          lga != null) {
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('islamiya_images', file, false);
        //add to database
        await _firestore.collection('Islamiya').add({
          'name': name,
          'name_rep': nameRep,
          'phone': phone,
          'address': address,
          'members': members,
          'denomination': denomination,
          'polls': polls,
          'nin': nin,
          'bvn': bvn,
          'voter': voter,
          'lga': lga,
          'id': DateTime.now().microsecondsSinceEpoch.toString(),
          'uid': uid,
          'photoUrl': photoUrl,
        });
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
    } catch (err) {
      res = err.toString();
      print(err);
    }
    return res;
  }

  //save individual
  Future<String> saveIndividual({
    required String name,
    required String phone,
    required String address,
    required String status,
    required String lga,
    required String ward,
    required String polls,
    String? nin,
    String? bvn,
    String? voter,
    required Uint8List file,
  }) async {
    String res = 'Please enter all the fields';
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      if (name.isNotEmpty &&
          phone.isNotEmpty &&
          address.isNotEmpty &&
          status.isNotEmpty &&
          polls.isNotEmpty &&
          file != null &&
          lga != null &&
          ward != null) {
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('individual_images', file, false);
        //add to database
        await _firestore.collection('Individual').add({
          'name': name,
          'phone': phone,
          'address': address,
          'status': status,
          'polls': polls,
          'nin': nin,
          'bvn': bvn,
          'voter': voter,
          'lga': lga,
          'ward': ward,
          'id': DateTime.now().microsecondsSinceEpoch.toString(),
          'uid': uid,
          'photoUrl': photoUrl,
        });
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
    } catch (err) {
      res = err.toString();
      print(err);
    }
    return res;
  }

  //save masjid
  Future<String> saveMasjid(
      {required String name,
      required String nameRep,
      required String phone,
      required String address,
      required String members,
      required String denomination,
      required String lga,
      required String polls,
      String? nin,
      String? bvn,
      String? voter,
      required Uint8List file}) async {
    String res = 'Please enter all the fields';
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      if (name.isNotEmpty &&
          nameRep.isNotEmpty &&
          phone.isNotEmpty &&
          address.isNotEmpty &&
          members.isNotEmpty &&
          denomination.isNotEmpty &&
          polls.isNotEmpty &&
          file != null &&
          lga != null) {
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('Masjid_images', file, false);
        //add to database
        await _firestore.collection('Masjid').add({
          'name': name,
          'name_rep': nameRep,
          'phone': phone,
          'address': address,
          'members': members,
          'denomination': denomination,
          'polls': polls,
          'nin': nin,
          'bvn': bvn,
          'voter': voter,
          'lga': lga,
          'id': DateTime.now().microsecondsSinceEpoch.toString(),
          'uid': uid,
          'photoUrl': photoUrl,
        });
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
    } catch (err) {
      res = err.toString();
      print(err);
    }
    return res;
  }

  //save church
  Future<String> saveChurch(
      {required String name,
      required String nameRep,
      required String phone,
      required String address,
      required String members,
      required String denomination,
      required String lga,
      required String polls,
      String? nin,
      String? bvn,
      String? voter,
      required Uint8List file}) async {
    String res = 'Please enter all the fields';
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      if (name.isNotEmpty &&
          nameRep.isNotEmpty &&
          phone.isNotEmpty &&
          address.isNotEmpty &&
          members.isNotEmpty &&
          denomination.isNotEmpty &&
          polls.isNotEmpty &&
          file != null &&
          lga != null) {
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('Church_images', file, false);
        //add to database
        await _firestore.collection('Church').add({
          'name': name,
          'name_rep': nameRep,
          'phone': phone,
          'address': address,
          'members': members,
          'denomination': denomination,
          'polls': polls,
          'lga': lga,
          'nin': nin,
          'bvn': bvn,
          'voter': voter,
          'id': DateTime.now().microsecondsSinceEpoch.toString(),
          'uid': uid,
          'photoUrl': photoUrl,
        });
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
    } catch (err) {
      res = err.toString();
      print(err);
    }
    return res;
  }

  //save academia
  Future<String> saveAcademia(
      {required String name,
      String? nin,
      String? bvn,
      String? voter,
      required String institution,
      required String phone,
      required String address,
      required String rank,
      required String ward,
      required String polls,
      // required String polling_unit,
      required String qualification,
      required String lga,
      required Uint8List file}) async {
    String res = 'Please enter all the fields';
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      if (name.isNotEmpty &&
          phone.isNotEmpty &&
          address.isNotEmpty &&
          rank.isNotEmpty &&
          polls.isNotEmpty &&
          //  polling_unit.isNotEmpty &&
          qualification.isNotEmpty &&
          file != null &&
          institution != null &&
          ward != null &&
          lga != null) {
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('Academia_images', file, false);
        //add to database
        await _firestore.collection('Academia').add({
          'name': name,
          'nin': nin,
          'bvn': bvn,
          'voter': voter,
          'institution': institution,
          'phone': phone,
          'address': address,
          'rank': rank,
          'ward': ward,
          'polls': polls,
          //  'polling_unit': polling_unit,
          'qualification': qualification,
          'lga': lga,
          'id': DateTime.now().microsecondsSinceEpoch.toString(),
          'uid': uid,
          'photoUrl': photoUrl,
        });
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
    } catch (err) {
      res = err.toString();
      print(err);
    }
    return res;
  }

//save location political
  Future<String> saveCoordinatesPolitical({
    required double latitude,
    required double longitude,
    required String reference,
    required String category,
  }) async {
    String res = 'Please enter all the fields';
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      if (latitude != null && longitude != null) {
        //add to database
        await _firestore.collection(category).doc(reference).update({
          'latitude': latitude,
          'longitude': longitude,
        });
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //save location residence
  Future<String> saveCoordinatesResidence({
    required double latitude,
    required double longitude,
    required String reference,
  }) async {
    String res = 'Please enter all the fields';
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      if (latitude != null && longitude != null) {
        //add to database
        await _firestore.collection('Residence').doc(reference).update({
          'latitude': latitude,
          'longitude': longitude,
        });
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //save General location
  Future<String> saveGeneralCoordinates({
    required String name,
    required String phone,
    required String category,
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    String res = 'Please enter all the fields';
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      if (name.isNotEmpty &&
          phone.isNotEmpty &&
          address.isNotEmpty &&
          category.isNotEmpty &&
          latitude != null &&
          longitude != null) {
        //add to database
        await _firestore.collection('General Map').doc(name).set({
          'name': name,
          'phone': phone,
          'category': category,
          'latitude': latitude,
          'longitude': longitude,
          'address': address,
        });
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
