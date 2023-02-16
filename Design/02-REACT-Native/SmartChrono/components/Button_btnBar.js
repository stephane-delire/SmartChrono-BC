import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import Icons from '../assets/svg/Bar_icons';

export default function Button_btnBar(props){
	const name = props.ico;
	const title = props.title;

	//Check if button need orange color
	if (props.ActiveTab == props.number) {

		return (
				<View style={styles.outer}>
					<Icons name={name} active='true'/>
					<Text style={styles.titleActive}>{title}</Text>
				</View>
			)
	}
	else {
		return (
				<View style={styles.outer}>
					<Icons name={name} active='false'/>
					<Text style={styles.title}>{title}</Text>
				</View>
			)
	}
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
	},
	titleActive: {
		color:"#FF8000",
		fontSize:11
	}
})