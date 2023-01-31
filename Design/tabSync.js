/*////////////////////////////////////////////////////////*/
/*Open Sync*/

function tabSync(){
	//Set color to buttons
	document.getElementById("timerBtn").style.color="#444";
	document.getElementById("syncBtn").style.color="#ff6600";
	document.getElementById("settingBtn").style.color="#444";
	document.getElementById("helpBtn").style.color="#444";

	//Reset mainScreen
	mainScreen.innerHTML = "";

	///////////////////////////////////////////////////////
	//Create button for sync
	const divSyncMain = document.createElement("div");
	const btnSync = document.createElement("div");
	const txtSync = document.createElement("div");

	//SVG
	const btnSyncIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M8.35 40v-3h6.5l-.75-.6q-3.2-2.55-4.65-5.55-1.45-3-1.45-6.7 0-5.3 3.125-9.525Q14.25 10.4 19.35 8.8v3.1q-3.75 1.45-6.05 4.825T11 24.15q0 3.15 1.175 5.475 1.175 2.325 3.175 4.025l1.5 1.05v-6.2h3V40Zm20.35-.75V36.1q3.8-1.45 6.05-4.825T37 23.85q0-2.4-1.175-4.875T32.75 14.6l-1.45-1.3v6.2h-3.05V8h11.5v3h-6.5l.75.7q3 2.8 4.5 6t1.5 6.15q0 5.3-3.1 9.55-3.1 4.25-8.2 5.85Z"/></svg>'
	const btnSyncProblemIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M6.6 40v-3h6.15l-.7-.7q-3-3-4.325-6.075Q6.4 27.15 6.4 24.2q0-5.45 3.125-9.75T17.75 8.5v3.1q-3.8 1.5-6.075 4.95Q9.4 20 9.4 24.2q0 2.6.875 4.925.875 2.325 2.975 4.225l1.5 1.35v-5.85h3V40ZM24 33.9q-.6 0-1.05-.45-.45-.45-.45-1.05 0-.6.45-1.05.45-.45 1.05-.45.6 0 1.05.45.45.45.45 1.05 0 .6-.45 1.05-.45.45-1.05.45Zm-1.4-7.4V14.05h3V26.5Zm7.65 13.05V36.4q3.8-1.45 6.075-4.9 2.275-3.45 2.275-7.65 0-2.7-.9-5.025t-2.95-4.175l-1.5-1.35v5.85h-3V8H41.4v3h-6.2l.75.7q3.1 2.85 4.375 6t1.275 6.15q0 5.4-3.15 9.725-3.15 4.325-8.2 5.975Z"/></svg>'

	//Set Style
	divSyncMain.style.height = "100%";
	divSyncMain.style.display = 'flex';
	divSyncMain.style.flexDirection = 'column';
	divSyncMain.style.justifyContent = 'center';
	divSyncMain.style.alignItems = 'center';

	btnSync.style.width = "75px";
	btnSync.style.height = "75px";
	btnSync.style.backgroundColor = '#444';
	btnSync.style.borderRadius = '50%';
	btnSync.style.display = "flex";
	btnSync.style.justifyContent = "center";
	btnSync.style.alignItems = "center";
	btnSync.innerHTML = btnSyncProblemIco;

	txtSync.style.color = "white";
	txtSync.style.minHeight = "50px";
	txtSync.style.marginTop = "30px";
	txtSync.innerHTML = "Test";



	//Append to DOMs
	divSyncMain.append(btnSync);
	divSyncMain.append(txtSync);
	mainScreen.append(divSyncMain);


}

/*////////////////////////////////////////////////////////*/
/*add Event listener*/
syncBtn.addEventListener("click", tabSync);