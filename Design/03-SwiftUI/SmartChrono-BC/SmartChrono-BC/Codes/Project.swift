//
//  Project.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 20/02/2023.
//

import Foundation

//https://developer.apple.com/swift/blog/?id=37
class Project: Codable {
    
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
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
        } catch {
            // on doit créer un json vide
            let jsonData:[String:String]
            
        }
        
    }
    
    func saveProject(){}
}
