//
//  Record.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 19/02/2023.
//

import Foundation

class Record {
    
    var data: [[String: Any]]
    private let filename = "recordData.json"
    private let fileManager = FileManager.default
    
    init() {
        if let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = url.appendingPathComponent(filename)
            if fileManager.fileExists(atPath: fileURL.path) {
                do {
                    let jsonData = try Data(contentsOf: fileURL)
                    self.data = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] ?? []
                } catch {
                    print("Error loading record data: \(error)")
                    self.data = []
                }
            } else {
                self.data = []
                self.saveData()
            }
        } else {
            self.data = []
            print("-- Record : error with fileURL")
        }
    }
    
    func addRecord(date: String, id: String, duration: Int, project: Int, task: Int) {
        let newRecord = ["date": date, "id": id, "duration": duration, "project": project, "task": task] as [String : Any]
        self.data.append(newRecord)
        self.saveData()
    }
    
    func count() -> Int {
        return self.data.count
    }
    
    func saveData() {
        if let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = url.appendingPathComponent(filename)
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: self.data, options: .prettyPrinted)
                try jsonData.write(to: fileURL)
            } catch {
                print("Error saving record data: \(error)")
            }
        }
    }
    
    func flush() {
        self.data = []
        self.saveData()
    }
}

