//
//  ContentView.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 12.05.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var coreDataManager: CoreDataManager
    
    @StateObject private var notesViewModel = NotesViewModel()
    
    var body: some View {
        if notesViewModel.manager.isLoaded {
            NotesView()
        } else {
            ProgressView("Loading...")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(CoreDataManager())
}
