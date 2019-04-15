import "bootstrap";
import "../plugins/flatpickr";
import 'select2/dist/css/select2.css';

import { initSelect2 } from '../components/init_select2';

initSelect2();


flatpickr(".datepicker", {
  allowInput: true,
  enableTime: true
})


document.getElementById("btn-link").addEventListener("click", linkToYoutube);

function linkToYoutube() {
  document.getElementById("demo").innerHTML = Date();
}


// EVERYTHING BELOW IS FOR VIDEO TEST

// 'use strict';

// var Video = require('twilio-video');

// var activeRoom;
// var previewTracks;
// var identity;
// var roomName;

// // Attach the Tracks to the DOM.
// function attachTracks(tracks, container) {
//   tracks.forEach(function(track) {
//     container.appendChild(track.attach());
//   });
// }

// // Attach the Participant's Tracks to the DOM.
// function attachParticipantTracks(participant, container) {
//   var tracks = Array.from(participant.tracks.values());
//   attachTracks(tracks, container);
// }

// // Detach the Tracks from the DOM.
// function detachTracks(tracks) {
//   tracks.forEach(function(track) {
//     track.detach().forEach(function(detachedElement) {
//       detachedElement.remove();
//     });
//   });
// }

// // Detach the Participant's Tracks from the DOM.
// function detachParticipantTracks(participant) {
//   var tracks = Array.from(participant.tracks.values());
//   detachTracks(tracks);
// }

// // When we are about to transition away from this page, disconnect
// // from the room, if joined.
window.addEventListener('beforeunload', leaveRoomIfJoined);


  Rails.ajax({
      url: "/videotokens",
      type: "POST",
      success: data => {
    identity = data.identity;

    document.getElementById('room-controls').style.display = 'block';

    // Bind button to join room
    document.getElementById('button-join').onclick = function () {
      // roomName = document.getElementById('room-name').value;
      roomName = "Skilltransfer video lecture"
      if (roomName) {
        log("Joining chat '" + roomName + "'...");

        var connectOptions = { name: roomName, logLevel: 'debug' };
        if (previewTracks) {
          connectOptions.tracks = previewTracks;
        }

        Twilio.Video.connect(data.token, connectOptions).then(roomJoined, function(error) {
          log('Could not connect to Twilio: ' + error.message);
        });
      } else {
        alert('Please enter a room name.');
      }
    };

    // Bind button to leave room
    document.getElementById('button-leave').onclick = function () {
      log('Leaving room...');
      activeRoom.disconnect();
    };
  }});


// // Obtain a token from the server in order to connect to the Room.
// $.getJSON('/videotokens', function(data) {
//   identity = data.identity;
//   document.getElementById('room-controls').style.display = 'block';

//   // Bind button to join Room.
//   document.getElementById('button-join').onclick = function() {
//     roomName = document.getElementById('room-name').value;
//     if (!roomName) {
//       alert('Please enter a room name.');
//       return;
//     }

//     log("Joining room '" + roomName + "'...");
//     var connectOptions = {
//       name: roomName,
//       logLevel: 'debug'
//     };

//     if (previewTracks) {
//       connectOptions.tracks = previewTracks;
//     }

//     // Join the Room with the token from the server and the
//     // LocalParticipant's Tracks.
//     Video.connect(data.token, connectOptions).then(roomJoined, function(error) {
//       log('Could not connect to Twilio: ' + error.message);
//     });
//   };

//   // Bind button to leave Room.
//   document.getElementById('button-leave').onclick = function() {
//     log('Leaving room...');
//     activeRoom.disconnect();
//   };
// });
  //  Local video preview
  document.getElementById('button-preview').onclick = function() {
    var localTracksPromise = previewTracks
    ? Promise.resolve(previewTracks)
    : Twilio.Video.createLocalTracks();

    localTracksPromise.then(function(tracks) {
      previewTracks = tracks;
      var previewContainer = document.getElementById('local-media');
      if (!previewContainer.querySelector('video')) {
        attachTracks(tracks, previewContainer);
      }
    }, function(error) {
      console.error('Unable to access local media', error);
      log('Unable to access Camera and Microphone');
    });
  };

  // Successfully connected!
  function roomJoined(room) {
    activeRoom = room;

    log("Joined as '" + identity + "'");
    document.getElementById('button-join').style.display = 'none';
    document.getElementById('button-leave').style.display = 'inline';

    // Draw local video, if not already previewing
    var previewContainer = document.getElementById('local-media');
    if (!previewContainer.querySelector('video')) {
      attachParticipantTracks(room.localParticipant, previewContainer);
    }

    room.participants.forEach(function(participant) {
      log("Already in Chat: '" + participant.identity + "'");
      var previewContainer = document.getElementById('remote-media');
      attachParticipantTracks(participant, previewContainer);
    });

    // When a participant joins, draw their video on screen
    room.on('participantConnected', function(participant) {
      log("Joining: '" + participant.identity + "'");
    });

    room.on('trackAdded', function(track, participant) {
      log(participant.identity + " added track: " + track.kind);
      var previewContainer = document.getElementById('remote-media');
      attachTracks([track], previewContainer);
    });

    room.on('trackRemoved', function(track, participant) {
      log(participant.identity + " removed track: " + track.kind);
      detachTracks([track]);
    });

    // When a participant disconnects, note in log
    room.on('participantDisconnected', function(participant) {
      log("Participant '" + participant.identity + "' left the room");
      detachParticipantTracks(participant);
    });

    // When we are disconnected, stop capturing local video
    // Also remove media for all remote participants
    room.on('disconnected', function() {
      log('Left');

      const roomSID = activeRoom.sid;
      // console.log(`....................${identity}`)
      // console.log(`....................${roomSID}`);
      // console.log(`....................${room.localParticipant.sid}`);

      detachParticipantTracks(room.localParticipant);
      room.participants.forEach(detachParticipantTracks);
      activeRoom = null;
      document.getElementById('button-join').style.display = 'inline';
      document.getElementById('button-leave').style.display = 'none';
      const mentorID = document.getElementsByClassName("chat")[0].id.split("A")[0];
    });
  }


  // Activity log
  function log(message) {
    var logDiv = document.getElementById('log');
    logDiv.innerHTML += '<p>&gt;&nbsp;' + message + '</p>';
    logDiv.scrollTop = logDiv.scrollHeight;
  }

  function leaveRoomIfJoined() {
    if (activeRoom) {
      activeRoom.disconnect();
    }
  }

