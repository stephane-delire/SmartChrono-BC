//
//  Project.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 20/02/2023.
//

import Foundation

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
    
    private func save() {
        do {
            let data = try JSONSerialization.data(withJSONObject: projects, options: [])
            try data.write(to: URL(fileURLWithPath: fileName))
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
}

