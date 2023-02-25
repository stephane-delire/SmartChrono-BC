//
//  Project.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 20/02/2023.
//

import Foundation

class Project {
    var projectData: [Int: String] = [:]
    
    init() {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("project.json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.projectData = try decoder.decode([Int: String].self, from: jsonData)
            } catch {
                // Si on ne parvient pas à charger les données, on crée un fichier JSON vide
                self.saveProjectData()
            }
        }
    }
    
    func saveProjectData() {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("project.json") {
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(self.projectData)
                try jsonData.write(to: url, options: .atomic)
            } catch {
                print(error)
            }
        }
    }
    
    func flush() {
        self.projectData = [:]
    }
    
    func add(_ key:Int, _ value:String) {
        self.projectData[key] = value
    }
}

