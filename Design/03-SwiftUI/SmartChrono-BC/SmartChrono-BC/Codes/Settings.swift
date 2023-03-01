//
//  Settings.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 19/02/2023.
//

import Foundation


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
