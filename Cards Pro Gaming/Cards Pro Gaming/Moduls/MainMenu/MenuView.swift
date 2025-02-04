//
//  MenuView.swift
//  Cards Pro Gaming
//
//  Created by Dias Atudinov on 03.02.2025.
//


import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showTrainig = false
    @State private var showGame = false
    @State private var showBestScore = false
    @State private var showHowToPlay = false
    @State private var showSettings = false
    
    //    @StateObject var trainingVM = TrainingViewModel()
    //    @StateObject var gameVM = GameViewModel()
    //    @StateObject var settingsVM = SettingsModel()
    @StateObject var teamVM = RegistrationViewModel()
    
    var body: some View {
        if let team = teamVM.currentTeam {
            GeometryReader { geometry in
                ZStack {
                    VStack(spacing: 0) {
                        Spacer()
                        
                        if geometry.size.width < geometry.size.height {
                            // Вертикальная ориентация
                            ZStack {
                                
                                VStack(spacing: 25) {
                                    
                                    
                                    HStack {
                                        Spacer()
                                        VStack {
                                            Button {
                                                showTrainig = true
                                            } label: {
                                                TextBg(text: "Training", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            
                                            Button {
                                                
                                                showGame = true
                                            } label: {
                                                TextBg(text: "Competitive mode", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            Button {
                                                withAnimation {
                                                    showBestScore = true
                                                }
                                            } label: {
                                                TextBg(text: "Best score", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            Button {
                                                
                                                showHowToPlay = true
                                            } label: {
                                                TextBg(text: "How to play?", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            Button {
                                                showSettings = true
                                            } label: {
                                                TextBg(text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                
                            }
                        } else {
                            ZStack {
                                
                                VStack(spacing: 15) {
                                    Spacer()
                                    HStack(alignment: .top) {
                                        PlayerBg()
                                        Spacer()
                                        Image(.logo)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 90)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.yellow, lineWidth: 1)
                                            }
                                        
                                        Spacer()
                                        
                                        CoinsBg(coins: "100")
                                    }
                                    VStack(spacing: 15) {
                                        
                                        HStack(spacing: 15) {
                                            Spacer()
                                            Button {
                                                showTrainig = true
                                            } label: {
                                                TextBg(text: "Training", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            Button {
                                                showGame = true
                                            } label: {
                                                TextBg(text: "Competitive mode", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            Spacer()
                                            
                                            
                                        }
                                        
                                        HStack(spacing: 15) {
                                            Spacer()
                                            Button {
                                                withAnimation {
                                                    showBestScore = true
                                                }
                                            } label: {
                                                TextBg(text: "Best score", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            Button {
                                                
                                                showHowToPlay = true
                                            } label: {
                                                TextBg(text: "How to play?", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            Spacer()
                                        }
                                        
                                        Button {
                                            showSettings = true
                                        } label: {
                                            TextBg(text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                        }
                                        
                                        
                                    }
                                    Spacer()
                                }
                                
                                
                            }
                        }
                        Spacer()
                    }
                    
                }
                .background(
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 83/255, green: 11/255, blue: 11/255),
                                Color(red: 137/255, green: 20/255, blue: 10/255),
                                Color(red: 83/255, green: 11/255, blue: 11/255)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .ignoresSafeArea()
                        .scaledToFill()
                    }.edgesIgnoringSafeArea(.all)
                    
                )
                //                                .onAppear {
                //                                    if settingsVM.musicEnabled {
                //                                        MusicPlayer.shared.playBackgroundMusic()
                //                                    }
                //                                }
                //                                .onChange(of: settingsVM.musicEnabled) { enabled in
                //                                    if enabled {
                //                                        MusicPlayer.shared.playBackgroundMusic()
                //                                    } else {
                //                                        MusicPlayer.shared.stopBackgroundMusic()
                //                                    }
                //                                }
                .fullScreenCover(isPresented: $showTrainig) {
                    // TrainingView(viewModel: trainingVM, settingsVM: settingsVM)
                }
                .fullScreenCover(isPresented: $showGame) {
                    //  OnlineView(teamVM: teamVM, settingsVM: settingsVM)
                }
                .fullScreenCover(isPresented: $showHowToPlay) {
                    // RulesView()
                }
                .fullScreenCover(isPresented: $showSettings) {
                    // SettingsView(settings: settingsVM, teamVM: teamVM)
                    
                }
                
            }
        } else {
            RegistrationView(viewModel: teamVM)
        }
        
    }
    
    
}

#Preview {
    MenuView()
}
