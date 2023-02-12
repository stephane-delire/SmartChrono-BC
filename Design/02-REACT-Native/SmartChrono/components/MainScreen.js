import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import TabHelp from './tabs/TabHelp'




export default function MainScreen(props) {
	

	//Tab Help
	if (props.ActiveTab == 5) {
		return (
			<View style={styles.container}>
				<TabHelp/>
			</View>
			)
	}

	//Tab Chrono
	if (props.ActiveTab == 1) {
		return (
			<View style={styles.container}>

				
			
			</View>
			)
	}

	//Tab Records
	if (props.ActiveTab == 2) {
		return (
			<View style={styles.container}>

				
			
			</View>
			)
	}

	//Tab Sync
	if (props.ActiveTab == 3) {
		return (
			<View style={styles.container}>

				
			
			</View>
			)
	}

	//Tab Settings
	if (props.ActiveTab == 4) {
		return (
			<View style={styles.container}>

				
			
			</View>
			)
	}
}

const styles = StyleSheet.create({
	container: {
		flexDirection: "row",
		borderWidth: 2,
		borderColor: "#80FF00",
		height: "70%",
		width: "100%"
	}
})