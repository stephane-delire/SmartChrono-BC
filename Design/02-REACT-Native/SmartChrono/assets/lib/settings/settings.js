//import { AsyncStorage } from 'react-native';
import AsyncStorage from "@react-native-async-storage/async-storage";
//https://github.com/react-native-async-storage/async-storage
//npm i @react-native-async-storage/async-storage

class Settings {
  constructor(url, login, tableName) {
    this.url = url;
    this.login = login;
    this.tableName = tableName;
  }

  save() {
    const settings = {
      url: this.url,
      login: this.login,
      tableName: this.tableName,
    };
    AsyncStorage.setItem('settings', JSON.stringify(settings));
  }

  static async load() {
    const settings = await AsyncStorage.getItem('settings');
    if (settings) {
      const { url, login, tableName } = JSON.parse(settings);
      return new Settings(url, login, tableName);
    }
    return null;
  }
}

export default Settings;


/* Usage :


import Settings from './Settings';

async function initSettings() {
  let settings = await Settings.load();
  if (!settings) {
    settings = new Settings('', '', '');
  }
  return settings;
}

// Utilisation de la fonction initSettings()
initSettings().then((settings) => {
  // Faire quelque chose avec les valeurs de settings
});








initSettings().then((settings) => {
  console.log('URL : ' + settings.url);
  console.log('Login : ' + settings.login);
  console.log('Table Name : ' + settings.tableName);

  // Modifier les valeurs de l'objet Settings
  settings.url = 'http://example.com';
  settings.login = 'mylogin';
  settings.tableName = 'mytable';

  // Stocker les nouvelles valeurs dans le localStorage
  settings.save();
});



*/

