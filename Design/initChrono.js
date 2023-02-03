// SVG for initChrono
const svgPlayIco = '<svg xmlns="http://www.w3.org/2000/svg" height="30" width="30" fill="currentColor" preserveAspectRatio="xMidYMid" viewBox="0 0 48 48"><path d="M16 37.85v-28l22 14Z"/></svg>'
const svgSaveIco = '<svg xmlns="http://www.w3.org/2000/svg" height="30" width="30" fill="currentColor" preserveAspectRatio="xMidYMid" viewBox="0 0 48 48"><path d="M42 13.85V39q0 1.2-.9 2.1-.9.9-2.1.9H9q-1.2 0-2.1-.9Q6 40.2 6 39V9q0-1.2.9-2.1Q7.8 6 9 6h25.15Zm-18 21.9q2.15 0 3.675-1.525T29.2 30.55q0-2.15-1.525-3.675T24 25.35q-2.15 0-3.675 1.525T18.8 30.55q0 2.15 1.525 3.675T24 35.75ZM11.65 18.8h17.9v-7.15h-17.9Z"/></svg>'
const svgPauseIco = '<svg xmlns="http://www.w3.org/2000/svg" height="30" width="30" fill="currentColor" preserveAspectRatio="xMidYMid" viewBox="0 0 48 48"><path d="M26.25 38V10H38v28ZM10 38V10h11.75v28Z"/></svg>'
const svgDeleteIco = '<svg xmlns="http://www.w3.org/2000/svg" height="30" width="30" fill="currentColor" preserveAspectRatio="xMidYMid" viewBox="0 0 48 48"><path d="M18.05 33.05 24 27l6 6.05 2.35-2.4-5.95-6.05 5.95-6.05-2.35-2.4-6 6.05-5.95-6.05-2.4 2.4 6 6.05-6 6.05Zm-5 8.95q-1.2 0-2.1-.9-.9-.9-.9-2.1V10.5H8v-3h9.4V6h13.2v1.5H40v3h-2.05V39q0 1.2-.9 2.1-.9.9-2.1.9Z"/></svg>'


/*////////////////////////////////////////////////////////*/
/*Init chrono*/

function initChrono(){
	//Reset mainScreen
	mainScreen.innerHTML = "";

	//MUST RETRIEVE PROJECT and TASK

	// Div general
	const divGeneralChrono = document.createElement("div");
	var s = divGeneralChrono.style;
	s.width = "100%";
	s.height = "100%";
	s.display = 'flex';
	s.flexDirection = 'column';
	s.justifyContent = 'center';

	mainScreen.append(divGeneralChrono);

	// Div numer zone
	const divNumberZone = document.createElement("div");
	var s = divNumberZone.style
	s.minHeight = '30px';
	s.backgroundColor = 'blue';

	divGeneralChrono.append(divNumberZone);

	// Div btn zone
	const divBtnZone = document.createElement("div");
	var s = divBtnZone.style;
	s.display = "flex";
	s.flexDirection = "row";
	s.justifyContent = 'space-evenly';
	s.alignItems = 'center';
	s.marginTop = "20px";

	divGeneralChrono.append(divBtnZone);

	// Base button
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

	divBtnZone.append(btnChronoPlay);

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