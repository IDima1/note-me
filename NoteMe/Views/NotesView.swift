//
//  NotesView.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 12.05.2024.
//

import SwiftUI

struct NotesView: View {
    @StateObject var notesViewModel: NotesViewModel
    
    @State var selectedNote: Note?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedNote) {
                if notesViewModel.notes.isEmpty {
                    Text("No notes yet :(")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                ForEach(notesViewModel.notes) { note in
                    NavigationLink(value: note) {
                        NoteCellView(note: note)
                    }
                }
                .onDelete { indexSet in
                    deleteNote(at: indexSet)
                }
            }
            .id(UUID())
            .navigationTitle("NoteMe!")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        createNewNote()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.black)
                    }
                }
            }
            .onAppear {
                notesViewModel.fetchNotes()
            }
            .background(RadialGradient(
                colors: [.orange, .white],
                center: .topLeading,
                startRadius: 100,
                endRadius: 800)
            )
            .scrollContentBackground(.hidden)
        } detail: {
            if let selectedNote = selectedNote {
                EditNoteView(note: selectedNote)
                    .environmentObject(notesViewModel)
            } else {
                Text("Select a Note")
            }
        }
    }
    
    private func createNewNote() {
        selectedNote = nil
        selectedNote = notesViewModel.createNote()
    }
    
    private func deleteNote(at offsets: IndexSet) {
        let selectedNotes = offsets.map { notesViewModel.notes[$0] }
        for note in selectedNotes {
            notesViewModel.deleteNote(note)
        }
    }
}

#Preview {
    NotesView(notesViewModel: NotesViewModel(manager: CoreDataManager()))
        .environmentObject(NotesViewModel(manager: CoreDataManager()))
}
