/*
For opening SVG from file directory
https://github.com/kristerkari/react-native-svg-transformer#for-react-native-v057-or-newer--expo-sdk-v3100-or-newer

react-native-svg doc:
https://github.com/software-mansion/react-native-svg/blob/main/USAGE.md

*/
import React from 'react';
import { SvgXml } from 'react-native-svg';

/*SVG*/
const timerIco = '<svg xmlns="http://www.w3.org/2000/svg" height="30" width="30" fill="currentColor" preserveAspectRatio="xMidYMid"><path d="M18 5V2h12v3Zm4.5 22.35h3v-11.5h-3Zm1.5 16.6q-3.7 0-6.975-1.425Q13.75 41.1 11.3 38.65q-2.45-2.45-3.875-5.725Q6 29.65 6 25.95q0-3.7 1.425-6.975Q8.85 15.7 11.3 13.25q2.45-2.45 5.725-3.875Q20.3 7.95 24 7.95q3.35 0 6.275 1.1 2.925 1.1 5.225 3.1l2.55-2.55 2.15 2.15-2.55 2.55q1.8 2 3.075 4.85Q42 22 42 25.95q0 3.7-1.425 6.975Q39.15 36.2 36.7 38.65q-2.45 2.45-5.725 3.875Q27.7 43.95 24 43.95Z"/></svg>';
const settingsIco = '<svg xmlns="http://www.w3.org/2000/svg" height="30" width="30" fill="currentColor" preserveAspectRation="xMidYMid" viewBox="0 0 48 48"><path d="m19.4 44-1-6.3q-.95-.35-2-.95t-1.85-1.25l-5.9 2.7L4 30l5.4-3.95q-.1-.45-.125-1.025Q9.25 24.45 9.25 24q0-.45.025-1.025T9.4 21.95L4 18l4.65-8.2 5.9 2.7q.8-.65 1.85-1.25t2-.9l1-6.35h9.2l1 6.3q.95.35 2.025.925Q32.7 11.8 33.45 12.5l5.9-2.7L44 18l-5.4 3.85q.1.5.125 1.075.025.575.025 1.075t-.025 1.05q-.025.55-.125 1.05L44 30l-4.65 8.2-5.9-2.7q-.8.65-1.825 1.275-1.025.625-2.025.925l-1 6.3ZM24 30.5q2.7 0 4.6-1.9 1.9-1.9 1.9-4.6 0-2.7-1.9-4.6-1.9-1.9-4.6-1.9-2.7 0-4.6 1.9-1.9 1.9-1.9 4.6 0 2.7 1.9 4.6 1.9 1.9 4.6 1.9Z"/></svg>';
const syncCloudIco = '<svg xmlns="http://www.w3.org/2000/svg" height="30" width="30" fill="currentColor" preserveAspectRatio="xMidYMid" viewBox="0 0 48 48"><path d="M8.35 40v-3h6.5q-3.2-2.4-5.025-5.425Q8 28.55 8 24.15q0-5 2.95-9.325Q13.9 10.5 19.35 8.8v3.1q-3.55 1.3-5.95 4.65-2.4 3.35-2.4 7.6 0 3.2 1.375 5.875T16.85 34.7v-6.2h3V40ZM30 40q-2.5 0-4.25-1.75T24 34q0-2.4 1.65-4.15Q27.3 28.1 29.7 28q.85-1.8 2.525-2.9Q33.9 24 36 24q2.65 0 4.575 1.725Q42.5 27.45 42.9 30h.1q2.1 0 3.55 1.5Q48 33 48 34.95q0 2.1-1.45 3.575T43 40Zm6.8-18q-.55-2.55-1.9-4.675-1.35-2.125-3.6-4.025v6.2h-3V8h11.5v3h-6.55q2.45 2.05 4.325 5.025Q39.45 19 39.85 22Z"/></svg>';
const helpIco = '<svg xmlns="http://www.w3.org/2000/svg" height="30" width="30" fill="currentColor" preserveAspectRatio="xMidYMid" viewBox="0 0 48 48"><path d="M24.2 35.65q.8 0 1.35-.55t.55-1.35q0-.8-.55-1.35t-1.35-.55q-.8 0-1.35.55t-.55 1.35q0 .8.55 1.35t1.35.55Zm-1.75-7.3h2.95q0-1.3.325-2.375T27.75 23.5q1.55-1.3 2.2-2.55.65-1.25.65-2.75 0-2.65-1.725-4.25t-4.575-1.6q-2.45 0-4.325 1.225T17.25 16.95l2.65 1q.55-1.4 1.65-2.175 1.1-.775 2.6-.775 1.7 0 2.75.925t1.05 2.375q0 1.1-.65 2.075-.65.975-1.9 2.025-1.5 1.3-2.225 2.575-.725 1.275-.725 3.375ZM24 44q-4.1 0-7.75-1.575-3.65-1.575-6.375-4.3-2.725-2.725-4.3-6.375Q4 28.1 4 24q0-4.15 1.575-7.8 1.575-3.65 4.3-6.35 2.725-2.7 6.375-4.275Q19.9 4 24 4q4.15 0 7.8 1.575 3.65 1.575 6.35 4.275 2.7 2.7 4.275 6.35Q44 19.85 44 24q0 4.1-1.575 7.75-1.575 3.65-4.275 6.375t-6.35 4.3Q28.15 44 24 44Z"/></svg>';
const folderIco = '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M7.05 40q-1.2 0-2.1-.925-.9-.925-.9-2.075V11q0-1.15.9-2.075Q5.85 8 7.05 8h14l3 3h17q1.15 0 2.075.925.925.925.925 2.075v23q0 1.15-.925 2.075Q42.2 40 41.05 40Z"/></svg>'

/*linkage*/
const icoLink = {
	timerIco : timerIco,
	settingsIco: settingsIco,
	syncCloudIco: syncCloudIco,
	helpIco: helpIco,
	folderIco: folderIco
}

/*function for react*/
export default function Icons(props) {
	const Icon = icoLink[props.name];
	return <SvgXml xml={Icon} width="30px" height="30px" viewBox="0 0 48 48" fill="#444"/>;
}