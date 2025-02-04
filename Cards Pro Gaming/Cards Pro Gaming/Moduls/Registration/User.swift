
import Foundation

struct User : Identifiable, Equatable, Codable, Hashable {
    let id = UUID()
    let icon: String
    let name: String
}
