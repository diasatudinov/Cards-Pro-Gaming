
import SwiftUI
import AVFoundation

enum GameType {
    case dealer
    case online
}

struct GameWithDealer: View {
    @StateObject var user = UserCoins.shared
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settingsVM: SettingsViewModel
    @ObservedObject var shopVM: ShopViewModel
    
    @State var gameType: GameType
    
    @State private var playerCards: [Card] = []
    @State private var dealerCards: [Card] = []
    @State private var playerScore: Int = 0
    @State private var dealerScore: Int = 0
    @State private var showDealerCards = false
    @State private var gameResult: String? = nil
    @State private var isGameOver = false
    @State private var showMoney = true
    @State private var isWin = false
    
    @State private var winStrike: Int = 0
    @State private var audioPlayer: AVAudioPlayer?
    
    @State private var timer: Timer?
    @State private var progress: CGFloat = 0.0
    
    let suits = ["pk", "ch", "bb", "kr"]
    let cardTypes = [
        "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"
    ]
    
    @State private var showAceChoice = false
    @State private var selectedAceValue: Int = 11
    @State private var lastAceIndex: Int?
    
    var body: some View {
        ZStack {
            
            
            ZStack {
                Image(.playTable)
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, DeviceInfo.shared.deviceType == .pad ? 60:30)
                VStack {
                    HStack {
                        if gameType == .online {
                            HStack {
                                PlayerBg()
                                Spacer()
                            }
                        }
                    }
                    Spacer()
                    
                    HStack {
                        if gameType == .online {
                            HStack {
                                Spacer()
                                PlayerBg(playerType: .opponent)
                                
                            }
                        }
                    }
                }.padding([.leading], DeviceInfo.shared.deviceType == .pad ? 160:80).padding(.vertical)
            }
            
            
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Image(.backIcon)
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                    }
                    
                    Spacer()
                    
                    
                    
                    Spacer()
                    
