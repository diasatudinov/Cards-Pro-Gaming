//
//  ShopView.swift
//  Cards Pro Gaming
//
//  Created by Dias Atudinov on 03.02.2025.
//


import SwiftUI

struct ShopView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var shopVM: ShopViewModel

    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    HStack {
                        Text("Shop")
                            .font(.custom(Fonts.bold.rawValue, size: 40))
                            .textCase(.uppercase)
                            .foregroundStyle(.yellow)
                    }
                    
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack {
                                Image(.backIcon)
                                    .resizable()
                                    .scaledToFit()
                                
                            }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                            
                        }
                        Spacer()
                        
                        CoinsBg(coins: "")
                    }
                }.padding([.leading, .top])
                HStack(spacing: 80) {
                    ForEach(shopVM.shopItems, id: \.self) { item in
                        
                        ZStack {
                            
                            VStack(spacing: 20) {
                                
                                ZStack {
                                    if item.name == "Creators of beauty" {
                                        Image(.itemImage1)
                                            .resizable()
                                            .scaledToFit()
                                        
                                        
                                    } else if item.name == "Musical heaven" {
                                        Image(.itemImage2)
                                            .resizable()
                                            .scaledToFit()
                                        
                                    } else if item.name == "World classic" {
                                        Image(.itemImage3)
                                            .resizable()
                                            .scaledToFit()
                                        
                                    }
                                }.frame(height: DeviceInfo.shared.deviceType == .pad ? 330:165)
                                
                                Button {
                                    if shopVM.boughtItems.contains(item.name) {
                                        shopVM.currentItem = item
                                    } else {
                                        shopVM.boughtItems.append(item.name)
                                        UserCoins.shared.minusUserCoins(for: item.price)
                                    }
                                } label: {
                                    
                                    if shopVM.boughtItems.contains(item.name) {
                                        Text(shopVM.currentItem?.name == item.name ? "Selected": "Choose")
                                            .foregroundStyle(.yellow)
                                            .textCase(.uppercase)
                                            .padding(5)
                                                .padding(.horizontal, 32)
                                                .background(
                                                    Color.mainGreen
                                                )
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.yellow, lineWidth: 1)
                                                )
                                    } else {
                                        HStack {
                                            Image(.coinIcon)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 20)
                                            Text("\(item.price)")
                                                .font(.custom(Fonts.bold.rawValue, size: 20))
                                                .foregroundStyle(.yellow)
                                            
                                        }.padding(5)
                                            .padding(.horizontal, 32)
                                            .background(
                                                UserCoins.shared.coins < item.price ? Color.mainRed : Color.mainGreen
                                            )
                                            .cornerRadius(10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.yellow, lineWidth: 1)
                                            )
                                    }
                                    
                                }
                                Spacer()
                            }
                        }
                    }
                }
                
                Spacer()
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
        )
    }
}

#Preview {
    ShopView(shopVM: ShopViewModel())
}
