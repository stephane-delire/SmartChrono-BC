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

    @State var syncDebug:Bool = true
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
        //var task = Task()
        syncTaskLoaded = true
        
        //Record
        textString = "Loading record"
        var record = Record()
        syncRecordLoaded = true
        
        //Retrieve ID
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let parameters: Parameters = [
            "jsonrpc": "2.0",
            "params": [
                "service": "common",
                "method": "login",
                "args": [settings.DB, settings.DB, "QkkF2-TfbQ"]
            ]
        ]
        
        AF.request(settings.url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        // Analysez la réponse JSON ici
                        print(json)
                    }
                case .failure(let error):
                    print(error)
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
