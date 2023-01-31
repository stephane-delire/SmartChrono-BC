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

}

/*////////////////////////////////////////////////////////*/
/*add Event listener*/
settingBtn.addEventListener("click", tabSetting);