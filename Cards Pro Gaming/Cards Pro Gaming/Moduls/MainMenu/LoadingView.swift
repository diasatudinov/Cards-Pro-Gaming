//
//  LoadingView.swift
//  Cards Pro Gaming
//
//  Created by Dias Atudinov on 03.02.2025.
//

import SwiftUI

struct LoadingView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                }
                Spacer()
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                Spacer()
                ZStack {
                    VStack {
                        ZStack {
                                
                            ProgressView(value: progress, total: 100)
                                .progressViewStyle(LinearProgressViewStyle())
                                .cornerRadius(20)
                                .accentColor(Color.mainGreen)
                                .padding(.horizontal, 6)
                                
                                .scaleEffect(y: 6.0, anchor: .center)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.yellow, lineWidth: 1)
                                        .frame(height: 31)
                                }
                                .padding(.horizontal, 6)
                            
                            Text("Loading...")
                                .font(.custom(Fonts.bold.rawValue, size: 16))
                                .foregroundStyle(.yellow)
                                .textCase(.uppercase)
                        }.frame(width: UIScreen.main.bounds.width / 2.5)
                        
                    }
                }
                .foregroundColor(.black)
                .padding(.bottom, 25)
            }
        }.background(
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
                
        )
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 100 {
                progress += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    LoadingView()
}
