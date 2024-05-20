//
//  CoreDataManager.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 14.05.2024.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    var isLoaded: Bool { get }
    var container: NSPersistentContainer { get }
    
    func saveContext()
}  

class CoreDataManager: ObservableObject, CoreDataManagerProtocol {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    
    @Published var isLoaded = false
    
    init() {
        container = NSPersistentContainer(name: "Notes")
        container.loadPersistentStores { description, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("CoreDataManager init error: \(error.localizedDescription)")
                }
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            self.container.viewContext.shouldDeleteInaccessibleFaults = true
            self.container.viewContext.automaticallyMergesChangesFromParent = true
            
            self.isLoaded = true
        }
    }
    
    func saveContext() {
        do {
            try container.viewContext.save()
        } catch {
            print("CoreDataManager saveContext error: \(error.localizedDescription)")
        }
    }
}
