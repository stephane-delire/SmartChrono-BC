/*////////////////////////////////////////////////////////*/
// Save Chrono in localStorage
function saveChrono() {
	
	//Generate an identifier for the record
	//Must have the date + another random thing to be unique
	var date = new Date();

	var year = date.toLocaleString("default", {year: "numeric"});
	var month = date.toLocaleString("default", {month: "2-digit"});
	var day = date.toLocaleString("default", {day: "2-digit"});
	var hour = date.toLocaleString("default", {hour: "2-digit"});
	var minutes = date.toLocaleString("default", {minute: "2-digit"});
	var fDate = day + "-" + month + "-" + year + " " + hour + ":" + minutes;


	/*///////////////////////////////////////////////////*/
	//Function to generate a random string 
	function generateRandomString(length) {
		const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
		let result = '';
		for (let i = 0; i < length; i++) {
			result += characters.charAt(Math.floor(Math.random() * characters.length));
		}
		return result;
		}
	///////////////////////////////////////////////////////

	//Identifier
	const identifier = fDate + "--" + generateRandomString(8);
	
	//Data gathering
	var data = {
		"date": fDate,
		"project": PROJECT,
		"task": TASK,
		"duration": duration,
		"identifier": identifier
	}
	data = JSON.stringify(data);

	//Store in local file system under key "RECORD"
	//need to verify if the dictionnary exist, if not we need to create it before appening new record
	const existingData = localStorage.getItem("RECORD");
	let storage = existingData ? JSON.parse(existingData) : {};
	//Append new record in storage :
	storage[identifier] = data;
	//Save :
	localStorage.setItem("RECORD", JSON.stringify(storage));

	//Reset
	duration = 0;
	PROJECT = "";
	TASK = "";
	//Return to tabChrono
	tabChrono();

}