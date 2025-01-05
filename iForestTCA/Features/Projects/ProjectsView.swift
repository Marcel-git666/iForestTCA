//
//  ProjectsView.swift
//  iForestTCA
//
//  Created by Marcel Mravec on 05.01.2025.
//

import SwiftUI
import ComposableArchitecture

struct ProjectsView: View {
    @Bindable var store: StoreOf<ProjectsFeature>
    @ObservedObject private var viewStore: ViewStore<ProjectsFeature.State, ProjectsFeature.Action>
    
    init(store: StoreOf<ProjectsFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewStore.projects) { project in
                    Text(project.name)
                }
                .onDelete { indexSet in
                    indexSet.map { viewStore.projects[$0].id }
                        .forEach { viewStore.send(.removeProject($0)) }
                }
            }
            .navigationTitle("Projects")
            .toolbar {
                Button("Add") {
                    viewStore.send(.addProject("New Project"))
                }
            }
        }
    }
}

#Preview {
    ProjectsView(
        store: Store(
            initialState: ProjectsFeature.State()) {
                ProjectsFeature()
            })
}
