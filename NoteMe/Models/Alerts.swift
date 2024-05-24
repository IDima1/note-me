//
//  Alerts.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 24.05.2024.
//

import SwiftUI

struct AlertMessage: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let saveFailure = AlertMessage(title: Text("Error"), message: Text("An error occurred while saving the note. Please try again"), dismissButton: .default(Text("OK")))
    static let fetchFailure = AlertMessage(title: Text("Error"), message: Text("An error occurred while uploading all your notes. Please try again or contact support"), dismissButton: .default(Text("OK")))
    static let deleteFailure = AlertMessage(title: Text("Error"), message: Text("An error occurred while deleting a note. try again or contact support"), dismissButton: .default(Text("OK")))
    static let unableToComplete = AlertMessage(title: Text("Error"), message: Text("An error occurred while the application was running. Try restarting the app"), dismissButton: .default(Text("OK")))
}
