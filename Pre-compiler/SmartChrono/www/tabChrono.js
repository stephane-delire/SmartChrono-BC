/*////////////////////////////////////////////////////////*/
/*Open Chrono*/

function tabChrono(){
	//Set color to buttons
	document.getElementById("timerBtn").style.color="#ff6600";
	document.getElementById("syncBtn").style.color="#444";
	document.getElementById("settingBtn").style.color="#444";
	document.getElementById("helpBtn").style.color="#444";

	//Reset mainScreen
	mainScreen.innerHTML = "";

	///////////////////////////////////////////////////////
	//Create project name
	const divProjectName = document.createElement("div");
	const txtProjectName = document.createElement("div");
	const inpProjectName = document.createElement("input");

	//Set styles
	txtProjectName.innerHTML = "Project";
	txtProjectName.style.color = "white";
	txtProjectName.style.textAlign = "center";

	inpProjectName.setAttribute("type", "text");
	inpProjectName.setAttribute("id", "inProjectName");
	inpProjectName.style.width = "100%";
	inpProjectName.style.height = "40px";
	inpProjectName.style.backgroundColor = "transparent";
	inpProjectName.style.color = "orange";
	inpProjectName.style.fontSize = "32px";
	inpProjectName.style.border = "2px solid #444";
	inpProjectName.style.borderRadius = "10px";
	inpProjectName.style.marginBottom = "20px";

	//Append DOMs
	divProjectName.append(txtProjectName);
	divProjectName.append(inpProjectName);

	mainScreen.append(divProjectName);

	///////////////////////////////////////////////////////
	//Create task
	const divTaskName = document.createElement("div");
	const txtTaskName = document.createElement("div");
	const inpTaskName = document.createElement("input");

	//Set styles
	txtTaskName.innerHTML = "Task";
	txtTaskName.style.color = "white";
	txtTaskName.style.textAlign = "center";

	inpTaskName.setAttribute("type", "text");
	inpTaskName.setAttribute("id", "inTaskName");
	inpTaskName.style.width = "100%";
	inpTaskName.style.height = "40px";
	inpTaskName.style.backgroundColor = "transparent";
	inpTaskName.style.color = "orange";
	inpTaskName.style.fontSize = "32px";
	inpTaskName.style.border = "2px solid #444";
	inpTaskName.style.borderRadius = "10px";
	inpTaskName.style.marginBottom = "20px";

	//Append DOMs
	divTaskName.append(txtTaskName);
	divTaskName.append(inpTaskName);

	mainScreen.append(divTaskName);

	///////////////////////////////////////////////////////
	//Create Start button
	const divStartBtn = document.createElement("div");
	const startBtn = document.createElement("div");

	//SVG
	const playIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48" fill="currentColor"><path d="M19.15 32.5 32.5 24l-13.35-8.5ZM24 44q-4.1 0-7.75-1.575-3.65-1.575-6.375-4.3-2.725-2.725-4.3-6.375Q4 28.1 4 24q0-4.15 1.575-7.8 1.575-3.65 4.3-6.35 2.725-2.7 6.375-4.275Q19.9 4 24 4q4.15 0 7.8 1.575 3.65 1.575 6.35 4.275 2.7 2.7 4.275 6.35Q44 19.85 44 24q0 4.1-1.575 7.75-1.575 3.65-4.275 6.375t-6.35 4.3Q28.15 44 24 44Z"/></svg>'
	const disablePlayIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48" fill="currentColor"><path d="M31.75 28.2 16.6 13.4V9.85l22 14Zm7.9 16.35L26.6 31.5l-10 6.35V21.5L3.5 8.35l2.1-2.1 36.2 36.2Z"/></svg>'

	//Set styles
	divStartBtn.style.position = 'absolute';
	divStartBtn.style.bottom = '30px';
	divStartBtn.style.width = '100%';
	divStartBtn.style.display = "flex";
	divStartBtn.style.justifyContent = 'center';

	startBtn.innerHTML = disablePlayIco;
	startBtn.style.display = "flex";
	startBtn.style.justifyContent = 'center';
	startBtn.style.alignItems = 'center';
	startBtn.style.backgroundColor = "#444";
	startBtn.style.color = "black";
	startBtn.style.width = "75px";
	startBtn.style.height = "75px";
	startBtn.style.borderRadius = "50%";
	startBtn.setAttribute("id", "initBtnChrono");

	//Append DOMs
	divStartBtn.append(startBtn);

	mainScreen.append(divStartBtn);

	//Add Event listener
	document.getElementById("initBtnChrono").addEventListener("click", initChrono);

	//Change ico of button if inProjectName != ""
	inpProjectName.addEventListener("input", changeIcoBtnChrono);

}

/*////////////////////////////////////////////////////////*/
/*add Event listener*/
timerBtn.addEventListener("click", tabChrono);

///////////////////////////////////////////////////////////
//function for changing icon of btn on change
function changeIcoBtnChrono() {
	const playIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48" fill="currentColor"><path d="M19.15 32.5 32.5 24l-13.35-8.5ZM24 44q-4.1 0-7.75-1.575-3.65-1.575-6.375-4.3-2.725-2.725-4.3-6.375Q4 28.1 4 24q0-4.15 1.575-7.8 1.575-3.65 4.3-6.35 2.725-2.7 6.375-4.275Q19.9 4 24 4q4.15 0 7.8 1.575 3.65 1.575 6.35 4.275 2.7 2.7 4.275 6.35Q44 19.85 44 24q0 4.1-1.575 7.75-1.575 3.65-4.275 6.375t-6.35 4.3Q28.15 44 24 44Z"/></svg>'
	const disablePlayIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48" fill="currentColor"><path d="M31.75 28.2 16.6 13.4V9.85l22 14Zm7.9 16.35L26.6 31.5l-10 6.35V21.5L3.5 8.35l2.1-2.1 36.2 36.2Z"/></svg>'

	if (inProjectName.value != ""){
		initBtnChrono.innerHTML = playIco;
	}
	else {
		initBtnChrono.innerHTML = disablePlayIco;
	}
}