import { AsyncStorage } from 'react-native';
//https://github.com/react-native-async-storage/async-storage

import { Odoo } from '../apidoo/Odoo'

class Project {
	constructor(projectList){
		this.projectList = projectList;
	}

	save() {
		AsyncStorage.setItem('projectList', JSON.stringify(this.projectList))
	}
}


export default Project;