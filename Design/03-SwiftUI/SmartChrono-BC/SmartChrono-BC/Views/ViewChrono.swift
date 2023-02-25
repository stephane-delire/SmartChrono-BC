//
//  ViewChrono.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 25/02/2023.
//

import SwiftUI

struct ViewChrono: View {
    
    @State var selectedProjectId:Int = 0
    @State var selectedTaskId = 0
    
    let project = Project()
    let task = Task()

    
    
    // Test function (delete when needed)
    func test(){
        
    }
    
    var body: some View {
        VStack{
            //Picker for project
            Text("Project")
                .font(.title)
            Picker("Project", selection: $selectedProjectId){
                //Transform JSON to tuple Array
                let arrayProject = project.projectData.map {($0.key, $0.value)}
                ForEach(arrayProject.sorted(by: { $0 < $1 }), id: \.0){ key, value in
                    Text(value).tag(key)
                }
            }
            
            //Picker for task
            if(selectedProjectId != 0){
                Text("Task")
                    .font(.title)
            }
            Picker("Task", selection: $selectedTaskId){
                //Transform JSON to tuple Array
                let arrayTask = task.taskData.map{($0.key, $0.value.first!.key, $0.value.first!.value)}
                //Filter
                ForEach(arrayTask, id: \.0){key, name, fk in
                    if (fk == selectedProjectId){
                        Text(name).tag(key)
                    }
                }
            }
            
            //Button to start Chrono
            Button(action: dummy){
                Image(systemName: "play.fill")
                    .foregroundColor(Color.black)
                    .font(.system(size: 30))
            }
            .frame(width: 75, height: 75)
            .background(Color("backgroundButton"))
            .clipShape(Circle())
            
            
        }
        .onAppear{test()}
    }
}

struct ViewChrono_Previews: PreviewProvider {
    static var previews: some View {
        ViewChrono()
    }
}
