//
//  RegistrationView.swift
//  Cards Pro Gaming
//
//  Created by Dias Atudinov on 03.02.2025.
//


import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RegistrationViewModel
    @State private var currentTab: Int = 0
    @State private var currentTeam: User?
    @State private var nickname: String = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        
                        ZStack {
                            
                            VStack(spacing: 15) {
                                
                                Text("Name")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 70:36))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 60:30)
                                
                                ZStack {
                                    
                                    TextField("", text: $nickname)
                                        .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 32:24))
                                        .bold()
                                        .padding(.horizontal)
                                        .foregroundStyle(.yellow)
                                        .padding(10)
                                        .background(
                                            
                                            Color.mainRed
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.yellow, lineWidth: 1)
                                        )
                                    
                                }
                                
                                LazyVGrid(columns: columns, spacing: DeviceInfo.shared.deviceType == .pad ? 32:16) {
                                    ForEach(viewModel.teams.indices, id: \.self) { index in
                                        
                                        Button {
                                            currentTeam = User(icon: viewModel.teams[index], name: "")
                                        } label: {
                                            Image(viewModel.teams[index])
                                                .resizable()
                                                .foregroundColor(.black)
                                                .scaledToFit()
                                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 30 * 1.8 : 30)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .stroke(currentTeam?.icon == viewModel.teams[index] ? Color.yellow : Color.clear, lineWidth: 4)
                                                )
                                        }
                                        
                                    }
                                }
                                
                                
                            }
                        }.frame(width: DeviceInfo.shared.deviceType == .pad ? 400:213)
                        
                        
                        Button {
                            if let team = currentTeam, !nickname.isEmpty {
                                viewModel.currentTeam = User(icon: team.icon, name: nickname)
                            }
                        } label: {
                            ZStack {
                                //                                Image(currentTeam != nil && !nickname.isEmpty ? .startBtnBgOn : .startBtnBgOff)
                                //                                    .resizable()
                                //                                    .scaledToFit()
                                Text("Play")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 70:36))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                                    .padding(.horizontal, 74)
                                    .padding(.vertical, 10)
                                
                                    .background(
                                        Color.mainGreen
                                    )
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.yellow, lineWidth: 1)
                                    )
                            }
                            .frame(height: DeviceInfo.shared.deviceType == .pad ? 160:80)
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 46)
                    .background(
                        
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 83/255, green: 11/255, blue: 11/255),
                                Color(red: 137/255, green: 20/255, blue: 10/255),
                                Color(red: 83/255, green: 11/255, blue: 11/255)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.yellow, lineWidth: 1)
                    )
                    Spacer()
                }
                Spacer()
            }
        }.background(
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
                
            }.edgesIgnoringSafeArea(.all)
            
        )
    }
    
    @ViewBuilder func achivementView(image: String, header: String, imageHeight: CGFloat, team: User) -> some View {
        
        
        HStack(spacing: DeviceInfo.shared.deviceType == .pad ? 40:20) {
            
            VStack(alignment: .center, spacing: DeviceInfo.shared.deviceType == .pad ? 20:10) {
                
                
                
                
                Text(header)
                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .textCase(.uppercase)
                    .padding(.bottom, 8)
                
            }
            
        }
    }
}

#Preview {
    RegistrationView(viewModel: RegistrationViewModel())
}
