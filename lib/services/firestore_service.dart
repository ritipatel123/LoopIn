import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // create a new user profile in firestore
  Future<void> createUser(String userID, String username, String email) async {
    await _db.collection('users').doc(userID).set({
      'username': username,
      'email': email,
      'profilePic': '',
      'bio': '',
      'hostedEvents': [],
      'joinedEvents': [],
      'followersCount': 0,
      'followingCount': 0,
    });
  }


  // create an event
  Future<void> createEvent(String userID, String title, String description, DateTime date, String location) async {
    DocumentReference eventRef = _db.collection('events').doc();

    await eventRef.set({
      'eventID': eventRef.id,
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),
      'location': location,
      'hostID': userID,
      'participantsCount': 0,
    });

    await _db.collection('users').doc(userID).update({
      'hostedEvents': FieldValue.arrayUnion([eventRef.id])
    });
  }


  // join an event
  Future<void> joinEvent(String userID, String eventID) async {
    DocumentReference eventRef = FirebaseFirestore.instance.collection('events').doc(eventID);

    await eventRef.collection('participants').doc(userID).set({'joinedAt': Timestamp.now()});
    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      'joinedEvents': FieldValue.arrayUnion([eventID])
    });

    // Increment participants count
    await eventRef.update({
      'participantsCount': FieldValue.increment(1)
    });
  }


  // follow a user
  Future<void> followUser(String currentUserID, String targetUserID) async {
    DocumentReference currentUserRef = FirebaseFirestore.instance.collection('users').doc(currentUserID);
    DocumentReference targetUserRef = FirebaseFirestore.instance.collection('users').doc(targetUserID);

    await currentUserRef.collection('following').doc(targetUserID).set({'followedAt': Timestamp.now()});
    await targetUserRef.collection('followers').doc(currentUserID).set({'followedAt': Timestamp.now()});

    await currentUserRef.update({'followingCount': FieldValue.increment(1)});
    await targetUserRef.update({'followersCount': FieldValue.increment(1)});
  }


  // query all events 
  // sort by recommended later
  Future<List<DocumentSnapshot>> queryEvents() async {
    QuerySnapshot snapshot = await _db
        .collection('events')
        .orderBy('date', descending: false)
        .limit(20)
        .get();

    return snapshot.docs;
  }


  // query all events hosted by a specific user
  Future<List<DocumentSnapshot>> getHostedEvents(String userID) async {
    DocumetSnapshot userDoc = await _db.collection('users').doc(userID).get();
    List hostedEventIDs = userDoc['hostedEvents'];

    if (hostedEventIDs.isEmpty) return [];

    QuerySnapshot eventsSnapshot = await _db
      .collection('events')
      .where(FieldPath.documentId, whereIn: hostedEventIDs)
      .get();

    return eventsSnapshot.docs;
  }

  // query all events a user has joined
  Future<List<DocumentSnapshot>> getJoinedEvents(String userID) async {
    DocumentSnapshot userDoc = await _db.collection('users').doc(userID).get();
    List joinedEventIDs = userDoc['joinedEvents'];

    if (joinedEventIDs.isEmpty) return [];

    QuerySnapshot eventsSnapshot = await _db
      .collection('events')
      .where(FieldPath.documentId, whereIn: joinedEventIDs)
      .get();

    return eventsSnapshot.docs;
  }


  // follow a User
  Future<void> followUser(String currentUserID, String targetUserID) async {
    DocumentReference currentUserRef = _db.collection('users').doc(currentUserID);
    DocumentReference targetUserRef = _db.collection('users').doc(targetUserID);

    await currentUserRef.collection('following').doc(targetUserID).set({'followedAt': Timestamp.now()});
    await targetUserRef.collection('followers').doc(currentUserID).set({'followedAt': Timestamp.now()});

    await currentUserRef.update({'followingCount': FieldValue.increment(1)});
    await targetUserRef.update({'followersCount': FieldValue.increment(1)});
  }


  // unfollow a User
  Future<void> unfollowUser(String currentUserID, String targetUserID) async {
    DocumentReference currentUserRef = _db.collection('users').doc(currentUserID);
    DocumentReference targetUserRef = _db.collection('users').doc(targetUserID);

    await currentUserRef.collection('following').doc(targetUserID).delete();
    await targetUserRef.collection('followers').doc(currentUserID).delete();

    await currentUserRef.update({'followingCount': FieldValue.increment(-1)});
    await targetUserRef.update({'followersCount': FieldValue.increment(-1)});
  }


  // query all of a user's followers
  Future<List<String>> getFollowers(String userID) async {
    QuerySnapshot snapshot = await _db
        .collection('users')
        .doc(userID)
        .collection('followers')
        .get();

    return snapshot.docs.map((doc) => doc.id).toList();
  }


  // query all of a user's following
  Future<List<String>> getFollowing(String userID) async {
    QuerySnapshot snapshot = await _db
        .collection('users')
        .doc(userID)
        .collection('following')
        .get();

    return snapshot.docs.map((doc) => doc.id).toList();
  }
}