import Foundation

public struct Tracks: Codable, EmptyStateRepresentable {
    public static let empty = Tracks(tracks: [])

    public var tracks: [Track]

    public mutating func track(_ track: Track) {
        if let index = getIndex(ofTrack: track) {
            tracks[index] = track
        } else {
            tracks.append(track)
        }
    }

    private func getIndex(ofTrack track: Track) -> Int? {
        tracks.firstIndex { $0 == track }
    }
}

public struct Track: Codable, Equatable {

    public enum CodingKeys: String, CodingKey {
        case date
        case taskName = "task_name"
        case time
    }

    public var date: Date
    public var taskName: String
    public var time: Double


    public static func == (lhs: Track, rhs: Track) -> Bool {
        lhs.taskName == rhs.taskName && lhs.date.isEqualTo(rhs.date)
    }
}
