//
//  User.swift
//  Cards Pro Gaming
//
//  Created by Dias Atudinov on 03.02.2025.
//


import Foundation

struct User : Identifiable, Equatable, Codable, Hashable {
    let id = UUID()
    let icon: String
    let name: String
}