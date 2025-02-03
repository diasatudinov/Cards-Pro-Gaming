//
//  RegistrationViewModel.swift
//  Cards Pro Gaming
//
//  Created by Dias Atudinov on 03.02.2025.
//


import SwiftUI

class RegistrationViewModel: ObservableObject {
    @Published var teams: [String] = [
        "av1",
        "av2",
        "av3",
        "av4",
        "av5",
        
        "av6",
        "av7",
        "av8",
        "av9",
        "av10",
        
        
    ]
    
    @Published var currentTeam: User? {
        didSet {
            saveTeam()
        }
    }
    
    init() {
        loadTeam()
    }
    private let userDefaultsTeamKey = "currentTeam"
    
    func saveTeam() {
        if let currentTeam = currentTeam {
            if let encodedData = try? JSONEncoder().encode(currentTeam) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsTeamKey)
            }
        }
    }
    
    func loadTeam() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsTeamKey),
           let loadedTeam = try? JSONDecoder().decode(User.self, from: savedData) {
            currentTeam = loadedTeam
        } else {
            print("No saved data found")
        }
    }
    
    func randomTeam() -> User? {
        let otherTeams = teams.filter { $0 != currentTeam?.icon }
        
        return User(icon: otherTeams.randomElement() ?? "av1", name: "")
    }
   
    func updateCurrentTeam(name: String, icon: String) {
        currentTeam = User(icon: icon, name: name)
    }
}
