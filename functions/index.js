const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

 // notification on adding comment

exports.onWishlist = functions.https.onCall(async (data, context) => {

     
    const authorId = data.authorId;

    const authorDoc = await admin.firestore().collection('users').doc(authorId).get();

    const  authorName = authorDoc.get('name');
    const  authorProfileImg = authorDoc.get('photoUrl');
   // const  storyObj = Object.fromEntries(storyDoc.data());
 
    // const payload = {'icon': authorProfileImg, 'route': 'comment', 'story':JSON.stringify(storyDoc)};
    // const payload = {'icon': authorProfileImg, 'route': 'comment', 'story':JSON.stringify(storyDoc.data())};
    // const payload = {'click_action': 'FLUTTER_NOTIFICATION_CLICK', 'icon': authorProfileImg, 'route': 'comment', storyId: storyId, storyAuthorId: storyAuthorId};
    const payload = {'icon': authorProfileImg, 'route': 'notif'};
       
     await admin.messaging().sendToDevice(
        authorDoc.get('tokens'),
       {
         notification: {
           title: 'New activity on your listing',
           body: authorName + ' wishlisted your post',
         },

        data: payload
       
       },
       {
         // Required for background/quit data-only messages on iOS
         contentAvailable: true,
         // Required for background/quit data-only messages on Android
         priority: 'high',
       }
     );

  });
