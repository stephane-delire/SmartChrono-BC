import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

export default function StatusBar(props) {
	return (
		<View style={styles.statusBar}>
			<Text style={styles.text}>{props.ActiveTab}</Text>
		</View>
		);
}

const styles = StyleSheet.create({
	statusBar:{
		position: 'absolute',
		top:35,
		left:5
	},
	text:{
		color:'#FFF',
		fontSize:9
	}
})