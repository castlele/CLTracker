public extension CLCommand {
    static var availableCommands: [CLCommand] {
        CLCommandType.allCases.map { CLCommand(name: $0.stringValue, type: $0, argumentsNeeded: $0.argumentsNeeded, availableOptions: $0.options) }
    }
}
