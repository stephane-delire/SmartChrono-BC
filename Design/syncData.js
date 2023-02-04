/*////////////////////////////////////////////////////////*/
// Sync data to server

//SVG
const btnSyncIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48" fill="currentColor"><path d="M8.35 40v-3h6.5l-.75-.6q-3.2-2.55-4.65-5.55-1.45-3-1.45-6.7 0-5.3 3.125-9.525Q14.25 10.4 19.35 8.8v3.1q-3.75 1.45-6.05 4.825T11 24.15q0 3.15 1.175 5.475 1.175 2.325 3.175 4.025l1.5 1.05v-6.2h3V40Zm20.35-.75V36.1q3.8-1.45 6.05-4.825T37 23.85q0-2.4-1.175-4.875T32.75 14.6l-1.45-1.3v6.2h-3.05V8h11.5v3h-6.5l.75.7q3 2.8 4.5 6t1.5 6.15q0 5.3-3.1 9.55-3.1 4.25-8.2 5.85Z"/></svg>'
const btnSyncProblemIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48" fill="currentColor"><path d="M6.6 40v-3h6.15l-.7-.7q-3-3-4.325-6.075Q6.4 27.15 6.4 24.2q0-5.45 3.125-9.75T17.75 8.5v3.1q-3.8 1.5-6.075 4.95Q9.4 20 9.4 24.2q0 2.6.875 4.925.875 2.325 2.975 4.225l1.5 1.35v-5.85h3V40ZM24 33.9q-.6 0-1.05-.45-.45-.45-.45-1.05 0-.6.45-1.05.45-.45 1.05-.45.6 0 1.05.45.45.45.45 1.05 0 .6-.45 1.05-.45.45-1.05.45Zm-1.4-7.4V14.05h3V26.5Zm7.65 13.05V36.4q3.8-1.45 6.075-4.9 2.275-3.45 2.275-7.65 0-2.7-.9-5.025t-2.95-4.175l-1.5-1.35v5.85h-3V8H41.4v3h-6.2l.75.7q3.1 2.85 4.375 6t1.275 6.15q0 5.4-3.15 9.725-3.15 4.325-8.2 5.975Z"/></svg>'
const btnSyncDone = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48" fill="currentColor"><path d="M14.7 35.9 3.5 24.7l2.15-2.15 9.05 9.05 2.15 2.15Zm8.5 0L12 24.7l2.15-2.15 9.05 9.05 19.2-19.2 2.15 2.15Zm0-8.5-2.15-2.15L33.9 12.4l2.15 2.15Z"/></svg>'
const btnSyncError = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48" fill="currentColor"><path d="M2 42 24 4l22 38Zm22.2-5.85q.65 0 1.075-.425.425-.425.425-1.075 0-.65-.425-1.075-.425-.425-1.075-.425-.65 0-1.075.425Q22.7 34 22.7 34.65q0 .65.425 1.075.425.425 1.075.425Zm-1.5-5.55h3V19.4h-3Z"/></svg>'

/*////////////////////////////////////////////////////////*/
// In the beginning change text and ico
function testSync(){

	const user_id = localStorage.getItem("USER_ID");
	const post_link = localStorage.getItem("POST_LINK");
	const record = localStorage.getItem("RECORD");
	var err = 0;

	// Check if settings exist
	if (user_id == null) {console.error("USER_ID is null"); err++;}
	if (post_link == null) {console.error("POST_LINK is null"); err++;}

	if (err > 0) {
		btnSync.innerHTML = btnSyncError;
		btnSync.style.color = "red";
		txtSync.innerHTML = 'The "USER_ID" and "POST_LINK" parameters are not configured correctly. Please check your settings.';
		return;
	}

	// Validate post_link with regExp
	function isValidUrl(str) {
		const pattern = new RegExp(
			'^([a-zA-Z]+:\\/\\/)?' + // protocol
			'((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|' + // domain name
			'((\\d{1,3}\\.){3}\\d{1,3}))' + // OR IP (v4) address
			'(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*' + // port and path
			'(\\?[;&a-z\\d%_.~+=-]*)?' + // query string
			'(\\#[-a-z\\d_]*)?$', // fragment locator
			'i'
		);
  		return pattern.test(str);
	};
	if (isValidUrl(post_link) == false) {
		btnSync.innerHTML = btnSyncError;
		btnSync.style.color = "red";
		txtSync.innerHTML = 'The "POST_LINK" parameter does not appear to be valid. Please check your settings.';
		return;
	}

	// Check if there are some record in pending
	if (record == null || record == "") {
		btnSync.innerHTML = btnSyncDone;
		btnSync.style.color = "green";
		txtSync.innerHTML = "No records awaiting synchronization.";
		return;
	}

	else {
		txtSync.innerHTML = "You have records ready waiting to be synchronized."
		btnSync.innerHTML = btnSyncIco;
		btnSync.style.color = 'black';
		btnSync.addEventListener("click", startSync);
	}
}

