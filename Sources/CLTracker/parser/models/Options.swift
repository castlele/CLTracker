import CLArgumentsParser

public enum CLOptionType: OptionType {
    case help

    public var stringValue: String {
        switch self {
        case .help:
            return "--help"
        }
    }
}
