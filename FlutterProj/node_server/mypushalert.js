const mypushalert = (deviceToken) => {
    var admin = require("firebase-admin");
    
    var serviceAccount = require("./my-oss-proj-firebase-adminsdk-ujqni-286717e4ba");
    
    if (!admin.apps.length) {
        admin.initializeApp({
            credential: admin.credential.cert(serviceAccount),
            databaseURL: "https://my-oss-proj.firebaseio.com"
          });
    }

    // var registrationToken = deviceToken;
    var payload = {
        notification: {
            title: "치워",
            body: "고객님이 신청하신 대형 폐기물 배출 신청이 정상 승인 처리되어 방문 기사님이 방문할 예정입니다.",
        }
    };

    admin.messaging().sendToDevice(deviceToken, payload)
    .then(function (response){
        console.log("Successfully sent message:", response);
    }).catch(function (error){
        console.log("Error sending message:", error);
    });
};
module.exports = mypushalert;