// sync -> Send data to serveur
function startSync(){

	const user_id = localStorage.getItem("USER_ID");
	const post_link = localStorage.getItem("POST_LINK");
	const record = localStorage.getItem("RECORD");
	
	const date = new Date();
	var year = date.toLocaleString("default", {year: "numeric"});
	var month = date.toLocaleString("default", {month: "2-digit"});
	var day = date.toLocaleString("default", {day: "2-digit"});
	var hour = date.toLocaleString("default", {hour: "2-digit"});
	var minutes = date.toLocaleString("default", {minute: "2-digit"});
	var fDate = day + "-" + month + "-" + year + " " + hour + ":" + minutes;

	statusBar.style.color = 'green';
	statusBar.innerHTML = "Creating packet"
	var packet = {
		"USER_ID": user_id,
		"DATE": fDate,
		"RECORD": record
	}
	packet = JSON.stringify(packet);


	statusBar.style.color = 'white'
	statusBar.innerHTML = "Creating HTTP Request";
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState != 4){
			statusBar.innerHTML = "Waiting...";
		}
		if (this.readyState == 4 && this.status == 200){
			//All good!
			statusBar.innerHTML = "";
			endSync();
		}
		if (this.readyState == 4 && this.status != 200){
			statusBar.innerHTML = "synchronization error...";
			errSync(this.status);
		}
	}
	statusBar.innerHTML = "Opening HTTP Request";
	xhttp.open("POST", post_link);
	statusBar.innerHTML = "Sending packet over HTTP";
	xhttp.send(packet);


}

// After sync success
function endSync(){
	//erase all records
	localStorage.setItem("RECORD", "")

	txtSync.innerHTML = "Synchronization successful."
	btnSync.innerHTML = btnSyncDone;
	btnSync.style.color = "green";

	setTimeout(eraseStatusBar, 1000);
}

// Error sync...
function errSync(code){
	btnSync.innerHTML = btnSyncProblemIco;
	btnSync.style.color = "red";

	switch (code){
	case 404:
		txtSync.innerHTML = 'Synchronization failed (404) you should check the "POST_LINK" parameter in the settings.';
		break;
	case 401:
		txtSync.innerHTML = 'Synchronization failed (401) you should check the "USER_ID" parameter in the settings.';
		break;
	case 418:
		txtSync.innerHTML = 'Synchronization failed (418) i refuse to prepare coffee because I am a teapot!';
		btnSync.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48" fill="currentColor"><path d="M8 42v-3h31.95v3Zm7.55-6q-3.15 0-5.35-2.175Q8 31.65 8 28.5V6h9.85v4.65l-3.6 2.9q-.05.05-.45.9v7.5q0 .5.35.85t.9.35h7.55q.55 0 .9-.35t.35-.85v-7.5q0-.25-.45-.9l-3.55-2.9V6H41q1.25 0 2.125.875T44 9v8q0 1.25-.875 2.125T41 20h-4.8v8.5q0 3.15-2.2 5.325Q31.8 36 28.65 36ZM36.2 17H41V9h-4.8Z"/></svg>'
		btnSync.style.color = "purple";
		break;
	default:
		txtSync.innerHTML = `Synchronization failed (${code}).`;
	}

	setTimeout(eraseStatusBar, 1000);
}

// Erase statusBar
function eraseStatusBar(){
	statusBar.innerHTML = "";
}