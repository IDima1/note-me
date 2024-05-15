//
//  ContentEditorView.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 14.05.2024.
//

import SwiftUI

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct ContentEditorView: View {
    @Binding var string: String
    @State var textEditorHeight : CGFloat = 20
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(string)
                .foregroundColor(.clear)
                .padding(16)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewHeightKey.self,
                                           value: $0.frame(in: .local).size.height)
                })
            
            TextEditor(text: $string)
                .frame(height: max(20, textEditorHeight))
                .border(.clear)
            
            if string.isEmpty {
                Text("Content")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .disabled(true)
                    .opacity(0.8)
                    .padding([.top, .leading], 4)
            }
        }.onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
    }
}

#Preview {
    ContentEditorView(string: .constant("Lorem ipsum dolor"))
}
