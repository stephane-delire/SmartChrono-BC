//
//  SyncManager.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 22/02/2023.
//

import SwiftUI
import Foundation
import Alamofire






struct SyncManager: View {
    
    @State var userPassword:String = ""
    
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
        syncInit = true
        syncShowProgress = true
        
        //Settings
        textString = "Loading settings"
        let settings = Settings()
        print(settings.url)
        print(settings.login)
        print(settings.DB)
        /*if (settings.url == "" || settings.login == "" || settings.DB == ""){
            syncErrorMsg = "in loading settings"
            syncError = true
            return;
        }*/
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
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "User-Agent": "SmartChrono",
            "Connection": "keep-alive"
        ]
        var parameters: Parameters = [
            "jsonrpc": "2.0",
            "params": [
                "service": "common",
                "method": "login",
                "args": [settings.DB, settings.login, "QkkF2-TfbQ"]
            ]
        ]
        
        AF.request(settings.url + "/jsonrpc", method: .post, parameters: parameters,encoding: JSONEncoding.prettyPrinted, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        print("!Success JSON-RPC!")
                        // Analysez la réponse JSON
                        let userId = json["result"] as? Int
                        print("Retrieve user id : \(userId ?? 0)")
                        if(userId == 0){
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
                }
            }
        syncIDLoaded = true
        
        // Send record
        for record in record.data {
            let date = record["date"] as? Date ?? Date()
            let id = record["id"] as? String ?? ""
            let duration = record["duration"] as? Int ?? 0
            let projectId = record["project"] as? String ?? ""
            let taskId = record["task"] as? String ?? ""
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            let dateString = dateFormatter.string(from: date)
            
            parameters = [
                "jsonrpc": "2.0",
                "params": [
                    "service": "object",
                    "method": "execute",
                    "args": [settings.DB, settings.login, userPassword, "account.analytic.line", "create", [
                        "project_id":projectId,
                        "date":dateString, //yyyy-mm-dd
                        "task_id":taskId,
                        "unit_amount":Float(duration)/3600.0
                            ]
                        ]
                    ]
            ]
            
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
        syncRecordSend = true
        
        // Project update
        parameters = [
            "jsonrpc": "2.0",
            "params": [
                "service": "object",
                "method": "execute",
                "args": [settings.DB, settings.login, userPassword, "project.project", "search_read",
                         [],
                         ["name"]
                        ]
                ]
            ]
        AF.request(settings.url + "/jsonrpc", method: .post, parameters: parameters,encoding: JSONEncoding.prettyPrinted, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any], let resultArray = json["result"] as? [Int] {
                        for item in resultArray {
                            if let itemDict = item as? [String:Any], let id = itemDict["id"] as? Int, let name = itemDict["name"] as? String {
                                // Rajouter le projet à l'objet Project
                            } else {
                                print("invalid response from Odoo")
                                syncErrorMsg = "Invalid response from Odoo server..."
                                syncError = true
                                return
                            }
                        
                        }
                    }
                case .failure(let error):
                    print(error)
                    syncErrorMsg = "Error connecting to url..."
                    syncError = true
                }
            }
    
    }

    
    
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
                                Image(systemName: "checkmark")
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
