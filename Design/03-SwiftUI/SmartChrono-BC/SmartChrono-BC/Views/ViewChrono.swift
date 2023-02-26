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
    
    @State var duration:Int = 0
    @State var displayDuration:String = "00:00:00"
    
    @State var chronoState:Int = 0
    // 0 : View Ask Project & task
    // 1 : View chrono Start up
    // 2 : View chrono Running
    // 3 : View chrono Paused
    // 4 : View chrono ask Delete
    // 5 : View chrono Deleted
    // 6 : View chrono ask Save
    // 7 : View chrono Saved
    
    let project = Project()
    let task = Task()

    
//--------------------------------
    // Test function (delete when needed)
    func test(){
        
    }
    
    
    
//--------------------------------
    var body: some View {
        //Main task
        VStack{
            
            //Ask Project & task
            if chronoState == 0 {
                Group{
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
                    if (selectedTaskId != 0 && selectedProjectId != 0){
                        Button(action: dummy){
                            Image(systemName: "play.fill")
                                .foregroundColor(Color.black)
                                .font(.system(size: 30))
                        }
                        .frame(width: 75, height: 75)
                        .background(Color("backgroundButton"))
                        .clipShape(Circle())
                        .padding()
                    }
                }
            }
            
            //chrono startup
            if chronoState == 1 {
                Group{
                    HStack{
                        Text("Project ID : ")
                            
                        Text(String(selectedProjectId))
                            .foregroundColor(Color.accentColor)
                    }
                    HStack{
                        Text("Task ID : ")
                        Text(String(selectedTaskId))
                            .foregroundColor(Color.accentColor)
                    }
                    
                    Text(displayDuration)
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(Color("AccentColor"))
                        .padding(60)
                    
                    //play button
                    Button(action: dummy ){
                        Image(systemName: "play.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .frame(width: 75, height: 75)
                    .background(Color("backgroundButton"))
                    .clipShape(Circle())
                    
                }
            }
            
            //chrono running
            if chronoState == 2 {
                Group{
                    HStack{
                        Text("Project ID : ")
                            
                        Text(String(selectedProjectId))
                            .foregroundColor(Color.accentColor)
                    }
                    HStack{
                        Text("Task ID : ")
                        Text(String(selectedTaskId))
                            .foregroundColor(Color.accentColor)
                    }
                    
                    Text(displayDuration)
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(Color("AccentColor"))
                        .padding(60)
                    
                    //play button
                    Button(action: dummy ){
                        Image(systemName: "pause.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .frame(width: 75, height: 75)
                    .background(Color("backgroundButton"))
                    .clipShape(Circle())
                }
            }
            
            //chrono paused
            if chronoState == 3 {
                Group{
                    HStack{
                        Text("Project ID : ")
                            
                        Text(String(selectedProjectId))
                            .foregroundColor(Color.accentColor)
                    }
                    HStack{
                        Text("Task ID : ")
                        Text(String(selectedTaskId))
                            .foregroundColor(Color.accentColor)
                    }
                    
                    Text(displayDuration)
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(Color("AccentColor"))
                        .padding(60)
                    
                    HStack{
                        
                        //Play button
                        Button(action: dummy){
                            Image(systemName: "play.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .frame(width: 75, height: 75)
                        .background(Color("backgroundButton"))
                        .clipShape(Circle())
                        
                        //Save button
                        Button(action: dummy){
                            Image(systemName: "square.and.arrow.down")
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .frame(width: 75, height: 75)
                        .background(Color("backgroundButton"))
                        .clipShape(Circle())
                        
                        //Delete button
                        Button(action: dummy){
                            Image(systemName: "trash.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .frame(width: 75, height: 75)
                        .background(Color("backgroundButtonRed"))
                        .clipShape(Circle())
                        
                    }
                }
            }
            
            //ask Delete
            if chronoState == 4 {
                Group{
                    Text("Are you sure you want to waste the counted time? \nNo turning back possible.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    HStack{
                        //Delete for real button
                        Button(action: dummy){
                            Image(systemName: "trash.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .frame(width: 75, height: 75)
                        .background(Color("backgroundButtonRed"))
                        .clipShape(Circle())
                        
                        Spacer()
                            .frame(width: 50)
                        
                        //No delete return to pause
                        Button(action: dummy){
                            Image(systemName: "arrow.backward")
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .frame(width: 75, height: 75)
                        .background(Color("backgroundButton"))
                        .clipShape(Circle())
                    }
                }
            }
            
            //Deleted
            if chronoState == 5 {
                Group{
                    Text("Time counted removed")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    //Return to state 0
                    Button(action: dummy){
                        Image(systemName: "arrow.backward")
                            .font(.system(size: 30))
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .frame(width: 75, height: 75)
                    .background(Color("backgroundButton"))
                    .clipShape(Circle())
                }
            }
            
            //ask Save
            if chronoState == 6 {
                Group{
                    Text("Are you sure you want to end the count?\n Once saved, it will no longer be possible to add values.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    HStack{
                        //Save for real
                        Button(action: dummy){
                            Image(systemName: "square.and.arrow.down")
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .frame(width: 75, height: 75)
                        .background(Color("backgroundButton"))
                        .clipShape(Circle())
                        
                        Spacer()
                            .frame(width: 50)
                        
                        //No save return to pause
                        Button(action: dummy){
                            Image(systemName: "arrow.backward")
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .frame(width: 75, height: 75)
                        .background(Color("backgroundButton"))
                        .clipShape(Circle())
                    }
                }
            }
            
            //Saved
            if chronoState == 7 {
                Group{
                    Text("Time counted saved")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    //Return to state 0
                    Button(action: dummy){
                        Image(systemName: "arrow.backward")
                            .font(.system(size: 30))
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .frame(width: 75, height: 75)
                    .background(Color("backgroundButton"))
                    .clipShape(Circle())
                }
            }
            
            
        }//END Stack
        .onAppear{test()}
    }
}

struct ViewChrono_Previews: PreviewProvider {
    static var previews: some View {
        ViewChrono()
    }
}
