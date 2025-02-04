struct AceChoiceView: View {
    var onSelect: (Int) -> Void
    
    var body: some View {
        
        
        HStack {
            Button {
                onSelect(1)
            } label: {
                ZStack {
                    Text("1")
                        .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                        .foregroundStyle(.yellow)
                        .textCase(.uppercase)
                        .padding(10)
                        .frame(width: 134)
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
            
            Button {
                onSelect(11)
            } label: {
                ZStack {
                    Text("11")
                        .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                        .foregroundStyle(.yellow)
                        .textCase(.uppercase)
                        .padding(10)
                        .frame(width: 134)
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
}