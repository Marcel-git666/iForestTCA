//
//  ProjectsTests.swift
//  iForestTCATests
//
//  Created by Marcel Mravec on 05.01.2025.
//

import Testing
import Foundation
import ComposableArchitecture
@testable import iForestTCA

@MainActor
struct ProjectsTests {
    
    //    @Test func <#test function name#>() async throws {
    //        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    //    }
    @Test func testAddProject() async {
        let store = TestStore(
            initialState: ProjectsFeature.State() // Inicializace prázdného stavu
        ) {
            ProjectsFeature() // Reducer, který testujeme
        } withDependencies: {
            $0.uuid = .constant(UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!)
        }

        // Ověřte, že pole `projects` je na začátku prázdné
        #expect(store.state.projects.count == 0)
        // Odešlete akci a ověřte stav po jejím provedení
        await store.send(.addProject("Test Project")) {
            print("Po akci: \($0.projects)")
            $0.projects = [
                Project(id: UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!, name: "Test Project")
            ]
        }
    }

    
    @Test func testRemoveProject() async {
        let project = Project(id: UUID(), name: "To Remove")
        let store = TestStore(
            initialState: ProjectsFeature.State(projects: [project])) {
                ProjectsFeature()
            }
        
        await store.send(.removeProject(project.id)) {
            $0.projects = []
        }
        #expect(store.state.projects.isEmpty)
    }
}
