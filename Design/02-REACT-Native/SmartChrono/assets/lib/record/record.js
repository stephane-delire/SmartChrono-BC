import { AsyncStorage } from 'react-native';
//https://github.com/react-native-async-storage/async-storage

class Record {
	constructor(recordList){
		this.recordList = recordList;
	}

	save() {
		AsyncStorage.setItem('recordList', JSON.stringify(this.recordList));
	}

	static async load() {
		const recordList = await AsyncStorage.getItem('recordList');
		if (recordList) {
			const recordList = JSON.parse(recordList);
			return new Record(recordList);
		}
		return null;
	}
}


export default Record;