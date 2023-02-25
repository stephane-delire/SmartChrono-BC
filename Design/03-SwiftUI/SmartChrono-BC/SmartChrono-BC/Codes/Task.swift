//
//  Task.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 24/02/2023.
//

import Foundation

class Task {
    // [id_task : ["taskName": id_project]
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
    
    func flush() {
        self.taskData = [:]
    }
    
    func add(_ id:Int, _ taskName:String, _ projectId:Int) {
        self.taskData[id] = [taskName : projectId]
    }
    
    func printData() {
        Swift.print("===== Tasks =====")
            for (taskId, taskInfo) in self.taskData {
                if let taskName = taskInfo.keys.first, let projectId = taskInfo.values.first {
                    Swift.print("Task ID: \(taskId), Name: \(taskName), Project ID: \(projectId)")
                }
            }
    }
}
