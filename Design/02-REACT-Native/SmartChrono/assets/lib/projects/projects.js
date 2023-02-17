import { AsyncStorage } from 'react-native';
//https://github.com/react-native-async-storage/async-storage


class Project {
	constructor(projectList){
		this.projectList = projectList;
	}

	save() {
		AsyncStorage.setItem('projectList', JSON.stringify(this.projectList))
	}

	static async load() {
		const projectList = await AsyncStorage.getItem('projectList');
		if (projectList) {
			const projectList = JSON.parse(projectList);
			return new Project(projectList);
		}
		return null;
	}
}


export default Project;