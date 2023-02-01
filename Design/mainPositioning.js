/*////////////////////////////////////////////////////////*/
/*Global*/
var w = screen.width;
var h = screen.height;
var midW = screen.width/2;

const body = document.body;
const statusBar = document.getElementById("statusBar");
const mainScreen = document.getElementById("mainScreen");
const btnBar = document.getElementById("btnBar");

/*////////////////////////////////////////////////////////*/
/*Positioning*/
function mainPositioning(){
	/*
	btnBar height = 80px;
	statusBar height = 10px;
	*/

	//Reset global variable
	w = screen.width;
	h = screen.height;

	body.style.margin = 0;
	body.style.padding = 0;
	body.style.backgroundColor = "black";
	body.style.fontFamily = 'Inter';

	btnBar.style.position = "absolute";
	btnBar.style.left = "0px";
	btnBar.style.top = (h - 60) + "px";
	btnBar.style.width = "100%";
	btnBar.style.height = "60px";
	btnBar.style.display = "flex";
	btnBar.style.justifyContent = "space-evenly";
	btnBar.style.color = "#444";
	btnBar.style.fontSize = "10px";

	statusBar.style.position = "absolute";
	statusBar.style.left = "0px";
	statusBar.style.top = "0px";
	statusBar.style.width = "100%";
	statusBar.style.height = "10px";

	mainScreen.style.position = "absolute";
	mainScreen.style.width = (w - 20) + "px";
	mainScreen.style.height = (h - 60 - 10) + "px";
	mainScreen.style.left = "10px";
	mainScreen.style.top = (10) + "px";
	mainScreen.style.color = "#444"
	mainScreen.data = mainScreen.getBoundingClientRect();
}

//Call the function once
mainPositioning()
//Add resize event
window.addEventListener("resize", mainPositioning);
////////////////////////////////////////////////////////////