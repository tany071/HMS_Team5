//
//  HMS_Team_5App.swift
//  HMS-Team 5
//
//  Created by Ishan on 22/04/24.
//

import SwiftUI
import Firebase

@main
struct HMS_Team_5App: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

