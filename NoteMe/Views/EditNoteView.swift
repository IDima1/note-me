//
//  EditNoteView.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 13.05.2024.
//

import SwiftUI

struct EditNoteView: View {
    @EnvironmentObject var notesViewModel: NotesViewModel
    
    @State var note: Note?
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var tag: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            TextField("Title", text: $title)
               .font(.title.bold())
               
            ContentEditorView(string: $content)
               .scrollDisabled(true)
               .font(.title3)
            
            Spacer()
            
            TextField("Tag", text: $tag)
                .font(.title3)
        }
        .padding(12)
        .onAppear {
            if let note = note {
                self.title = note.title ?? ""
                self.content = note.content ?? ""
                self.tag = note.tag ?? ""
            }
        }
        .toolbar {
            Button {
                updateNote(title: title, content: content, tag: tag)
            } label: {
                Text("Done")
            }
        }
        .navigationTitle("Edit Note")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, 14)
    }
    
    private func updateNote(title: String, content: String, tag: String) {
        if (title.isEmpty) && (content.isEmpty) {
           return
        }

        guard let note = note else { return }
        notesViewModel.updateNote(note, title: title, content: content, tag: tag)
    }
}

#Preview {
    EditNoteView()
        .environmentObject(NotesViewModel.init(manager: CoreDataManager()))
}
