//
//  NoteMeApp.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 14.05.2024.
//

import SwiftUI

@main
struct NoteMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CoreDataManager.shared)
        }
    }
}
