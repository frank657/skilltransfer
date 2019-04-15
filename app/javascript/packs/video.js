  // EVERYTHING BELOW IS FOR VIDEO TEST
import Rails from 'rails-ujs';
  'use strict';
//
  // var Video = require('twilio-video');

  var activeRoom;
  var previewTracks;
  var identity;
  var roomName;


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
  }
});


  // Attach the Tracks to the DOM.
  function attachTracks(tracks, container) {
    tracks.forEach(function(track) {
      container.appendChild(track.attach());
    });
  }

  // Attach the Participant's Tracks to the DOM.
  function attachParticipantTracks(participant, container) {
    var tracks = Array.from(participant.tracks.values());
    attachTracks(tracks, container);
  }

  // Detach the Tracks from the DOM.
  function detachTracks(tracks) {
    tracks.forEach(function(track) {
      track.detach().forEach(function(detachedElement) {
        detachedElement.remove();
      });
    });
  }

  // Detach the Participant's Tracks from the DOM.
  function detachParticipantTracks(participant) {
    var tracks = Array.from(participant.tracks.values());
    detachTracks(tracks);
  }


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
