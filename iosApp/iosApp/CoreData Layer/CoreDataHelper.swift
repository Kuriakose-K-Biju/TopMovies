//
//  CoreDataHelper.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataHelper {
    static let shared = CoreDataHelper()
    private init() { }
    
    // Core Data stack
        lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "TopMovieList")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    print(error.localizedDescription)
                }
            })
            
            container.viewContext.automaticallyMergesChangesFromParent = true
            return container
        }()

        // Core Data saving support
        func saveContext() {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    print(nserror)
                }
            }
        }
}
