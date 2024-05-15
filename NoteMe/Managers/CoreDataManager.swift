//
//  CoreDataManager.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 14.05.2024.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer = NSPersistentContainer(name: "Notes")
    
    @Published var isLoaded = false
    
    init() {
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
