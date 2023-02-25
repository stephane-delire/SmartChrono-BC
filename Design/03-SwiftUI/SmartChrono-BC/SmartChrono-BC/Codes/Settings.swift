//
//  Settings.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 19/02/2023.
//

import Foundation
/*
class Settings: Codable {
    static let shared = Settings()
    
    // Variables pour stocker les réglages
    var url: String = ""
    var login: String = ""
    var DB: String = ""
    
    // Emplacement du fichier de sauvegarde
    var fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("settings.json")
    
    private enum CodingKeys: String, CodingKey {
        case url
        case login
        case DB
    }
    
    init() {
        // Chargement des réglages depuis le fichier de sauvegarde
        loadSettings()
    }
    
    // Fonction pour charger les réglages depuis le fichier de sauvegarde
    func loadSettings() {
        if let data = try? Data(contentsOf: fileURL),
           let settings = try? JSONDecoder().decode(Settings.self, from: data) {
            self.url = settings.url
            self.login = settings.login
            self.DB = settings.DB
        }
    }
    
    // Fonction pour sauvegarder les réglages dans le fichier de sauvegarde
    func saveSettings() {
        let settings = Settings.shared
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(settings) {
            try? data.write(to: fileURL)
        }
    }
}
*/
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
