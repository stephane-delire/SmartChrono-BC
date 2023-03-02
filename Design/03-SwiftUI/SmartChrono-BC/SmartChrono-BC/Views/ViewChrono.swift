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
    @State var selectedProjectName:String = ""
    @State var selectedTaskName:String = ""
    
    @State var duration:Int = 0
    @State var displayDuration:String = "00:00:00"
    @State var chronoRunning:Bool = false
    @State var threadChronoLock:Bool = false
    @State var threadDisplayName:Bool = false
    
    // Var for manual entry
    @State var manualSelectedHours:Int = 0
    @State var manualSelectedMinutes:Int = 0
    @State var manualHours = [Int](0...23)
    @State var manualMinutes = [Int](0...59)
    
    @State var chronoState:Int = 0
    // 0 : View Ask Project & task
    // 1 : View chrono Start up
    // 2 : View chrono Running
    // 3 : View chrono Paused
    // 4 : View chrono ask Delete
    // 5 : View chrono Deleted
    // 6 : View chrono ask Save
    // 7 : View chrono Saved
    // 8 : Manual entry
    
    let project = Project()
    let task = Task()
    
//--------------------------------
    // Test function (delete when needed)
    func test(){
        print(task.taskData)
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
        let record = Record()
        
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
    //Back to 0
    func chronoBackTo0() {
        //reload task & project
        project.reload()
        task.reload()
        //Reset to 0
        duration = 0
        displayDuration = "00:00:00"
        
        chronoState = 0
    }
    //Switch to manual entry
    func chronoSwitchToManualEntry(){
        chronoState = 8
    }
    //Ask save manual
    func chronoAskSaveManual(){
        chronoState = 9
    }
    //Save manual entry
    func chronoSaveManual() {
        //Fonction pour générer une chaine random
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
        let record = Record()
        
        //Modification de duration comme c'est manuel
        let HH = manualSelectedHours * 3600
        let MM = manualSelectedMinutes * 60
        duration = HH + MM
        
        //Save
        record.addRecord(date: date, id: id, duration: duration, project: selectedProjectId, task: selectedTaskId)
    
        //haptic
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
        
        //Reset
        duration = 0
        chronoState = 0
    }
    //Reload project & task
    func chronoReloadProjectTask(){
        project.reload()
        task.reload()
    }
    // Choose default projectID
    func chronoChooseDefaultID(){
        let arrayProject = project.projectData.map {($0.key, $0.value)}
        let arrayTask = task.taskData.map{($0.key, $0.value.first!.key, $0.value.first!.value)}
        if arrayProject.count > 0 {
            selectedProjectId = arrayProject[arrayProject.endIndex - 1].0
        }
        if arrayTask.count > 0 {
            //Need to retrieve task from selectedProject
            var taskFromProject:[Int:String] = [:]
            for task in arrayTask {
                if task.2 == selectedProjectId {
                    taskFromProject[task.0] = task.1
                }
            }
            selectedTaskId = taskFromProject.first!.key
        }
    }
    // Choose default taskID
    func chronoChooseDefaultTask(){
        let arrayTask = task.taskData.map{($0.key, $0.value.first!.key, $0.value.first!.value)}
        if arrayTask.count > 0 {
            //Need to retrieve task from selectedProject
            var taskFromProject:[Int:String] = [:]
            for task in arrayTask {
                if task.2 == selectedProjectId {
                    taskFromProject[task.0] = task.1
                }
            }
            selectedTaskId = taskFromProject.first!.key
        }
    }
    
    func chronoDisplayNamesFromId(){
        // Change le nom affiché en haut des vues chrono
        // En fonction des id selectionnés
        let arrayProject = project.projectData.map {($0.key, $0.value)}
        let arrayTask = task.taskData.map{($0.key, $0.value.first!.key, $0.value.first!.value)}
        
        for p in arrayProject {
            if p.0 == selectedProjectId {
                selectedProjectName = p.1
            }
        }
        for t in arrayTask {
            if t.0 == selectedTaskId {
                selectedTaskName = t.1
            }
        }
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
                    
                    // Transform Json to Tuple array (needed for ForEach)
                    let arrayProject = project.projectData.map {($0.key, $0.value)}
                    let arrayTask = task.taskData.map{($0.key, $0.value.first!.key, $0.value.first!.value)}
                    
                    //Picker for project
                    Text("Project")
                        .font(.title)
                    Picker("Project", selection: $selectedProjectId){
                        ForEach(arrayProject.sorted(by: { $0 < $1 }), id: \.0){ key, value in
                            Text(value).tag(key)
                        }
                    }
                    .onChange(of: selectedProjectId){ _ in
                        chronoChooseDefaultTask()
                    }
                    
                    
                    //Picker for task
                    if(selectedProjectId != 0){
                        Text("Task")
                            .font(.title)
                    }
                    Picker("Task", selection: $selectedTaskId){
                        //Filter
                        ForEach(arrayTask, id: \.0){key, name, fk in
                            if (fk == selectedProjectId){
                                Text(name).tag(key)
                            }
                        }
                    }
                    .onChange(of: selectedTaskId){_ in
                        chronoDisplayNamesFromId()
                    }
                    
                    
                    //Button to start Chrono
                    if (selectedTaskId != 0 && selectedProjectId != 0){
                        Button(action: {}){
                            Image(systemName: "play.fill")
                                .foregroundColor(Color.black)
                                .font(.system(size: 30))
                                .onTapGesture{chronoSwitchTostartup()}
                                .onLongPressGesture(minimumDuration: 0.5){chronoSwitchToManualEntry()}
                        }
                        .frame(width: 75, height: 75)
                        .background(Color("backgroundButton"))
                        .clipShape(Circle())
                        .padding()
                    }
                }
                .onAppear{
                    chronoReloadProjectTask()
                    chronoChooseDefaultID()
                }
            }
            
            //chrono startup
            if chronoState == 1 {
                Group{
                    HStack{
                        Text("Project : ")
                            
                        Text(String(selectedProjectName))
                            .foregroundColor(Color.accentColor)
                    }
                    HStack{
                        Text("Task : ")
                        Text(String(selectedTaskName))
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
                        Text("Project : ")
                            
                        Text(String(selectedProjectName))
                            .foregroundColor(Color.accentColor)
                    }
                    HStack{
                        Text("Task : ")
                        Text(String(selectedTaskName))
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
                        Text("Project : ")
                            
                        Text(String(selectedProjectName))
                            .foregroundColor(Color.accentColor)
                    }
                    HStack{
                        Text("Task : ")
                        Text(String(selectedTaskName))
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
                    Button(action: chronoBackTo0 ){
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
                    Button(action: chronoBackTo0){
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
            
            //Manual entry
            if chronoState == 8 {
                NavigationView{
                    Group{
                        VStack{
                            
                            HStack{
                                Text("Project : ")
                                    
                                Text(String(selectedProjectName))
                                    .foregroundColor(Color.accentColor)
                            }
                            HStack{
                                Text("Task : ")
                                Text(String(selectedTaskName))
                                    .foregroundColor(Color.accentColor)
                            }
                            
                            // Multi Picker
                            //https://www.hackingwithswift.com/forums/swiftui/custom-multicomponent-picker-pure-swiftui/2236
                            HStack{
                                //Hours
                                Picker("Hours", selection: $manualSelectedHours) {
                                    ForEach(0..<manualHours.count){ index in
                                        Text("\(self.manualHours[index])")
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .labelsHidden()
                                .frame(width:75)
                                .clipped()
                                //Separator
                                Text(":")
                                //Minutes
                                Picker("Minutes", selection: $manualSelectedMinutes) {
                                    ForEach(0..<manualMinutes.count){ index in
                                        Text("\(self.manualMinutes[index])")
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .labelsHidden()
                                .frame(width:75)
                                .clipped()
                            } // End multipicker
                            
                            // Button zone
                            HStack{
                                Button(action: chronoBackTo0 ){
                                    Image(systemName: "arrow.backward")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 30))
                                }
                                .frame(width: 75, height: 75)
                                .background(Color("backgroundButton"))
                                .clipShape(Circle())
                                .padding()
                                
                                Spacer()
                                    .frame(width:50)
                                
                                Button(action: chronoAskSaveManual ){
                                    Image(systemName: "square.and.arrow.down")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 30))
                                }
                                .frame(width: 75, height: 75)
                                .background(Color("backgroundButton"))
                                .clipShape(Circle())
                                .padding()
                            }
                        }// End main VStack
                    }// End group
                    .navigationTitle("Manual entry")
                }// End NavigationView
            }
            
            //Ask save manual entry
            if chronoState == 9 {
                Group{
                    Text("Are you sure ?\n Once saved, it will no longer be possible to modify values.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    HStack{
                        //Save for real
                        Button(action: chronoSaveManual){
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
                        
                        //No save return to 0
                        Button(action: chronoSwitchToManualEntry ){
                            Image(systemName: "arrow.backward")
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .frame(width: 75, height: 75)
                        .background(Color("backgroundButton"))
                        .clipShape(Circle())
                    }
                }// End group
            }
            
            
        }//END Stack
        .onAppear{
            chronoEngine()
        }
    }
}

struct ViewChrono_Previews: PreviewProvider {
    static var previews: some View {
        ViewChrono()
    }
}
