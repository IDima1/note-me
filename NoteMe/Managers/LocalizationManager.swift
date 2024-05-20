//
//  LocalizationManager.swift
//  NoteMe
//
//  Created by Dmytro Ivaniv on 20.05.2024.
//

import Foundation

protocol LocalizationManagerProtocol {
    var locale: Locale { get }
}

class LocalizationManager: LocalizationManagerProtocol, ObservableObject {
    var locale = Locale(identifier: "en")
}
