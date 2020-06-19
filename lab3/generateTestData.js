// Generate a random date
var day = 1000 * 60 * 60 * 24;
function randomDate() {
  return new Date(Date.now() - (Math.floor(Math.random() * day)));
}

// Generate a random string
function randomString() {
  // Base 36 uses letters and digits to represent a number:
  return (Math.random()+1).toString(36).substring(2);
}

// Generate an array for tire pressures for all the tires
function tirePsiArray(tires, min, max) {
  var arr = [];
  for (var i = 1; i <= tires; ++i) {
    arr.push(randomNumber(min, max));
  }
  return arr;
}

// Generate a random number within the min max range
function randomNumber(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

// Main driver of the script
try {
  db = db.getSiblingDB('trucking');

  for (var i = 1; i <= 10000; ++i) {
    db.checkpoints.insert({
      truckId: i,
      companyId: randomNumber(1, 100),
      driverId: randomNumber(1, 500),
      name: randomString(),
      at: randomDate(),
      latitude: randomNumber(19.50139, 64.85694),
      longitude: randomNumber(-161.75583, -68.01197),
      tirePsi: tirePsiArray(18, 1, 35)
    });
  }
} catch (e) {
  print (e);
}

