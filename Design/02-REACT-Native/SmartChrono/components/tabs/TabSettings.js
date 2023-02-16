import React, { useState } from 'react';
import { StyleSheet, Text, View, TextInput, TouchableOpacity } from 'react-native';

export default function TabSettings() {
  const [url, setUrl] = useState('');
  const [login, setLogin] = useState('');
  const [dbTable, setDbTable] = useState('');

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

      <TouchableOpacity style={styles.button} onPress={handleButtonPress}>
        <Text style={styles.buttonText}>Button</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    marginHorizontal: 16,
  },
  label: {
    fontWeight: 'bold',
    marginVertical: 8,
  },
  input: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    marginBottom: 16,
    paddingHorizontal: 8,
    width: '100%',
  },
  button: {
    backgroundColor: 'blue',
    padding: 16,
    borderRadius: 8,
    marginTop: 16,
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    textAlign: 'center',
  },
});
