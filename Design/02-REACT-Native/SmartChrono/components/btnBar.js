import React, {useState, useEffect} from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import Button_btnBar from './Button_btnBar'


export default function BtnBar(props) {

	//props.ActiveTab => Défini quelle tab est active
	//props.setActiveTab => Setter de ActiveTab


	return (
		<View id="btnBar" style={styles.btnBar}>
			<Pressable onPress={() => {props.setActiveTab(1)}}>
				<Button_btnBar ico="timerIco" title="Chrono" ActiveTab={props.ActiveTab} number="1"/>
			</Pressable>
			<Pressable onPress={() => {props.setActiveTab(2)}}>
				<Button_btnBar ico="folderIco" title="Records" ActiveTab={props.ActiveTab} number="2"/>
			</Pressable>
			<Pressable onPress={() => {props.setActiveTab(3)}}>
				<Button_btnBar ico="syncCloudIco" title="Sync" ActiveTab={props.ActiveTab} number="3"/>
			</Pressable>
			<Pressable onPress={() => {props.setActiveTab(4)}}>
				<Button_btnBar ico="settingsIco" title="Settings" ActiveTab={props.ActiveTab} number="4"/>
			</Pressable>
			<Pressable onPress={() => {props.setActiveTab(5)}}>
				<Button_btnBar ico="helpIco" title="Help" ActiveTab={props.ActiveTab} number="5"/>
			</Pressable>
		</View>
		);
}

const styles = StyleSheet.create({
	btnBar:{
		flexDirection: "row",
		alignItems: 'center',
		justifyContent: 'space-between',
		position: 'absolute',
		bottom: 30,
		width:"90%",
		color: '#FFF',
	},
	text:{
		fontSize:50,
		color: "#FFF"
	}
})