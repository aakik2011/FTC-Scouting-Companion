//
//  Persistence.swift
//  FTC Scouting Companion
//
//  Created by kachalia on 9/21/25.
//

import Foundation

// MARK: - Legacy Core Data Controller (Disabled)
// This file is kept for reference but the app now uses UserDefaults for data persistence
// All data models are now Codable structs stored in UserDefaults

struct PersistenceController {
    static let shared = PersistenceController()

    // Removed Core Data implementation since we're using UserDefaults
    // All data persistence is now handled through UserDefaults in ContentView.swift
    
    init() {
        // Setup sample data for previews if needed
        setupSampleDataIfNeeded()
    }
    
    // Setup sample data using UserDefaults (our actual data persistence method)
    private func setupSampleDataIfNeeded() {
        // Only setup sample data if none exists (for previews/testing)
        if UserDefaults.standard.object(forKey: "eventTeams") == nil {
            // We don't need to set up sample data by default
            // The app will create empty teams when first launched
        }
    }
}
