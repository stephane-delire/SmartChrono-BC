import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import Icons from '../assets/svg/Material_icons';

export default function Button_btnBar(att){
	const name = att.ico
	const title = att.title

	return (
		<View style={styles.outer}>
			<Icons name={name}/>
			<Text style={styles.title}>{title}</Text>
		</View>
		)
}

const styles = StyleSheet.create({
	outer: {
		flexDirection: 'column',
		width:50,
		height:50,
		alignItems:'center'
	},
	title: {
		color:"#444",
		fontSize:11
	}
})