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

	///////////////////////////////////////////////////////
	//Img Burniaux consulting
	const imgBurniauxConsulting = 'data:image/png;base64,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'

	///////////////////////////////////////////////////////
	//Create help page in style of Burniaux-consulting website

	const divHelp = document.createElement("div");
	divHelp.style.width = "100%";
	divHelp.style.height = "100%";
	divHelp.style.display = "flex";
	divHelp.style.justifyContent = 'center';
	divHelp.style.alignItems = 'center';

	mainScreen.append(divHelp);

	const divSite = document.createElement("div");
	divSite.style.width = "100%";
	divSite.style.height = "50%";
	divSite.style.maxWidth = "450px";
	divHelp.append(divSite);

	//First row
	const firstRow = document.createElement("div");
	firstRow.style.height = "33%";
	firstRow.style.backgroundColor = "white";

	const imgHelp = document.createElement("img");
	firstRow.append(imgHelp);
	imgHelp.setAttribute("src", imgBurniauxConsulting);
	imgHelp.setAttribute("preserveAspectRatio", "xMidYMid");
	imgHelp.setAttribute("height", "100%");

	divSite.append(firstRow);

	//Second row
	const secondRow = document.createElement("div");
	divSite.append(secondRow);
	secondRow.style.height = "33%";
	secondRow.style.backgroundColor = "rgb(53, 151, 156)";
	secondRow.style.color = "white";
	secondRow.style.display = "flex";
	secondRow.style.justifyContent = 'center';
	secondRow.style.alignItems = "center";
	secondRow.innerHTML = "Un petit texte :)";

	//Third row
	const thirdRow = document.createElement("div");
	divSite.append(thirdRow);
	thirdRow.style.backgroundColor = 'rgb(56, 62, 69)';
	thirdRow.style.height = "33%";
	thirdRow.style.color = "rgb(53, 151, 156)";
	thirdRow.style.display = "flex";
	thirdRow.style.alignItems = 'center';
	thirdRow.style.justifyContent = "flex-end";
	thirdRow.style.paddingRight = '5px';
	thirdRow.innerHTML = "francois@burniaux.com<br>+32 4 86 895 990"
}

/*////////////////////////////////////////////////////////*/
/*add Event listener*/
helpBtn.addEventListener("click", tabHelp);