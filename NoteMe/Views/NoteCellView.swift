//
//  NoteCellView.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 13.05.2024.
//

import SwiftUI

struct NoteCellView: View {
    var note: Note
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8){
                Text(note.title ?? "New note")
                    .fontWeight(.bold)
                Text(note.content ?? "No content")
                    .fontWeight(.thin)
                Text(formatDate(note.timestamp ?? Date()))
                    .fontWeight(.thin)
                    .foregroundStyle(.gray)
            }
            .padding(12)
            
            Spacer()
           
            VStack {
                if (note.tag != nil) {
                    Text(note.tag ?? "Tag")
                        .padding(8)
                        .background(.orange)
                        .clipShape(.capsule)
                }
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    NoteCellView(note: Note(context: CoreDataManager.shared.container.viewContext))
}
