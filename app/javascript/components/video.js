// const { connect } = require('twilio-video');

// const token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTS2FiMmY3YmJkZDVkY2NlZDRmNmQxMDFhODI4ZjczYjYxLTE1NTQ5Njg1OTciLCJpc3MiOiJTS2FiMmY3YmJkZDVkY2NlZDRmNmQxMDFhODI4ZjczYjYxIiwic3ViIjoiQUMzYTc3NTEzODEwYzg1MjA5ZmFjODhlZjZjMzYxNWYyMSIsImV4cCI6MTU1NDk3MjE5NywiZ3JhbnRzIjp7ImlkZW50aXR5IjoidGVzdCIsInZpZGVvIjp7fX19.E3ztGAtF536UIXsgIz4r0twLTd2PoPrmDXlP2YCUKbE'

// connect(token, { name:'my-new-room' }).then(room => {
//   console.log(`Successfully joined a Room: ${room}`);
//   room.on('participantConnected', participant => {
//     console.log(`A remote Participant connected: ${participant}`);
//   });
// }, error => {
//   console.error(`Unable to connect to Room: ${error.message}`);
// });
