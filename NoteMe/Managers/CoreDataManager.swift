//
//  CoreDataManager.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 14.05.2024.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func fetchNotes() -> [Note]
    func createNote() -> Note
    func updateNote(_ note: Note, title: String, content: String, tag: String)
    func deleteNote(_ note: Note)
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
    
    func fetchNotes() -> [Note] {
        let request = NSFetchRequest<Note>(entityName: "Note")
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("NotesViewModel fetchNotes error: \(error.localizedDescription)")
            return []
        }
    }
    
    func createNote() -> Note {
        let newNote = Note(context: container.viewContext)
        
        newNote.id = UUID()
        newNote.timestamp = Date()
        
        saveContext()
        
        return newNote
    }
    
    func updateNote(_ note: Note, title: String, content: String, tag: String) {
        note.title = title
        note.content = content
        note.tag = tag
        
        saveContext()
    }
    
    func deleteNote(_ note: Note) {
        container.viewContext.delete(note)
        
        saveContext()
    }
}
