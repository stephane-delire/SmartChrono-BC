import React from 'react';
import { View, Text, TouchableOpacity } from 'react-native';
import SVGlink from '../assets/svg/Icons';
import { SvgXml, SvgUri } from 'react-native-svg';


const Button = (props) => {
  const {
    size = 75,
    color = '#444',
    svgName,
    text,
    onPress,
  } = props;

console.log(SVGlink[svgName])

  return (
    <TouchableOpacity onPress={onPress}>
      <View style={{
        width: size,
        height: size,
        borderRadius: size / 2,
        backgroundColor: color,
        alignItems: 'center',
        justifyContent: 'center',
        color: '#FF8000',
      }}>
        {svgName &&
          <SvgXml
            width={size / 2}
            height={size / 2}
            fill='#000000'
            xml={SVGlink[svgName]}
          />
        }
        {text &&
          <Text style={{fontSize: 12}}>
            {text}
          </Text>
        }
      </View>
    </TouchableOpacity>
  );
};

export default Button;



/*
Usage

import Button from './Button';

const MyComponent = () => {
  const handlePress = () => {
    console.log('Button pressed');
  };

  return (
    <RoundButton
      size={80}
      color="#f00"
      svgName="https://example.com/my-icon.svg"
      text="Click me"
      onPress={handlePress}
    />
  );
};

*/
