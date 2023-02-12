/*////////////////////////////////////////////////////////*/
/*Open Setting*/

function tabSetting(){
	//Set color to buttons
	document.getElementById("timerBtn").style.color="#444";
	document.getElementById("syncBtn").style.color="#444";
	document.getElementById("settingBtn").style.color="#ff6600";
	document.getElementById("helpBtn").style.color="#444";

	//Reset mainScreen
	mainScreen.innerHTML = "";

	///////////////////////////////////////////////////////
	//Create general div
	const divSetting = document.createElement("div");

	///////////////////////////////////////////////////////
	//Create User ID
	const divUserId = document.createElement("div");
	const txtUserId = document.createElement("div");
	const inpUserId = document.createElement("input");

	//Set Style
	divSetting.style.width = "100%";
	divSetting.style.height = "100%";
	divSetting.style.display = "flex";
	divSetting.style.flexDirection = 'column';

	txtUserId.style.color = "white";
	txtUserId.style.textAlign = 'center';
	txtUserId.innerHTML = "User ID";
	txtUserId.style.marginTop = "10px";

	inpUserId.setAttribute("id", "inUserID");
	inpUserId.setAttribute("type", "text");
	inpUserId.style.width = "100%";
	inpUserId.style.height = "40px";
	inpUserId.style.backgroundColor = "transparent";
	inpUserId.style.color = "orange";
	inpUserId.style.fontSize = "32px";
	inpUserId.style.border = "2px solid #444";
	inpUserId.style.borderRadius = "10px";
	inpUserId.style.marginBottom = "20px";

	//Append to DOMs
	divUserId.append(txtUserId);
	divUserId.append(inpUserId);

	divSetting.append(divUserId);
	mainScreen.append(divSetting);

	///////////////////////////////////////////////////////
	//Create POST link
	const divPostLink = document.createElement("div");
	const txtPostLink = document.createElement("div");
	const inpPostLink = document.createElement("input");

	//Set Style
	txtPostLink.style.color = "white";
	txtPostLink.style.textAlign = 'center';
	txtPostLink.innerHTML = "POST Link";
	txtPostLink.style.marginTop = "10px";

	inpPostLink.setAttribute("id", "inPostLink");
	inpPostLink.setAttribute("type", "text");
	inpPostLink.style.width = "100%";
	inpPostLink.style.height = "40px";
	inpPostLink.style.backgroundColor = "transparent";
	inpPostLink.style.color = "orange";
	inpPostLink.style.fontSize = "32px";
	inpPostLink.style.border = "2px solid #444";
	inpPostLink.style.borderRadius = "10px";
	inpPostLink.style.marginBottom = "20px";

	//Append to DOMs
	divPostLink.append(txtPostLink);
	divPostLink.append(inpPostLink);

	divSetting.append(divPostLink);

	///////////////////////////////////////////////////////
	//Create record button
	const divBtnRecordSetting = document.createElement("div");
	const btnRecordSetting = document.createElement("div");

	//SVG
	const saveSettingIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M42 13.85V39q0 1.2-.9 2.1-.9.9-2.1.9H9q-1.2 0-2.1-.9Q6 40.2 6 39V9q0-1.2.9-2.1Q7.8 6 9 6h25.15Zm-18 21.9q2.15 0 3.675-1.525T29.2 30.55q0-2.15-1.525-3.675T24 25.35q-2.15 0-3.675 1.525T18.8 30.55q0 2.15 1.525 3.675T24 35.75ZM11.65 18.8h17.9v-7.15h-17.9Z"/></svg>'

	//Set Style
	divBtnRecordSetting.style.display = "flex";
	divBtnRecordSetting.style.justifyContent = 'center';
	divBtnRecordSetting.style.alignItems = 'center';

	btnRecordSetting.setAttribute("id", "btnRecordSetting");
	btnRecordSetting.innerHTML = saveSettingIco;
	btnRecordSetting.style.display = "flex";
	btnRecordSetting.style.justifyContent = 'center';
	btnRecordSetting.style.alignItems = 'center';
	btnRecordSetting.style.backgroundColor = "#444";
	btnRecordSetting.style.color = "black";
	btnRecordSetting.style.width = "75px";
	btnRecordSetting.style.height = "75px";
	btnRecordSetting.style.borderRadius = "50%";

	//Append to DOMs
	divBtnRecordSetting.append(btnRecordSetting);
	divSetting.append(divBtnRecordSetting);

	//Add click event
	btnRecordSetting.addEventListener("click", saveSettings);

	//try to retrieve settings if exist:
	if (localStorage.getItem("USER_ID") != null) {inpUserId.value = localStorage.getItem("USER_ID")}
	if (localStorage.getItem("POST_LINK") != null) {inpPostLink.value = localStorage.getItem("POST_LINK")}
}

/*////////////////////////////////////////////////////////*/
/*add Event listener*/
settingBtn.addEventListener("click", tabSetting);