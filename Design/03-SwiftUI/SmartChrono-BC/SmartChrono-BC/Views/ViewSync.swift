//
//  ViewSync.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 22/02/2023.
//

import SwiftUI
import Alamofire

struct ViewSync: View {
    @ObservedObject var record : Record
    
    let settings = Settings()
    let project = Project()
    let task = Task()
    let user = User()
    
    @State var userPassword:String = ""
    @State var userID:Int = 0
    
    
    @State var syncError:Bool = false
    @State var syncErrorMsg:String = ""
    @State var syncInit:Bool = false
    @State var syncShowProgress:Bool = true
    @State var syncSettingsLoaded:Bool = false
    @State var syncProjectLoaded:Bool = false
    @State var syncTaskLoaded:Bool = false
    @State var syncRecordLoaded:Bool = false
    @State var syncIDLoaded:Bool = false
    @State var syncRecordSend:Bool = false
    @State var syncProjectUpdated:Bool = false
    @State var syncTaskUpdated:Bool = false
    @State var syncIsDone:Bool = false
    
    @State var syncState:Int = 0
    // 0 : Default
    // 1 : SyncManager
    // 2 : Success Sync
    // 3 : Error Sync
    
    func hapticVibrateSuccess(){
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    func hapticVibrateError(){
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    
    func syncBackTo0(){
        syncState = 0
        syncIsDone = false
        syncError = false
        syncInit = false
        syncShowProgress = true
        syncSettingsLoaded = false
        syncProjectLoaded = false
        syncTaskLoaded = false
        syncRecordLoaded = false
        syncIDLoaded = false
        syncRecordSend = false
        syncProjectUpdated = false
        syncTaskUpdated = false
    }
    
    func syncSwitchToSyncManager(){
        syncState = 1
    }
    func syncSwitchToSuccessSync(){
        syncState = 2
    }
    
//---------------------------------
    func launchSync() {
        let queue = DispatchQueue(label: "syncManager")
        
        userPassword = user.password
        userID = user.id
        
        syncInit = true
        syncShowProgress = true
        print("===== Begin Sync =====")
        
        @State var syncNumberOfRecord:Int = 0
        syncNumberOfRecord = record.count()
        
        syncRecordLoaded = true
        
        
        //Retrieve ID
        func retrieveID(){
            print("Retrieve ID...")
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "User-Agent": "SmartChrono",
                "Connection": "keep-alive"
            ]
            let parameters: Parameters = [
                "jsonrpc": "2.0",
                "params": [
                    "service": "common",
                    "method": "login",
                    "args": [settings.DB, user.login, userPassword]
                ]
            ]
            AF.request(settings.url + "/jsonrpc", method: .post, parameters: parameters,encoding: JSONEncoding.prettyPrinted, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            print("!Success JSON-RPC!")
                            if let result = json["result"] as? Int {userID = result}
                            else {userID = 0}
                            print("Retrieve user id : \(userID)")
                            
                            // Second call
                            if (userID != 0){
                                sendRecord()
                            }
                            
                            if(userID == 0){
                                print("error authenticate...")
                                syncErrorMsg = "Authentication error, check your password and your login"
                                syncState = 3
                                return
                            }
                        }
                    case .failure(let error):
                        print(error)
                        syncErrorMsg = "Error connecting to url..."
                        syncState = 3
                        return
                    }
                }
            
            syncIDLoaded = true
        }
        
