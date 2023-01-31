/*////////////////////////////////////////////////////////*/
/*Open Help*/

function tabHelp(){
	//Set color to buttons
	document.getElementById("timerBtn").style.color="#444";
	document.getElementById("syncBtn").style.color="#444";
	document.getElementById("settingBtn").style.color="#444";
	document.getElementById("helpBtn").style.color="#ff6600";

	//Reset mainScreen
	mainScreen.innerHTML = "";

}

/*////////////////////////////////////////////////////////*/
/*add Event listener*/
helpBtn.addEventListener("click", tabHelp);