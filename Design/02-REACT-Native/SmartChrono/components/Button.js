import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import Icons from '../assets/svg/Icons';

export default function Button(props) {
	const ico = props.ico;
	const color = props.ico;
	const size = props.btnSize;

	return (
		<View style={{width:{48}, height:{48}, backgroundColor:{color}, borderRadius:'50%'}}>
			<Icons ico={ico} icoSize={size} color='#FFF'/>
		</View>
		)

}
