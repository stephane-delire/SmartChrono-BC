//
//  Task.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 24/02/2023.
//

import Foundation

class Task {
    var taskData: [Int: [String: Int]] = [:]
    
    init() {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("task.json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.taskData = try decoder.decode([Int: [String: Int]].self, from: jsonData)
            } catch {
                // Si on ne parvient pas à charger les données, on crée un fichier JSON vide
                self.saveTaskData()
            }
        }
    }
    
    func saveTaskData() {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("task.json") {
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(self.taskData)
                try jsonData.write(to: url, options: .atomic)
            } catch {
                print(error)
            }
        }
    }
}
