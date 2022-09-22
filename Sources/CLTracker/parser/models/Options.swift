import CLArgumentsParser

public enum CLOptionType: StringRepresentable {
    case help
    case stats
    case tag

    public var stringValue: String {
        switch self {
        case .help:
            return "--help"
        case .stats:
            return "--stats"
        case .tag:
            return "--tag"
        }
    }
}

public struct CLOption: OptionType {

    public static let help = CLOption(type: .help)
    public static let stats = CLOption(type: .stats)
    public static let tag = CLOption(type: .tag)

    public var type: CLOptionType

    public var arguments: [String] = []

    public var argumentsNeeded: (min: Int, max: Int) {
        switch type {
        case .help:
            return (0, 0)
        case .stats:
            return (0, 0)
        case .tag:
            return (1, 1)
        }
    }

    public var stringValue: String {
        type.stringValue
    }
}
