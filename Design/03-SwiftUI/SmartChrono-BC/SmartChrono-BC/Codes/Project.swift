//
//  Project.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 20/02/2023.
//

import Foundation
/*
class Project {
    let fileName = "Project.json"
    var projects = [String: Int]()
    
    init() {
        if let data = FileManager.default.contents(atPath: fileName) {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Int] {
                projects = json
            }
        } else {
            save()
        }
    }
    
    func addProject(name: String, id: Int) {
        projects[name] = id
        save()
    }
    
    func removeProject(name: String) {
        projects.removeValue(forKey: name)
        save()
    }
    
    func save() {
        do {
            let data = try JSONSerialization.data(withJSONObject: projects, options: [])
            try data.write(to: URL(fileURLWithPath: fileName))
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
}

 class Settings: Codable {
     
     var url: String = ""
     var login: String = ""
     var DB: String = ""
     
     
     init() {
         loadSettings()
     }
     
     
     func loadSettings(){
         var fileURL:URL
         let fm = FileManager.default
         let dir = fm.urls(for: .documentDirectory, in: .userDomainMask)
         if dir.count != 0 {
             fileURL = dir[0].appendingPathComponent("settings.json")
         } else {
             print("class Settings - unable to obtain a valid file path")
             return;
         }
         
         if let data = try? Data(contentsOf: fileURL), let settings = try? JSONDecoder().decode(Settings.self, from: data) {
             self.url = settings.url
             self.login = settings.login
             self.DB = settings.DB
         } else {
             self.url = ""
             self.login = ""
             self.DB = ""
         }
     }
     
     func saveSettings(){
         var fileURL:URL
         let fm = FileManager.default
         let dir = fm.urls(for: .documentDirectory, in: .userDomainMask)
         if dir.count != 0 {
             fileURL = dir[0].appendingPathComponent("settings.json")
         } else {
             print("class Settings - unable to obtain a valid file path")
             return;
         }
         
         let encoder = JSONEncoder()
         encoder.outputFormatting = .prettyPrinted
         if let data = try? encoder.encode(self) {
             try? data.write(to: fileURL)
         }
     }
     
 }
 */
//https://developer.apple.com/swift/blog/?id=37
class Project: Decodable {
    
    var projects: [String:Any] = [:]
    
    struct ProjectData:Decodable {
        let nom:String
        let id:String
    }
    
    init(){
        loadProject()
    }
    
    func loadProject(){
        var fileURL:URL
        let fm = FileManager.default
        let dir = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if dir.count != 0 {
            fileURL = dir[0].appendingPathComponent("project.json")
        } else {
            print("class Project - unable to obtain a valid file path")
            return;
        }
        
        if let data = try? Data(contentsOf: fileURL){
            let decoder = JSONDecoder()
            if let ProjectData = try? decoder.decode(ProjectData.self, from: data){
                self.projects = [ProjectData.nom: ProjectData.id]
            } else {
                //impossible d'ouvrir le json
            }
        } else {
            //No project.json found
            self.projects = [:]
            
        }
    }
    
    func saveProject(){}
}
