/*////////////////////////////////////////////////////////*/
//Save settings
function saveSettings() {

	const userId = inUserID.value;
	const postLink = inPostLink.value;

	//Save to localStorage
	localStorage.setItem("USER_ID", userId);
	localStorage.setItem("POST_LINK", postLink);

	const saveSettingsDoneIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48" fill="currentColor"><path d="M14.7 35.9 3.5 24.7l2.15-2.15 9.05 9.05 2.15 2.15Zm8.5 0L12 24.7l2.15-2.15 9.05 9.05 19.2-19.2 2.15 2.15Zm0-8.5-2.15-2.15L33.9 12.4l2.15 2.15Z"/></svg>'
	btnRecordSetting.innerHTML = saveSettingsDoneIco;
	btnRecordSetting.style.color = "green";
}
