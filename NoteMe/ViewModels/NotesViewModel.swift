//
//  NotesViewModel.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 10.05.2024.
//

import Foundation
import CoreData

class NotesViewModel: ObservableObject {
    let manager: CoreDataManager
    
    @Published var notes: [Note] = []
    @Published var isLoaded = true
    
    init() {
        self.manager = CoreDataManager()
        fetchNotes()
    }
    
    func fetchNotes() {
        let request = NSFetchRequest<Note>(entityName: "Note")
        
        do {
            notes = try manager.container.viewContext.fetch(request)
        } catch {
            print("NotesViewModel fetchNotes error: \(error.localizedDescription)")
        }        
    }
    
    func createNote() -> Note {
        let newNote = Note(context: manager.container.viewContext)
        
        newNote.id = UUID()
        newNote.timestamp = Date()
        
        manager.saveContext()
        fetchNotes()
        
        return newNote
    }
    
    func updateNote(_ note: Note, title: String, content: String, tag: String) {
        note.title = title
        note.content = content
        note.tag = tag
        
        manager.saveContext()
        fetchNotes()
    }
    
    func deleteNote(_ note: Note) {
        manager.container.viewContext.delete(note)
        
        manager.saveContext()
        fetchNotes()
    }
}
