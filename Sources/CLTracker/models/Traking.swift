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

    public mutating func decrease(_ name: String, by time: Float) {
        guard let trackIndex = get(byName: name) else { return }
        tracks[trackIndex].time -= time
    }

    public mutating func increase(_ name: String, by time: Float) {
        guard let trackIndex = get(byName: name) else { return }
        tracks[trackIndex].time += time
    }

    private func getIndex(ofTrack track: Track) -> Int? {
        tracks.firstIndex { $0 == track }
    }

    private func get(byName name: String) -> Int? {
        tracks.firstIndex { $0.taskName == name }
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
    public var time: Float


    public static func == (lhs: Track, rhs: Track) -> Bool {
        lhs.taskName == rhs.taskName && lhs.date.isEqualTo(rhs.date)
    }
}
