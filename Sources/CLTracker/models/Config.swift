import Foundation

public struct Config: Codable, EmptyStateRepresentable {
    public enum CodingKeys: String, CodingKey {
        case currentTrackingFile = "current_tracking_file"
    }

    public static let empty = Config(currentTrackingFile: "~/.config/tracker/config.json")

    public var currentTrackingFile: String

    public mutating func set(_ name: String) {
        guard let index = currentTrackingFile.lastIndex(of: "/") else {
            return
        }

        currentTrackingFile.removeSubrange(currentTrackingFile.index(after: index)..<currentTrackingFile.endIndex)
        currentTrackingFile += name + ".json"
    }
}
