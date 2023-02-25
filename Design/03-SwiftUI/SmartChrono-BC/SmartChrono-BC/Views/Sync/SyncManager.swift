//
//  SyncManager.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 22/02/2023.
//
/*
This is a Swift code using the Alamofire library to interact with a JSON-RPC API provided by an Odoo server.

The code performs the following operations:

Authenticates the user by sending a login request to the Odoo server and retrieves the user's ID.
Sends records to the Odoo server by creating new objects in the "account.analytic.line" model.
Updates the local project and task data by fetching them from the Odoo server and storing them in a local database.
Here's an overview of the code structure:

The code defines the HTTP headers and parameters required for the requests.
The code sends a login request to the Odoo server and retrieves the user's ID.
The code sends a series of requests to the Odoo server to create new objects in the "account.analytic.line" model.
The code sends requests to the Odoo server to fetch project and task data.
The code updates the local project and task data by storing them in a local database.
*/

import SwiftUI
import Foundation
import Alamofire






struct SyncManager: View {
    
    @State var userPassword:String = ""
    @State var userID:Int = 0
    
    @State var syncError:Bool = false
    @State var syncErrorMsg:String = ""
    @State var syncInit:Bool = false
    @State var syncShowProgress:Bool = false
    @State var syncSettingsLoaded:Bool = false
    @State var syncProjectLoaded:Bool = false
    @State var syncTaskLoaded:Bool = false
    @State var syncRecordLoaded:Bool = false
    @State var syncIDLoaded:Bool = false
    @State var syncRecordSend:Bool = false
    @State var syncProjectUpdated:Bool = false
    @State var syncTaskUpdated:Bool = false
    @State var syncIsDone:Bool = false

    @State var syncDebug:Bool = false
    @State var textString:String = "Debug is on"
    
    
func launchSync() {
        let queue = DispatchQueue(label: "syncManager")
        
            syncInit = true
            syncShowProgress = true
            print("===== Begin Sync =====")
    
            //Settings
            textString = "Loading settings"
            let settings = Settings()
            print(settings.url)
            print(settings.login)
            print(settings.DB)
            if (settings.url == "" || settings.login == "" || settings.DB == ""){
             syncErrorMsg = "in loading settings"
             syncError = true
             return;
             }
            syncSettingsLoaded = true
            
            //Project
            textString = "Loading project"
            var project = Project()
            syncProjectLoaded = true
            
            //Task
            textString = "Loading task"
            var task = Task()
            syncTaskLoaded = true
            
            //Record
            textString = "Loading record"
            var record = Record()
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
                        "args": [settings.DB, settings.login, userPassword] //Don't forget to change to userPassword
                    ]
                ]
                AF.request(settings.url + "/jsonrpc", method: .post, parameters: parameters,encoding: JSONEncoding.prettyPrinted, headers: headers)
                    .responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            if let json = value as? [String: Any] {
                                print("!Success JSON-RPC!")
                                //print("+++++")
                                //print(response.value)
                                //print("+++++")
                                // Analysez la réponse JSON
                                //userID = json["result"] ?? 0
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
                                    syncError = true
                                    return
                                }
                            }
                        case .failure(let error):
                            print(error)
                            syncErrorMsg = "Error connecting to url..."
                            syncError = true
                            return
                        }
                    }
                
                syncIDLoaded = true
            }
        
            // Send record
            func sendRecord(){
                print("Sending records...")
            for record in record.data {
                let date = record["date"] as? Date ?? Date()
                let id = record["id"] as? String ?? ""
                let duration = record["duration"] as? Int ?? 0
                let projectId = record["project"] as? String ?? ""
                let taskId = record["task"] as? String ?? ""
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-mm-dd"
                let dateString = dateFormatter.string(from: date)
                
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
                            "date":dateString, //yyyy-mm-dd
                            "task_id":taskId,
                            "unit_amount":Float(duration)/3600.0
                        ]
                                ]
                    ]
                ]
                print("send record : \(id)")
                AF.request(settings.url + "/jsonrpc", method: .post, parameters: parameters,encoding: JSONEncoding.prettyPrinted, headers: headers)
                    .responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            if let json = value as? [String: Any] {
                                let resp = json["result"] as? Int
                                if(resp == nil){
                                    print("error authenticate...")
                                    syncErrorMsg = "Authentication error during send record, check your password and your login"
                                    syncError = true
                                    return
                                }
                            }
                        case .failure(let error):
                            print(error)
                            syncErrorMsg = "Error connecting to url..."
                            syncError = true
                        }
                    }
            }
            // Third call
            projectUpdate()
            
            syncRecordSend = true
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
                        
                        //fourth call
                        taskUpdate()
                        if let json = value as? [String: Any], let resultArray = json["result"] as? [[String:Any]] {
                            for item in resultArray {
                                    if let id = item["id"] as? Int, let name = item["name"] as? String {
                                    // Rajouter le projet
                                    project.add(id, name)
                                } else {
                                    print("invalid response from Odoo")
                                    syncErrorMsg = "Invalid response from Odoo server..."
                                    syncError = true
                                    return
                                }
                                
                            }
                        } else {
                            print("Cast probleme with JSON recieved! in Project Update")
                        }
                    case .failure(let error):
                        print(error)
                        syncErrorMsg = "Error connecting to url..."
                        syncError = true
                    }
                }
            project.saveProjectData()
            
            syncProjectUpdated = true
            }
            
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
                         [],
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
                    //print("+++++")
                    //print(response.value)
                    //print("+++++")
                    if let json = value as? [String: Any], let resultArray = json["result"] as? [[String:Any]] {
                        for item in resultArray {
                            if let id = item["id"] as? Int, let name = item["name"] as? String, let respProject = item["project_id"] as? [Any], let projectId = respProject.first as? Int {
                                // Rajouter le projet à l'objet task
                                task.add(id, name, projectId)
                            } else {
                                print("invalid response from Odoo")
                                syncErrorMsg = "Invalid response from Odoo server..."
                                syncError = true
                                return
                            }
                        }
                        task.saveTaskData()
                        syncTaskUpdated = true
                    } else {
                        print("Cast probleme with JSON recieved! in Task Update")
                    }
                case .failure(let error):
                    print(error)
                    syncErrorMsg = "Error connecting to url..."
                    syncError = true
                }
            }
    // END SYNC! --------------------------------------------------------
        syncShowProgress = false
        syncIsDone = true
        print("===== End sync =====")
    }
    
        // Adding serial DispatchQueue for synchronous call.
        // https://stackoverflow.com/questions/44429221/dispatchqueue-sync-concurrent
        queue.sync {retrieveID()}

    }//End launchSync
    
    
    
    var body: some View{
        VStack{
            if (syncError == false){
                //Tant que pas d'erreur
                
                //Si launchSync est lancé
                if(syncInit == true){
                    //Debug
                    if (syncDebug == true){
                        Text(String(textString))
                    }
                    
                    Group{
                        //Settings
                        HStack{
                            Text("Loading settings...")
                            Spacer()
                            if(syncSettingsLoaded == false){ProgressView()}
                            else {Image(systemName:"checkmark").foregroundColor(Color.green)}
                        }
                        .padding([.leading, .trailing])
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
                        } else {
                            HStack{}.padding()
                        }
                        
                        //Affichage d'un spinner
                        if(syncShowProgress == true){ProgressView().scaleEffect(1.5)}
                    }
                }
                
            } else {
                //Affiche l'erreur
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
        .onAppear{launchSync()}
    }
}

struct SyncManager_Previews: PreviewProvider {
    static var previews: some View {
        SyncManager()
    }
}
