import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

export default function TabHelp(){
	return (
		<View style={styles.outer}>
			<View style={styles.first}>
				
			</View>
			<View style={styles.second}>
				
			</View>
			<View style={styles.third}>
				
			</View>
		</View>
		)
}

const styles = StyleSheet.create({
	outer: {
		aspectRatio:1,
		maxWidth:"100%",
		flexDirection: "column",
		justifyContent: "center",
		borderWidth:2,
		borderColor:"#FF4040"
	},
	first: {
		backgroundColor:"#FFFFFF",
		height: "33%"
	},
	second: {
		backgroundColor:"rgb(53,151,156)",
		height: "33%"
	},
	third: {
		backgroundColor:"rgb(56,62,69)",
		height: "33%"
	}
})