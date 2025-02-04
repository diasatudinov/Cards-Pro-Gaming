
import SwiftUI

enum PlayerType {
    case opponent
    case player
}
struct PlayerBg: View {
    @StateObject var teamVM = RegistrationViewModel()
    var playerType: PlayerType = .player
    var body: some View {
        if playerType == .player {
            if let team = teamVM.currentTeam {
                HStack(spacing: 10) {
                    Image(team.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                    VStack(alignment: .leading) {
                        Text(team.name)
                            .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 32:16))
                            .foregroundStyle(.yellow)
                        
                        ZStack {
                            
                            ProgressView(value: Double(UserCoins.shared.xp), total: 100)
                                .progressViewStyle(LinearProgressViewStyle())
                                .cornerRadius(20)
                                .accentColor(Color.mainGreen)
                                .padding(.horizontal, 1)
                            
                                .scaleEffect(y: DeviceInfo.shared.deviceType == .pad ? 8.0:4.0, anchor: .center)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.yellow, lineWidth: 1)
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 42:21)
                                }
                            
                            Text("Level \(UserCoins.shared.level)")
                                .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 20:10))
                                .foregroundStyle(.yellow)
                                .textCase(.uppercase)
                        }.frame(width: DeviceInfo.shared.deviceType == .pad ? 280:140)
                    }
                }
            }
        } else {
            
            HStack(spacing: DeviceInfo.shared.deviceType == .pad ? 20:10) {
                    Image(teamVM.randomTeam()?.icon ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                    VStack(alignment: .leading) {
                        Text("Oponent")
                            .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 32:16))
                            .foregroundStyle(.yellow)
                        
                        ZStack {
                            
                            ProgressView(value: Double(Int.random(in: 20...99)), total: 100)
                                .progressViewStyle(LinearProgressViewStyle())
                                .cornerRadius(20)
                                .accentColor(Color.mainGreen)
                                .padding(.horizontal, 1)
                            
                                .scaleEffect(y: DeviceInfo.shared.deviceType == .pad ? 8.0:4.0, anchor: .center)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.yellow, lineWidth: 1)
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 42:21)
                                }
                            
                            Text("Level \(Int.random(in: 2...6))")
                                .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 20:10))
                                .foregroundStyle(.yellow)
                                .textCase(.uppercase)
                        }.frame(width: DeviceInfo.shared.deviceType == .pad ? 280:140)
                    }
                }
            
        }
    }
}

#Preview {
    PlayerBg()
}
