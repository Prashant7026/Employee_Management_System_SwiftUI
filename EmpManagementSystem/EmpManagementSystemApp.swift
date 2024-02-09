//
//  EmpManagementSystemApp.swift
//  EmpManagementSystem
//
//  Created by MacBook Pro on 09/02/24.
//

import SwiftUI

@main
struct EmpManagementSystemApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
