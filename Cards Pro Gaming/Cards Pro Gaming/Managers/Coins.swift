//
//  User.swift
//  Cards Pro Gaming
//
//  Created by Dias Atudinov on 04.02.2025.



import SwiftUI

class UserCoins: ObservableObject {
    static let shared = UserCoins()
    
    @AppStorage("coins") var storedCoins: Int = 100
    @Published var coins: Int = 100
    
    @AppStorage("experience") var storedXP: Int = 0
    @Published var xp: Int = 0
    
    @AppStorage("energy") var storedEnergy: Int = 20
    @Published var energy: Int = 20
    
    init() {
        coins = storedCoins
        xp = storedXP
        energy = storedEnergy
    }
    
    func updateUserCoins(for coins: Int) {
        self.coins += coins
        storedCoins = self.coins
    }
    
    func minusUserCoins(for coins: Int) {
        self.coins -= coins
        if self.coins < 0 {
            self.coins = 0
        }
        storedCoins = self.coins
        
    }
    
    func updateUserXP() {
        self.xp += 2
        
        if self.xp > 99 {
            self.xp = 0
        }
        storedXP = self.xp
    }
    
    func buyUserEnergy() {
        minusUserCoins(for: 5)
        self.energy += 1
        storedEnergy = self.energy
    }
    
    func minusUserEnergy(for energy: Int) {
        self.energy -= energy
        storedEnergy = self.energy
    }
    
}
