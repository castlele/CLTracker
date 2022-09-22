import Foundation

// MARK: - Tracks

public struct Tracks: Codable, EmptyStateRepresentable {

    public static let empty = Tracks(tracks: [])

    public var tracks: [Track]

    public func getStats() -> Stats {
        var stats = [String: Stat]()

        tracks.forEach { track in
             let tagName = track.tag?.rawValue ?? "other"

            if let _ = stats[tagName] {
                stats[tagName]?.time += track.time

            } else {
                stats[tagName] = Stat(tag: tagName, time: track.time)
            }
        }

        return Stats(stats: stats.values.map { $0 })
    }

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

// MARK: - Track

public struct Track: Codable, Equatable {

    public enum CodingKeys: String, CodingKey {
        case date
        case taskName = "task_name"
        case time
        case tag
    }

    public var date: Date
    public var taskName: String
    public var time: Float
    public var tag: Tag?

    public static func == (lhs: Track, rhs: Track) -> Bool {
        lhs.taskName == rhs.taskName && lhs.date.isEqualTo(rhs.date)
    }
}

public enum Tag: String, CaseIterable, Codable {
    case work
    case project
    case social
    case game
    case education
    case freeTime = "free_time"
    case lifeTime = "life_time"
}
