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
    @State var chronoRunning:Bool = false
    @State var threadChronoLock:Bool = false
    
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
    
    //Switch to startUp
    func chronoSwitchTostartup(){
        //Reset to 0
        duration = 0
        displayDuration = "00:00:00"
        //Switch view
        chronoState = 1
    }
    
    //Launch Chrono & switch view
    func chronoLaunch(){
        print("Start running chrono")
        chronoState = 2
        chronoRunning = true
    }
    
    //Pause chrono & switch view
    func chronoPause(){
        chronoRunning = false
        chronoState = 3
    }
    
    //Switch to ask save
    func chronoSwitchToAskSave() {
        chronoRunning = false
        chronoState = 6
    }
    
    //Switch to ask delete
    func chronoSwitchToAskDelete(){
        chronoRunning = false
        chronoState = 4
    }
    
    //Save time
    func chronoSave(){
        //Fonction pour générer une chaien random
        func generateRandomString(length: Int) -> String {
            let lettersAndDigits = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            return String((0..<length).map{ _ in lettersAndDigits.randomElement()! })
        }
        //Fonction pour générer la date d'enregistrement du record
        func getTodaysDate() -> String {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }

        let date = getTodaysDate()
        let id = generateRandomString(length: 8)
        var record = Record()
        
        //Save
        record.addRecord(date: date, id: id, duration: duration, project: selectedProjectId, task: selectedTaskId)
    
        //haptic
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
        
        //Reset
        chronoRunning = false
        duration = 0
        chronoState = 7
    }

    //Delete time
    func chronoDelete(){
        //haptic
        let impact = UIImpactFeedbackGenerator(style: .rigid)
        impact.impactOccurred()
        
        chronoRunning = false
        duration = 0
        displayDuration = "00:00:00"
        chronoState = 5
    }
    
//--------------------------------
    //CHRONO engine
    func chronoEngine() {
        // threadChronoLock sert à n'avoir qu'un seul thread qui compte
        // Si par hasard dans le code on arrive à lancer 2 queues
        // on compterait +2 secondes a la fois
        if (threadChronoLock == false){
            threadChronoLock = true
            // Lance un thread qui s'executera exactement une seconde après sa définition
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
                
                // Bool permettant d'arreter ou de compter le chrono
                if chronoRunning {
                    duration += 1
                    
                    // Formattage pour l'affichage.
                    let hours = self.duration / 3600
                    let minutes = (self.duration % 3600) / 60
                    let seconds = (self.duration % 3600) % 60
                    
                    displayDuration = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                }
                
                // Se relance dès que fini afin de tourner en boucle
                threadChronoLock = false
                chronoEngine()
            }
        } else {
            // Dans le cas ou le thread est bloqué, pour éviter un double comptage
            return
        }
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
                        Button(action: chronoSwitchTostartup){
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
                    Button(action: chronoLaunch ){
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
                    Button(action: chronoPause ){
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
                        Button(action: chronoLaunch){
                            Image(systemName: "play.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .frame(width: 75, height: 75)
                        .background(Color("backgroundButton"))
                        .clipShape(Circle())
                        
                        //Save button
                        Button(action: chronoSwitchToAskSave){
                            Image(systemName: "square.and.arrow.down")
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .frame(width: 75, height: 75)
                        .background(Color("backgroundButton"))
                        .clipShape(Circle())
                        
                        //Delete button
                        Button(action: chronoSwitchToAskDelete){
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
                        Button(action: chronoDelete){
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
                        Button(action: chronoPause){
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
                    Button(action: chronoSwitchTostartup ){
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
                        Button(action: chronoSave){
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
                        Button(action: chronoPause){
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
                    Button(action: chronoSwitchTostartup){
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
        .onAppear{chronoEngine()}
    }
}

struct ViewChrono_Previews: PreviewProvider {
    static var previews: some View {
        ViewChrono()
    }
}
