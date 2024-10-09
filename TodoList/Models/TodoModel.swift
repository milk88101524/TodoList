//
//  Todo.swift
//  TodoList
//
//  Created by Han on 2024/9/25.
//

import Foundation

struct Todo: Codable {
    var id: String
    var title: String
    var isFinish: Bool
}

class TodoManager {
    private let userDefaults = UserDefaults.standard
    private let todosKey = "todosKey"
    
    // 儲存單一筆 Note
    func saveTodo(todo: String) {
        // 先取得目前已存的 Note 陣列
        var savedNotes = loadTodos()
        
        let addTodo = Todo(id: UUID().uuidString, title: todo, isFinish: false)
        
        // 加入新的 Note
        savedNotes.append(addTodo)
        
        // 將 Note 陣列編碼成 JSON Data
        if let encodedData = try? JSONEncoder().encode(savedNotes) {
            // 將編碼後的資料儲存至 UserDefaults
            userDefaults.set(encodedData, forKey: todosKey)
        }
    }
    
    // 更新 Todo 的完成狀態
    func updateTodo(id: String, finished: Bool) {
        var savedTodos = loadTodos()
        
        // 找到對應的 Todo 並修改它的 isFinish
        if let index = savedTodos.firstIndex(where: { $0.id == id }) {
            savedTodos[index].isFinish = finished
            
            // 將更新後的陣列儲存回 UserDefaults
            if let encodedData = try? JSONEncoder().encode(savedTodos) {
                userDefaults.set(encodedData, forKey: todosKey)
            }
        }
    }
    
    func deleteTodo(id: String) {
        var savedTodos = loadTodos()
        
        if let index = savedTodos.firstIndex(where: { $0.id == id }) {
            savedTodos.remove(at: index)
            
            if let encodedData = try? JSONEncoder().encode(savedTodos) {
                userDefaults.set(encodedData, forKey: todosKey)
            }
        }
    }
    
    // 取得所有 Note
    func loadTodos() -> [Todo] {
        // 從 UserDefaults 中取得資料
        if let savedData = userDefaults.data(forKey: todosKey) {
            // 將資料解碼回 [Note]
            if let decodedNotes = try? JSONDecoder().decode([Todo].self, from: savedData) {
                return decodedNotes
            }
        }
        return [] // 如果沒有資料，返回空陣列
    }
    
    // 刪除所有 Notes
    func deleteAllNotes() {
        userDefaults.removeObject(forKey: todosKey)
    }
}
