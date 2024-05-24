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
    @Published var alertItem: AlertMessage?
    @Published var isLoaded = false
    
    init(manager: CoreDataManager) {
        self.manager = manager
        fetchNotes()
    }
    
    func fetchNotes() {
        notes = manager.fetchNotes()
    }
    
    func createNote() -> Note {
        let createdNote = manager.createNote()
        fetchNotes()
         
        return createdNote
    }
    
    func updateNote(_ note: Note, title: String, content: String, tag: String) {
        manager.updateNote(note, title: title, content: content, tag: tag)
        fetchNotes()
    }
    
    func deleteNote(_ note: Note) {
        manager.deleteNote(note)
        fetchNotes()
    }
}