        // Send record
        func sendRecord(){
            print("Sending records...")
            
            for item in record.data {
                let date = item["date"] as? String
                let id = item["id"] as? String ?? ""
                let duration = item["duration"] as? Int ?? 0
                let projectId = item["project"] as? Int ?? 0
                let taskId = item["task"] as? Int ?? 0
                
                
                let headers: HTTPHeaders = [
                    "Content-Type": "application/json",
                    "User-Agent": "SmartChrono",
                    "Connection": "keep-alive"
                ]
                var parameters: Parameters = [
                    "jsonrpc": "2.0",
                    "params": [
                        "service": "object",
                        "method": "execute",
                        "args": [settings.DB, userID as Any, userPassword, "account.analytic.line", "create", [
                            "project_id":projectId,
                            //"date":date, //yyyy-mm-dd
                            "task_id":taskId,
                            "unit_amount":Float(duration)/3600.0
                        ]
                                ]
                    ]
                ]
                
                print("send record : \(id)")
                AF.request(settings.url + "/jsonrpc", method: .post, parameters: parameters,encoding:
                            JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            let resp = json["result"] as? Int
                            if(resp == nil){
                                print("error authenticate...")
                                syncErrorMsg = "Authentication error during send record, check your password and your login. Or contact your administrator."
                                syncState = 3
                                return
                            } else {
                                //Decrement counter
                                syncNumberOfRecord -= 1
                            }
                        }
                    case .failure(let error):
                        print(error)
                        syncErrorMsg = "Error connecting to url..."
                        syncState = 3
                    }
                }
            }
            // Third call
            projectUpdate()
            
            //syncRecordSend = true
        }
        
        // Project update
        func projectUpdate(){
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "User-Agent": "SmartChrono",
                "Connection": "keep-alive"
            ]
            let parameters: Parameters = [
                "jsonrpc": "2.0",
                "params": [
                    "service": "object",
                    "method": "execute",
                    "args": [settings.DB, userID as Any, userPassword, "project.project", "search_read",
                             [],
                             ["name"]
                            ]
                ]
            ]
            
            project.flush()
            print("Update project...")
            AF.request(settings.url + "/jsonrpc", method: .post, parameters: parameters,encoding: JSONEncoding.prettyPrinted, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        //print("+++++")
                        //print(response.value)
                        //print("+++++")
                        
                        if let json = value as? [String: Any], let resultArray = json["result"] as? [[String:Any]] {
                            for item in resultArray {
                                if let id = item["id"] as? Int, let name = item["name"] as? String {
                                    // Rajouter le projet
                                    project.add(id, name)
                                    print("++ Adding project id : \(id), name : \(name)")
                                } else {
                                    print("invalid response from Odoo")
                                    syncErrorMsg = "Invalid response from Odoo server..."
                                    syncState = 3
                                    return
                                }
                            }
                            project.saveProjectData()
                            //fourth call
                            taskUpdate()
                        } else {
                            print("Cast probleme with JSON recieved! in Project Update")
                        }
                    case .failure(let error):
                        print(error)
                        syncErrorMsg = "Error connecting to url..."
                        syncState = 3
                    }
                }
            
            syncProjectUpdated = true
        }
        
        // Task update
        func taskUpdate(){
            // Task update
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "User-Agent": "SmartChrono",
                "Connection": "keep-alive"
            ]
            let parameters:Parameters = [
                "jsonrpc": "2.0",
                "params": [
                    "service": "object",
                    "method": "execute",
                    "args": [settings.DB, userID as Any, userPassword, "project.task", "search_read",
                             [["active", "=", true]],
                             ["name", "project_id"]
                            ]
                ]
            ]
            
            task.flush()
            print("Update task...")
            AF.request(settings.url + "/jsonrpc", method: .post, parameters: parameters,encoding: JSONEncoding.prettyPrinted, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any], let resultArray = json["result"] as? [[String:Any]] {
                            for item in resultArray {
                                if let id = item["id"] as? Int, let name = item["name"] as? String, let respProject = item["project_id"] as? [Any], let projectId = respProject.first as? Int {
                                    // Rajouter le projet à l'objet task
                                    task.add(id, name, projectId)
                                    print("++ Adding task id : \(id), name : \(name), project_id : \(projectId)")
                                } else {
                                    print("invalid response from Odoo")
                                    syncErrorMsg = "Invalid response from Odoo server..."
                                    syncState = 3
                                    return
                                }
                            }
                            task.saveTaskData()
                            syncTaskUpdated = true
                            
                            //Fifth call
                            syncEndSync()
                            
                            
                        } else {
                            print("Cast probleme with JSON recieved! in Task Update")
                            print(value)
                            syncErrorMsg = "Invalid response from Odoo server..."
                            syncState = 3
                        }
                    case .failure(let error):
                        print(error)
                        syncErrorMsg = "Error connecting to url..."
                        syncState = 3
                    }
                }
        }
        
        // Ending Syncs
        func syncEndSync() {
            while syncIsDone == false{
                if syncNumberOfRecord <= 0 {
                    record.flush()
                    record.saveData()
                    syncRecordSend = true
                    syncShowProgress = false
                    syncIsDone = true
                    hapticVibrateSuccess()
                    print("===== End sync =====")
                }
            }
        }
        
        // Adding serial DispatchQueue for synchronous call.
        // https://stackoverflow.com/questions/44429221/dispatchqueue-sync-concurrent
        queue.sync {retrieveID()}
        
    }//End launchSync
