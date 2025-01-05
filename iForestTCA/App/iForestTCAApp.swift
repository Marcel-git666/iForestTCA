//
//  iForestTCAApp.swift
//  iForestTCA
//
//  Created by Marcel Mravec on 05.01.2025.
//

import Foundation
import SwiftUI
import ComposableArchitecture

@main
struct iForestTCAApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ProjectsView(
                    store: Store(
                        initialState: ProjectsFeature.State()) {
                            ProjectsFeature()
                        })
            }
        }
    }
}
