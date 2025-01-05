//
//  ProjectsFeature.swift
//  iForestTCA
//
//  Created by Marcel Mravec on 05.01.2025.
//

import ComposableArchitecture
import Foundation

// Stav aplikace pro projekty
struct ProjectsFeature: Reducer {
    @Dependency(\.uuid) var uuid
    
    struct State: Equatable {
        var projects: [Project] = [] // Seznam projektů
    }
    
    enum Action: Equatable {
        case addProject(String) // Přidání nového projektu
        case removeProject(UUID) // Odstranění projektu
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .addProject(let name):
            let newUUID = uuid() 
                print("Generated UUID: \(newUUID)")
                state.projects.append(Project(id: newUUID, name: name))
            return .none
        case .removeProject(let id):
            state.projects.removeAll { $0.id == id }
            return .none
        }
    }
}
