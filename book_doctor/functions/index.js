const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

// Function to generate initial availability data for doctors
exports.initializeDoctorAvailability = functions.https.onRequest(async (req, res) => {
    // name of collection
    const doctorsRef = db.collection('Doctors');
    const doctorsSnapshot = await doctorsRef.get();

    doctorsSnapshot.forEach(async (doc) => {
        const doctorId = doc.id;
        const availability = generateAvailabilityData();
        // Add the new date in Firebase Cloud
        await doctorsRef.doc(doctorId).update({"Available": availability})
    });
    // The res after this Function done 
    res.send('Initialization complete');
});

// Helper function to generate availability data
function generateAvailabilityData() {
    const availability = {};

    // Generate availability for the next 30 days
    for (let i = 0; i < 30; i++) {
        // Add the date , when Function work , will make check the real time like the days 
        const date = new Date();
        // To get the date and another day , if today is 7/7 , so will add + i , so it will be 7/8
        date.setDate(date.getDate() + i);

        const dateString = formatDate(date);

        // Generate time slots for each day
        const timeSlots = {};
        // the hours from 9 to 15
        for (let hour = 9; hour <= 15; hour++) {
            const timeString = `${hour}:00`;
            timeSlots[timeString] = false; // Initialize all slots as false
        }

        availability[dateString] = timeSlots;
    }

    return availability;
}

// Helper function to format date as 'MM/DD'
function formatDate(date) {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
}


// delete 
// Function to delete availability data for all doctors
exports.deleteDoctorAvailability = functions.https.onRequest(async (req, res) => {
    const doctorsRef = db.collection('Doctors');
    const doctorsSnapshot = await doctorsRef.get();

    const batch = db.batch();

    doctorsSnapshot.forEach((doc) => {
        const availabilityRef = doctorsRef.doc(doc.id).collection('availability').doc('schedule');
        batch.delete(availabilityRef);
    });

    await batch.commit();

    res.send('Deletion complete');
});
