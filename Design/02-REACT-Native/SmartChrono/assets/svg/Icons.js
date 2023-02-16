import React from 'react';
import { SvgXml } from 'react-native-svg';

/*SVG*/
const playIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" viewBox="0 96 960 960" width="48"><path d="M320 853V293l440 280-440 280Z"/></svg>'
const pauseIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" viewBox="0 96 960 960" width="48"><path d="M525 856V296h235v560H525Zm-325 0V296h235v560H200Z"/></svg>'
const stopIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" viewBox="0 96 960 960" width="48"><path d="M240 816V336h480v480H240Z"/></svg>'
const notPlayIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" viewBox="0 96 960 960" width="48"><path d="M635 660 332 364v-71l440 280-137 87Zm158 327L532 726 332 853V526L70 263l42-42 724 724-43 42Z"/></svg>'
const deleteIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" viewBox="0 96 960 960" width="48"><path d="M261 936q-24 0-42-18t-18-42V306h-41v-60h188v-30h264v30h188v60h-41v570q0 24-18 42t-42 18H261Zm106-146h60V391h-60v399Zm166 0h60V391h-60v399Z"/></svg>'
const syncIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" viewBox="0 96 960 960" width="48"><path d="M167 896v-60h130l-15-12q-64-51-93-111t-29-134q0-106 62.5-190.5T387 272v62q-75 29-121 96.5T220 579q0 63 23.5 109.5T307 769l30 21V666h60v230H167Zm407-15v-63q76-29 121-96.5T740 573q0-48-23.5-97.5T655 388l-29-26v124h-61V256h230v60H665l15 14q60 56 90 120t30 123q0 106-62 191T574 881Z"/></svg>'
const probSyncIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" viewBox="0 96 960 960" width="48"><path d="M132 896v-60h123l-14-14q-60-60-86.5-121.5T128 580q0-109 62.5-195T355 266v62q-76 30-121.5 99T188 580q0 52 17.5 98.5T265 763l30 27V673h60v223H132Zm348-122q-12 0-21-9t-9-21q0-12 9-21t21-9q12 0 21 9t9 21q0 12-9 21t-21 9Zm-28-148V377h60v249h-60Zm153 261v-63q76-29 121.5-98T772 573q0-54-18-100.5T695 389l-30-27v117h-60V256h223v60H704l15 14q62 57 87.5 120T832 573q0 108-63 194.5T605 887Z"/></svg>'
const disSyncIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" viewBox="0 96 960 960" width="48"><path d="M809 1000 653 844q-20 13-39 21.5T574 881v-63q9-3 18-7.5t18-9.5L256 447q-19 31-27.5 65.5T220 579q0 58 21.5 105.5T307 769l30 21V666h60v230H167v-60h130l-15-12q-68-54-95.5-115T160 579q1-54 15-97t38-78L57 248l41-41 752 752-41 41Zm-72-236-42-42q21-33 33-70t12-79q0-46-22.5-95.5T655 388l-29-26v124h-60V256h230v60H665l15 14q64 60 92 124t28 119q0 54-15.5 101T737 764ZM334 361l-41-41q22-17 45.5-28.5T387 272v62q-13 5-26.5 12T334 361Z"/></svg>'

/*linkage*/
const icoLink = {
	playIco : playIco,
	pauseIco : pauseIco,
	stopIco : stopIco,
	notPlayIco : notPlayIco,
	deleteIco : deleteIco,
	syncIco : syncIco,
	probSyncIco :probSyncIco,
	disSyncIco :disSyncIco 
}

/*Function for react*/
export default function Icons(props) {
	const Icon = icoLink[props.ico];

	return <SvgXml xml={Icon} width={props.size} height={props.size} viewBox="0 0 48 48" fill="#000"/>;

}