import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import Icons from '../assets/svg/Icons';

export default function Button(props) {
	const ico = props.ico;
	const color = props.ico;
	const size = props.size;

	return (
		<View style={{width:{size}, height:{size}, backgroundColor:{color}, borderRadius:'50%'}}>
			<Icons ico={ico} size={size} color='#FFF'/>
		</View>
		)

}
