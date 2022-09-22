public struct Stats: Codable, EmptyStateRepresentable {

    public static let empty = Stats(stats: [])

    public var stats: [Stat]
}

// MARK: - Tracks + CustomStringConvertible

extension Stats: CustomStringConvertible {
    public var description: String {
        guard let jsonData = JSONConverter.encode(self) else {
            return .empty
        }
        
        let json = String(data: jsonData, encoding: .utf8)

        return json ?? .empty
    }
}

public struct Stat: Codable, EmptyStateRepresentable {

    public static let empty = Stat(tag: "empty", time: 0)

    public var tag: String
    public var time: Float
}
