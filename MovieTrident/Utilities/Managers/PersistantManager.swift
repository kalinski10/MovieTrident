//
//  PersistantManager.swift
//  MovieTrident
//
//  Created by Kalin Balabanov on 15/12/2021.
//

import SwiftUI
import CoreData

struct PersistenceManager {
    // A singleton for our entire app to use
    static let shared = PersistenceManager()

    // Storage for Core Data
    let container: NSPersistentContainer

    // A test configuration for SwiftUI previews
    static var preview: PersistenceManager = {
        let controller = PersistenceManager(inMemory: true)

        // Create 10 example saved searches.
        for _ in 0..<10 {
            let title = MovieTitle(context: controller.container.viewContext)
            title.id = UUID()
            title.title = "Thor"
        }

        return controller
    }()

    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "MovieTitle")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }
}
