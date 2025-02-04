
import SwiftUI

class Silky {
    
    static let shared = Silky()
    
    static let winStarData = "https://google.com"
    //"?page=test"
    
    @AppStorage("finalUrl") var finalURL: URL?
    
    
}
