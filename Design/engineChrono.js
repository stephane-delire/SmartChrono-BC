/*////////////////////////////////////////////////////////*/
//Global variables
let duration = 0;
let runChrono = false;

/*////////////////////////////////////////////////////////*/
//Start Chrono
function startChrono(){
	runChrono = true;

//////Modify buttons
	divBtnZone.innerHTML = "";
	//Pause
	const btnChronoPause = document.createElement("div");
	var s = btnChronoPause.style;
	s.width = "60px";
	s.height = "60px";
	s.backgroundColor = "#444";
	s.color = "black";
	s.borderRadius = "50%";
	s.display = "flex";
	s.justifyContent = "center";
	s.alignItems = 'center';
	btnChronoPause.innerHTML = svgPauseIco;
	btnChronoPause.addEventListener("click", pauseChrono);

	divBtnZone.append(btnChronoPause);


}
//Pause Chrono
function pauseChrono(){
	runChrono = false;

//////Modify buttons
	divBtnZone.innerHTML = "";
	//Play
	const btnChronoPlay = document.createElement("div");
	var s = btnChronoPlay.style;
	s.width = "60px";
	s.height = "60px";
	s.backgroundColor = "#444";
	s.color = "black";
	s.borderRadius = "50%";
	s.display = "flex";
	s.justifyContent = "center";
	s.alignItems = 'center';
	btnChronoPlay.innerHTML = svgPlayIco;
	btnChronoPlay.addEventListener("click", startChrono);

	divBtnZone.append(btnChronoPlay);

	//Save
	const btnChronoSave = document.createElement("div");
	var s = btnChronoSave.style;
	s.width = "60px";
	s.height = "60px";
	s.backgroundColor = "#444";
	s.color = "black";
	s.borderRadius = "50%";
	s.display = "flex";
	s.justifyContent = "center";
	s.alignItems = 'center';
	btnChronoSave.innerHTML = svgSaveIco;
	//btnChronoSave.addEventListener("click", saveChrono);

	divBtnZone.append(btnChronoSave);

	//Delete
	const btnChronoDelete = document.createElement("div");
	var s = btnChronoDelete.style;
	s.width = "60px";
	s.height = "60px";
	s.backgroundColor = "#ac5353";
	s.color = "black";
	s.borderRadius = "50%";
	s.display = "flex";
	s.justifyContent = "center";
	s.alignItems = 'center';
	btnChronoDelete.innerHTML = svgDeleteIco;
	
	divBtnZone.append(btnChronoDelete);
}

//engine Chrono
function engineChrono(){

	if (runChrono){
		duration++;

		var hours = Math.floor(duration / 3600);
		var minutes = Math.floor((duration % 3600) / 60);
		var seconds = duration % 60;
		var formatOutput = `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;

		divNumberZone.innerHTML = formatOutput;
	}

}
//Interval
setInterval(engineChrono, 1000);