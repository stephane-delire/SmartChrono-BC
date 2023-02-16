import { AsyncStorage } from 'react-native';

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

const settings = new Settings('https://example.com', 'user123', 'mytable');
settings.save();

---

Settings.load().then((settings) => {
  if (settings) {
    console.log(settings.url, settings.login, settings.model);
  } else {
    console.log('No settings found');
  }
});




*/

