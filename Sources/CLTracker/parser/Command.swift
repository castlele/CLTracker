import CLArgumentsParser

public enum BaseCLCommandType: CommandType {
    case `default`
    public var argumentsNeeded: Int { 1 }

    public init() {
        self = .`default`
    }
}

public enum BaseCLOption: OptionType {
    case help

    public var stringValue: String {
        switch self {
        case .help:
            return "help"
        }
    }
}



public func test() {
    var register = BaseCLRegister<BaseCLCommand<BaseCLOption>>()
    let parser = BaseCLParser<BaseCLRegister>(register: register)

    register.register(command: BaseCLCommand(name: "track", type: BaseCLCommandType(), arguments: [], options: []))

    print(try? parser.parse(["tracker", "track"]))
    print(try? parser.parse(["tracker", "track", "name"]))
    print(try? parser.parse(["tracker", "track", "name", "time"]))
}
