//
//  SettingsModel.swift
//  Cards Pro Gaming
//
//  Created by Dias Atudinov on 03.02.2025.
//


import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
    @AppStorage("musicEnabled") var musicEnabled: Bool = true
}
