import React, { useState } from 'react';
import { StyleSheet, Text, View, TextInput, TouchableOpacity } from 'react-native';
import Button from '../Button'

export default function TabSettings() {
  const [url, setUrl] = useState('');
  const [login, setLogin] = useState('');
  const [dbTable, setDbTable] = useState('');

  const btnSize = 48;

  const handleUrlChange = (text) => {
    setUrl(text);
  };

  const handleLoginChange = (text) => {
    setLogin(text);
  };

  const handleDbTableChange = (text) => {
    setDbTable(text);
  };

  const handleButtonPress = () => {
    console.log('Button Pressed');
  };

  return (
    <View style={styles.container}>
      <Text style={styles.label}>Url</Text>
      <TextInput style={styles.input} onChangeText={handleUrlChange} value={url} />

      <Text style={styles.label}>Login</Text>
      <TextInput style={styles.input} onChangeText={handleLoginChange} value={login} />

      <Text style={styles.label}>DB Table</Text>
      <TextInput style={styles.input} onChangeText={handleDbTableChange} value={dbTable} />

        <Button svgName='saveIco'/>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    marginHorizontal: 5,
  },
  label: {
    fontWeight: 'bold',
    marginVertical: 8,
    color: "#FFF"
  },
  input: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    marginBottom: 16,
    paddingHorizontal: 8,
    width: '100%',
  }
});