//---------------------------------
    
    var body: some View {
            NavigationView{
                
                VStack{
                    if syncState == 0 {
                        Group{
                            Text("Sync")
                                .font(.title)
                            Button(action: syncSwitchToSyncManager){
                                Image(systemName: "icloud.and.arrow.up")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 30))
                            }
                            .frame(width: 75, height: 75)
                            .background(Color("backgroundButton"))
                            .clipShape(Circle())
                        }
                        Text("Press the button to synchronize projects and tasks, and send recorded data if present.")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                
                    // SyncManager
                    if syncState == 1 {
                        Group {
                            //Settings
                            HStack{
                                Text("Loading settings...")
                                Spacer()
                                if(syncSettingsLoaded == false){ProgressView()}
                                else {Image(systemName:"checkmark").foregroundColor(Color.green)}
                            }
                            .padding([.leading, .trailing])
                            .onAppear{
                                launchSync()
                            }
                            //Project
                            HStack{
                                Text("Loading project...")
                                Spacer()
                                if(syncProjectLoaded == false){ProgressView()}
                                else {Image(systemName:"checkmark").foregroundColor(Color.green)}
                            }
                            .padding([.leading, .trailing])
                            //Task
                            HStack{
                                Text("Loading task...")
                                Spacer()
                                if(syncTaskLoaded == false){ProgressView()}
                                else {Image(systemName:"checkmark").foregroundColor(Color.green)}
                            }
                            .padding([.leading, .trailing])
                            //Record
                            HStack{
                                Text("Loading record...")
                                Spacer()
                                if(syncRecordLoaded == false){ProgressView()}
                                else {Image(systemName:"checkmark").foregroundColor(Color.green)}
                            }
                            .padding([.leading, .trailing])
                            //Retrieve user ID
                            HStack{
                                Text("Retrieve ID...")
                                Spacer()
                                if(syncIDLoaded == false){ProgressView()}
                                else {Image(systemName:"checkmark").foregroundColor(Color.green)}
                            }
                            .padding([.leading, .trailing])
                            //Send Record
                            HStack{
                                Text("Send record...")
                                Spacer()
                                if(syncRecordSend == false){ProgressView()}
                                else {Image(systemName:"checkmark").foregroundColor(Color.green)}
                            }
                            .padding([.leading, .trailing])
                            //Update Project
                            HStack{
                                Text("Update Project...")
                                Spacer()
                                if(syncProjectUpdated == false){ProgressView()}
                                else {Image(systemName:"checkmark").foregroundColor(Color.green)}
                            }
                            .padding([.leading, .trailing])
                            //Update Task
                            HStack{
                                Text("Update Task...")
                                Spacer()
                                if(syncTaskUpdated == false){ProgressView()}
                                else {Image(systemName:"checkmark").foregroundColor(Color.green)}
                            }
                            .padding([.leading, .trailing])
                            //Sync done
                            if(syncIsDone == true){
                                HStack{
                                    Text("Sync completed")
                                        .font(.headline)
                                    Image(systemName: "checkmark.icloud")
                                        .foregroundColor(Color.green)
                                }
                                .padding()
                                .onAppear{ syncSwitchToSuccessSync() }
                            } else {
                                HStack{}.padding()
                            }
                            
                            //Affichage d'un spinner
                            if(syncShowProgress == true){
                                ProgressView()
                                .scaleEffect(2)}
                                
                        }
                    }
                    if syncState == 2 {
                        Group {
                            VStack{
                                Text("Sync done !")
                                    .font(.title2)
                                    .padding(.bottom, 50)
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(Color.green)
                                    .font(.system(size: 50))
                            }
                        }
                    }
                    if syncState == 3 {
                        Group {
                            VStack{
                                Image(systemName: "xmark.icloud")
                                    .foregroundColor(Color.red)
                                    .font(.system(size: 40))
                                Text("Error sync")
                                    .font(.title)
                                    .foregroundColor(Color.red)
                                Text(String(syncErrorMsg))
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                }
                .onAppear{
                    syncBackTo0()
                }
        }// End Navigation View
    }// End views
}

struct ViewSync_Previews: PreviewProvider {
    static var previews: some View {
        ViewSync(record:Record())
    }
}
