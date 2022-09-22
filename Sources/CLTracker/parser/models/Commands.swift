import CLArgumentsParser

public typealias CLCommand = BaseCLCommand<CLOption, CLCommandType>

public enum CLCommandType: CaseIterable, StringRepresentable {
    case tracker
    case initialize
    case set
    case list
    case track
    case remove
    case increase
    case decrease
    case print

    public var stringValue: String {
        switch self {
        case .tracker:
            #if DEBUG
            return ".build/arm64-apple-macosx/debug/tracker"
            #else
            return  "tracker"
            #endif

        case .initialize:
            return  "init"

        case .set:
            return "set"
            
        case .list:
            return "list"

        case .track:
            return "track"

        case .remove:
            return "remove"

        case .increase:
            return "increase"

        case .decrease:
            return "decrease"

        case .print:
            return "print"
        }
    }

    public var argumentsNeeded: (min: Int, max: Int) {
        switch self {
        case .tracker:
            return (0, 0)

        case .initialize:
            return  (1, 1)

        case .set:
            return (1, 1)
            
        case .list:
            return (0, 0)

        case .track:
            return (2, 3)

        case .remove:
            return (1, 1)

        case .increase:
            return (2, 2)

        case .decrease:
            return (2, 2)

        case .print:
            return (0, 1)
        }
    }

    public var options: [String: CLOption] {
        switch self {
        case .tracker:
            return [CLOptionType.help.stringValue: .help]

        case .initialize:
            return  [:]

        case .set:
            return [:]
            
        case .list:
            return [:]

        case .track:
            return [CLOptionType.tag.stringValue: .tag]

        case .remove:
            return [:]

        case .increase:
            return [:]

        case .decrease:
            return [:]

        case .print:
            return [CLOptionType.stats.stringValue: .stats]
        }
    }
}
