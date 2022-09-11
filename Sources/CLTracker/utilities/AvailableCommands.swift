public extension CLCommand {
    static var availableCommands: [CLCommand] {
        CLCommandType.allCases.map { CLCommand(name: $0.stringValue, type: $0, availableOptions: $0.options) }
    }
}
