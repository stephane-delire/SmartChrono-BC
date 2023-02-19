//
//  Settings.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 19/02/2023.
//

import Foundation

class Settings: Codable {
    static let shared = Settings()
    
    // Variables pour stocker les réglages
    var url: String = ""
    var login: String = ""
    var tableName: String = ""
    
    // Emplacement du fichier de sauvegarde
    var fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("settings.json")
    
    private enum CodingKeys: String, CodingKey {
        case url
        case login
        case tableName
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
            self.tableName = settings.tableName
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

