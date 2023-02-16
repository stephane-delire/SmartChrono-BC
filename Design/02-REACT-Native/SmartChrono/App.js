import React, {useState, useEffect} from 'react';
import { StyleSheet, Text, View } from 'react-native';
import BtnBar from './components/btnBar';
import StatusBar from './components/statusBar';
import MainScreen from './components/MainScreen';

import Settings from './assets/lib/settings/settings';

import Odoo from './assets/lib/apidoo/Odoo';



export default function App() {
  /*STATES*/
  const [ActiveTab, setActiveTab] = useState(0)


  /*SETTINGS*/
  async function initSettings() {
    let settings = await Settings.load();
    if (!settings) {
      settings = new Settings("", "", "");
      //console.warn("No settings found");
    }
    return settings;
  }
  var settings = initSettings();


  /*RETURN*/
  return (
    <View style={styles.container}>
      <StatusBar ActiveTab={ActiveTab}/>
      <BtnBar setActiveTab={setActiveTab} ActiveTab={ActiveTab}/>

      <MainScreen ActiveTab={ActiveTab} setActiveTab={setActiveTab}/>

    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#000',
    color: '#FFF',
    alignItems: 'center',
    justifyContent: 'center',
  },

});