// // Preview LocalParticipant's Tracks.
// document.getElementById('button-preview').onclick = function() {
//   var localTracksPromise = previewTracks
//     ? Promise.resolve(previewTracks)
//     : Video.createLocalTracks();

//   localTracksPromise.then(function(tracks) {
//     window.previewTracks = previewTracks = tracks;
//     var previewContainer = document.getElementById('local-media');
//     if (!previewContainer.querySelector('video')) {
//       attachTracks(tracks, previewContainer);
//     }
//   }, function(error) {
//     console.error('Unable to access local media', error);
//     log('Unable to access Camera and Microphone');
//   });
// };

// // Activity log.
// function log(message) {
//   var logDiv = document.getElementById('log');
//   logDiv.innerHTML += '<p>&gt;&nbsp;' + message + '</p>';
//   logDiv.scrollTop = logDiv.scrollHeight;
// }

// // Leave Room.
// function leaveRoomIfJoined() {
//   if (activeRoom) {
//     activeRoom.disconnect();
//   }
// }


// // SERVER/INDEX

// 'use strict';

// /**
//  * Load Twilio configuration from .env config file - the following environment
//  * variables should be set:
//  * process.env.TWILIO_ACCOUNT_SID
//  * process.env.TWILIO_API_KEY
//  * process.env.TWILIO_API_SECRET
//  */
// require('dotenv').load();

// var http = require('http');
// var path = require('path');
// var AccessToken = require('twilio').jwt.AccessToken;
// var VideoGrant = AccessToken.VideoGrant;
// var express = require('express');
// var randomName = require('./randomname');

// // Create Express webapp.
// var app = express();

// // Set up the paths for the examples.
// [
//   'bandwidthconstraints',
//   'codecpreferences',
//   'localvideofilter',
//   'localvideosnapshot',
//   'mediadevices'
// ].forEach(function(example) {
//   var examplePath = path.join(__dirname, `../examples/${example}/public`);
//   app.use(`/${example}`, express.static(examplePath));
// });

// // Set up the path for the quickstart.
// var quickstartPath = path.join(__dirname, '../quickstart/public');
// app.use('/quickstart', express.static(quickstartPath));

// // Set up the path for the examples page.
// var examplesPath = path.join(__dirname, '../examples');
// app.use('/examples', express.static(examplesPath));

// *
//  * Default to the Quick Start application.

// app.get('/', function(request, response) {
//   response.redirect('/quickstart');
// });

// /**
//  * Generate an Access Token for a chat application user - it generates a random
//  * username for the client requesting a token, and takes a device ID as a query
//  * parameter.
//  */
// app.get('/token', function(request, response) {
//   var identity = 'frank test';

//   // Create an access token which we will sign and return to the client,
//   // containing the grant we just created.
//   var token = new AccessToken(
//     process.env.TWILIO_ACCOUNT_SID,
//     process.env.TWILIO_API_KEY,
//     process.env.TWILIO_API_SECRET
//   );

//   // Assign the generated identity to the token.
//   token.identity = identity;

//   // Grant the access token Twilio Video capabilities.
//   var grant = new VideoGrant();
//   token.addGrant(grant);

//   // Serialize the token to a JWT string and include it in a JSON response.
//   response.send({
//     identity: identity,
//     token: token.toJwt()
//   });
// });

// // Create http server and run it.
// var server = http.createServer(app);
// var port = process.env.PORT || 3000;
// server.listen(port, function() {
//   console.log('Express server running on *:' + port);
// });
