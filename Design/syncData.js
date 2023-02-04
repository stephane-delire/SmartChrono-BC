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

	statusBar.style.color = 'white'
	statusBar.innerHTML = "Opening HTTP Request";

	

}