                    CoinsBg(coins: "")
                }
                
                VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 60:30) {
                    if DeviceInfo.shared.deviceType == .pad {
                        Spacer()
                    }
                    // Dealer Section
                    VStack {
                        HStack {
                            if showDealerCards {
                                Text("\(dealerScore)")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 36:18))
                                    .foregroundStyle(.yellow)
                                    .padding(5)
                                    .padding(.horizontal)
                                    .background(
                                        Color.mainGreen
                                    )
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.yellow, lineWidth: 1)
                                    )
                            }
                            
                            HStack(spacing: DeviceInfo.shared.deviceType == .pad ? -60:-30) {
                                
                                ForEach(dealerCards, id: \.self) { card in
                                    CardView(card: card, hidden: !showDealerCards && dealerCards.first == card)
                                    
                                }
                            }
                        }
                        
                    }
                    
                    
                    // Player Section
                    VStack {
                        HStack {
                            
                            if showDealerCards {
                                Text("\(playerScore)")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 36:18))
                                    .foregroundStyle(.yellow)
                                    .padding(5)
                                    .padding(.horizontal)
                                    .background(
                                        Color.mainGreen
                                    )
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.yellow, lineWidth: 1)
                                    )
                            }
                            
                            HStack(spacing: DeviceInfo.shared.deviceType == .pad ? -60:-30) {
                                
                                
                                ForEach(playerCards, id: \.self) { card in
                                    CardView(card: card)
                                }
                            }
                            
                            
                        }
                        
                    }
                    if DeviceInfo.shared.deviceType == .pad {
                        Spacer()
                    }
                }
                
                
                if showAceChoice {
                    AceChoiceView { chosenValue in
                        if let index = lastAceIndex {
                            playerCards[index].value = chosenValue
                        }
                        updatePlayerScore()
                        showAceChoice = false
                    }
                } else {
                    HStack {
                        Button {
                            playSound(named: "take")
                            endPlayerTurn()
                            showMoney = true
                        }  label: {
                            ZStack {
                                Text("Stand")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                                    .padding(10)
                                    .frame(width: DeviceInfo.shared.deviceType == .pad ? 260:134)
                                    .background(
                                        Color.mainRed
                                    )
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.yellow, lineWidth: 1)
                                    )
                            }.frame(height: DeviceInfo.shared.deviceType == .pad ? 80:40)
                        }
                        
                        Button {
                            playSound(named: "turn")
                            dealCard(toPlayer: true)
                            showMoney = true
                        } label: {
                            ZStack {
                                Text("Hit")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                                
                                    .padding(10)
                                    .frame(width: DeviceInfo.shared.deviceType == .pad ? 260:134)
                                    .background(
                                        Color.mainGreen
                                    )
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.yellow, lineWidth: 1)
                                    )
                            }.frame(height: DeviceInfo.shared.deviceType == .pad ? 80:40)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .onAppear(perform: startNewGame)
            
            if isGameOver {
                ZStack {
                    Color.black.opacity(0.66).ignoresSafeArea()
                    
                    if showMoney {
                        VStack {
                            if isWin {
                                Image(.moneyBoard)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 400:200)
                                
                            } else {
                                Image(.loseText)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 132:66)
                            }
                        }.onAppear {
                            startTimer()
                        }
                    } else {
                        VStack {
                            
                            if playerScore > 21 {
                                Text("You lose!")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 100:50))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                            
                            } else if dealerScore > 21 {
                                Text("You Win!")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 100:50))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                            } else if playerScore > dealerScore {
                                Text("You Win!")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 100:50))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                            } else if playerScore == dealerScore {
                                Text("DRAW!")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 100:50))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                            } else {
                                Text("You lose!")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 100:50))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                            }
                            
                            Button {
                                startNewGame()
                            } label: {
                                TextBg(text: "Try again", textSize: DeviceInfo.shared.deviceType == .pad ? 48:24)
                            }
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                TextBg(text: "Menu", textSize: DeviceInfo.shared.deviceType == .pad ? 48:24)
                                
                            }
                        }
                        .padding(DeviceInfo.shared.deviceType == .pad ? 32: 16)
                        .padding(.horizontal, DeviceInfo.shared.deviceType == .pad ? 40:20)
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
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.yellow, lineWidth: 1)
                        )
                    }
                }
            }
        }
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
    }
    func dealCard(toPlayer: Bool) {
        let card = drawCard()
        
        if toPlayer {
            if card.type == "Ace" {
                showAceChoice = true
                lastAceIndex = playerCards.count // Сохраняем индекс туза
            }
            playerCards.append(card)
            updatePlayerScore()
        } else {
            dealerCards.append(card)
            dealerScore = calculateScore(for: dealerCards)
        }
    }
    
    func updatePlayerScore() {
        playerScore = playerCards.map { $0.value }.reduce(0, +)
        
        var aceCount = playerCards.filter { $0.type == "Ace" }.count
        while playerScore > 21 && aceCount > 0 {
            aceCount -= 1
        }
    }
    
    func calculateScore(for cards: [Card]) -> Int {
        var total = cards.map { $0.value }.reduce(0, +)
        var aceCount = cards.filter { $0.value == 11 }.count
        
        // Adjust for Aces if total exceeds 21
        while total > 21 && aceCount > 0 {
            total -= 10
            aceCount -= 1
        }
        
        return total
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if progress < 1 {
                progress += 0.01
            } else {
                showMoney = false
                progress = 0
                timer.invalidate()
            }
            
        }
    }
    
    // MARK: - Game Logic
    func startNewGame() {
        playerCards = []
        dealerCards = []
        playerScore = 0
        dealerScore = 0
        showDealerCards = false
        gameResult = nil
        isGameOver = false
        showAceChoice = false
        // Deal initial cards
        dealCard(toPlayer: true)
        dealCard(toPlayer: true)
        dealCard(toPlayer: false)
        dealCard(toPlayer: false)
    }
    
    
    
    func endPlayerTurn() {
        showDealerCards = true
        
        // Dealer's turn: dealer must draw until their score is 17 or more
        while dealerScore < 17 {
            dealCard(toPlayer: false)
        }
        
        // Determine the result
        if playerScore > 21 {
            winStrike = 0
            isWin = false
        
        } else if dealerScore > 21 {
            user.updateUserXP()
            user.updateUserCoins(for: 100)
            isWin = true
        } else if playerScore > dealerScore {
            user.updateUserXP()
            user.updateUserCoins(for: 100)
            isWin = true
        } else if playerScore == dealerScore {
            isWin = false
        } else {
            isWin = false
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isGameOver = true
        }
    }
    
    func drawCard() -> Card {
        let randomSuit = suits.randomElement()! // Случайная масть
        let randomType = cardTypes.randomElement()! // Случайный тип карты
        
        // Определяем значение карты в зависимости от типа
        let value: Int
        switch randomType {
        case "Jack", "Queen", "King":
            value = 10 // Валет, Дама, Король — по 10 очков
        case "Ace":
            value = 0 // Туз — 11 очков
        default:
            value = Int(randomType)! // Остальные карты — их числовое значение
        }
        
        return Card(design: shopVM.currentItem?.design ?? "", value: value, suit: randomSuit, type: randomType)
    }
    
    
    
    func playSound(named soundName: String) {
        if settingsVM.soundEnabled {
            if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.play()
                } catch {
                    print("Error playing sound: \(error.localizedDescription)")
                }
            }
        }
    }
    
}

#Preview {
    GameWithDealer(settingsVM: SettingsViewModel(), shopVM: ShopViewModel(), gameType: .online)
}
