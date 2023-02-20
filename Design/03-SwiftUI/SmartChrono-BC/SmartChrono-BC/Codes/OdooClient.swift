//
//  OdooClient.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 20/02/2023.
//

import Foundation

class OdooClient {
    let serverUrl: String
    let databaseName: String
    let username: String
    let password: String
    var uid: Int?
    
    init(serverUrl: String, databaseName: String, username: String, password: String) {
        self.serverUrl = serverUrl
        self.databaseName = databaseName
        self.username = username
        self.password = password
    }
    
    func authenticate() throws {
        let common = XmlRpcClient(serverUrl: "\(serverUrl)/xmlrpc/2/common")
        let result = try common.call(methodName: "authenticate", parameters: [databaseName, username, password, [:]])
        uid = result as? Int
        if uid == nil {
            throw OdooError.authenticationFailed
        }
    }
    
    func execute(method: String, model: String, parameters: [Any]) throws -> Any {
        guard let uid = uid else {
            throw OdooError.notAuthenticated
        }
        let models = XmlRpcClient(serverUrl: "\(serverUrl)/xmlrpc/2/object")
        return try models.call(methodName: method, parameters: [databaseName, uid, password, model] + parameters)
    }
    
    func checkAccessRights(model: String, operation: String) throws -> Bool {
        let result = try execute(method: "execute_kw", model: model, parameters: [["read"], ["raise_exception": false]])
        return result as? Bool ?? false
    }
    
    func search(model: String, domain: [Any]) throws -> [Int] {
        let result = try execute(method: "execute_kw", model: model, parameters: [domain])
        return result as? [Int] ?? []
    }
    
    func searchCount(model: String, domain: [Any]) throws -> Int {
        let result = try execute(method: "execute_kw", model: model, parameters: [domain, ["count"]])
        return result as? Int ?? 0
    }
    
    func read(model: String, ids: [Int], fields: [String]) throws -> [[String: Any]] {
        let result = try execute(method: "execute_kw", model: model, parameters: [ids, ["fields": fields]])
        return result as? [[String: Any]] ?? []
    }
    
    func fieldsGet(model: String) throws -> [String: [String: Any]] {
        let result = try execute(method: "execute_kw", model: model, parameters: [])
        return result as? [String: [String: Any]] ?? [:]
    }
    
    func searchRead(model: String, domain: [Any], fields: [String], limit: Int) throws -> [[String: Any]] {
        let result = try execute(method: "execute_kw", model: model, parameters: [domain, ["fields": fields, "limit": limit]])
        return result as? [[String: Any]] ?? []
    }
    
    func create(model: String, values: [String: Any]) throws -> Int {
        let result = try execute(method: "execute_kw", model: model, parameters: [values])
        return result as? Int ?? 0
    }
    
    func write(model: String, id: Int, values: [String: Any]) throws -> Bool {
        let result = try execute(method: "execute_kw", model: model, parameters: [[id], values])
        return result as? Bool ?? false
    }
    
}
