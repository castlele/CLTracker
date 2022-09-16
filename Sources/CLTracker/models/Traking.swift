import Foundation

// MARK: - Tracks

public struct Tracks: Codable, EmptyStateRepresentable {
    public static let empty = Tracks(tracks: [])

    public var tracks: [Track]

    public func getStats() -> Tracks {
        var stats = [String: Track]()

        tracks.forEach { track in
            if let _ = stats[track.taskName] {
                stats[track.taskName]?.time += track.time
                stats[track.taskName]?.date = track.date

            } else {
                stats[track.taskName] = track
            }
        }

        return Tracks(tracks: stats.values.map { $0 })
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

// MARK: - Tracks + CustomStringConvertible

extension Tracks: CustomStringConvertible {
    public var description: String {
        guard let jsonData = JSONConverter.encode(self) else {
            return .empty
        }
        
        let json = String(data: jsonData, encoding: .utf8)

        return json ?? .empty
    }
}

// MARK: - Track

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
