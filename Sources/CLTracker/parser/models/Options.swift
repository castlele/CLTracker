import CLArgumentsParser

public enum CLOptionType: OptionType {
    case help
    case stats

    public var stringValue: String {
        switch self {
        case .help:
            return "--help"
        case .stats:
            return "--stats"
        }
    }
}
