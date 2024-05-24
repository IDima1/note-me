//
//  CoreDataErrorHandler.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 24.05.2024.
//

import Foundation
// TODO: add error handling
enum CoreDataErrorHandler: Error {
    case saveFailure
    case fetchFailure
    case deleteFailure
    case unableToComplete
}
