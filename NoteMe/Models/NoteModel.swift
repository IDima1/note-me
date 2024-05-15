//
//  TagModel.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 15.05.2024.
//

import Foundation

enum Tag: String, CaseIterable {
    case new
    case important
    case completed
}

struct NoteModel {
    let id: UUID
    let title: String
    let content: String
    let timestamp: Date
    var tag: Tag
}
