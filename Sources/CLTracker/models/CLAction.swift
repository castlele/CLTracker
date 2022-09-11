public indirect enum CLAction: CaseIterable, StringRepresentable {
    case error(CLError)
    case help
    case initialize(name: String)
    case set(name: String)
    case list
    case track(name: String, time: String)
    case remove(name: String)
    case increase(name: String, time: String)
    case decrease(name: String, time: String)
    case print(name: String?) // TODO: make a String... type

    public static var allCases: [CLAction] {
        [
            CLAction.error(.unknown),
            CLAction.help,
            CLAction.initialize(name: .empty),
            CLAction.set(name: .empty),
            CLAction.list,
            CLAction.track(name: .empty, time: .empty),
            CLAction.remove(name: .empty),
            CLAction.increase(name: .empty, time: .empty),
            CLAction.decrease(name: .empty, time: .empty),
            CLAction.print(name: nil),
        ]
    }

    public var stringValue: String {
        switch self {
        case .error(_):
            return "error"

        case .help:
            return "help"

        case .initialize(_):
            return "init"

        case .set(_):
            return "set"
            
        case .list:
            return "list"

        case .track(_, _):
            return "track"

        case .remove(_):
            return "remove"

        case .increase(_, _):
            return "increase"

        case .decrease(_, _):
            return "decrease"

        case .print(_):
            return "print"
        }
    }
}
