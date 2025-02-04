//
//  ShopViewModel.swift
//  Cards Pro Gaming
//
//  Created by Dias Atudinov on 03.02.2025.
//


import SwiftUI

class ShopViewModel: ObservableObject {
    @Published var shopItems: [Item] = [
        Item(name: "Creators of beauty", images: ["inst1", "inst2", "inst3", "instEmpty", "inst4","inst5", "inst6", "inst7"], price: 0),
        Item(name: "Musical heaven", images: ["music1", "music2", "music3", "musicEmpty", "music4","music5", "music6", "music7"], price: 100),
        Item(name: "World classic", images: ["genre1", "genre2", "genre3", "genreEmpty", "genre4","genre5", "genre6", "genre7"], price: 200),

    ]
    
    @Published var boughtItems: [String] = ["Creators of beauty"] {
        didSet {
            saveItems()
        }
    }
    
    
    @Published var currentItem: Item? {
        didSet {
            saveTeam()
        }
    }
    
    init() {
        loadTeam()
        loadItems()
    }
    
    private let userDefaultsTeamKey = "boughtItem"
    private let userDefaultsItemsKey = "boughtItemArray"
    
    func getRandomItem() -> [String] {
        if let currentItem = currentItem {
            let availableItems = shopItems.filter { $0.name != currentItem.name }
            return availableItems.randomElement()?.images ?? []
        }
        return []
    }
    
    func saveTeam() {
        if let currentItem = currentItem {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsTeamKey)
            }
        }
    }
    
    func loadTeam() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsTeamKey),
           let loadedItem = try? JSONDecoder().decode(Item.self, from: savedData) {
            currentItem = loadedItem
        } else {
            currentItem = shopItems[0]
            print("No saved data found")
        }
    }
    
    func saveItems() {
        
        if let encodedData = try? JSONEncoder().encode(boughtItems) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsItemsKey)
        }
        
    }
    
    func loadItems() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsItemsKey),
           let loadedItem = try? JSONDecoder().decode([String].self, from: savedData) {
            boughtItems = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
}

struct Item: Codable, Hashable {
    var id = UUID()
    var name: String
    var images: [String]
    var price: Int
}
