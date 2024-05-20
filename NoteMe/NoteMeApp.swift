//
//  NoteMeApp.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 14.05.2024.
//

import SwiftUI

@main
struct NoteMeApp: App {
    let coreDataManager = CoreDataManager.shared
    
    @StateObject private var notesViewModel: NotesViewModel
    
    init() {
        let viewModel = NotesViewModel(manager: coreDataManager)
        _notesViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(notesViewModel: notesViewModel)
                .environmentObject(CoreDataManager.shared)
        }
    }
}
