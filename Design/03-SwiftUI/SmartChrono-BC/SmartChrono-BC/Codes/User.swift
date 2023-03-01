//
//  User.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 01/03/2023.
//

import Foundation

class User: Codable {
    
    var login: String = ""
    var password: String = "" // Will need this for FaceID ;)
    var id:Int = 0
    
    
    init() {
        loadUser()
    }
    
    
    func loadUser(){
        var fileURL:URL
        let fm = FileManager.default
        let dir = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if dir.count != 0 {
            fileURL = dir[0].appendingPathComponent("user.json")
        } else {
            print("class User - unable to obtain a valid file path")
            return;
        }
        
        if let data = try? Data(contentsOf: fileURL), let user = try? JSONDecoder().decode(User.self, from: data) {
            self.login = user.login
            self.password = user.password
            self.id = user.id
        } else {
            self.login = ""
            self.password = ""
            self.id = 0
        }
    }
    
    func saveUser(){
        var fileURL:URL
        let fm = FileManager.default
        let dir = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if dir.count != 0 {
            fileURL = dir[0].appendingPathComponent("user.json")
        } else {
            print("class User - unable to obtain a valid file path")
            return;
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(self) {
            try? data.write(to: fileURL)
        }
    }
    
    func reload() {
        var fileURL:URL
        let fm = FileManager.default
        let dir = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if dir.count != 0 {
            fileURL = dir[0].appendingPathComponent("user.json")
        } else {
            print("class User - unable to obtain a valid file path")
            return;
        }
        
        if let data = try? Data(contentsOf: fileURL), let user = try? JSONDecoder().decode(User.self, from: data) {
            self.login = user.login
            self.password = user.password
            self.id = user.id
        } else {
            self.login = ""
            self.password = ""
            self.id = 0
        }
    }
    
}
