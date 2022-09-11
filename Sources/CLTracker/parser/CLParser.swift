import Foundation

// MARK: - Constants

private extension Int {
    static let commandArg = 1

    static let threeArgsCommand = 4
    static let twoArgsCommand = 3

    static let nameIndex = 2
    static let timeIndex = 3
}


// MARK: - CLParser

public final class CLParser {

    // MARK: - Private properties
    
    private var arguments: [String]

    // MARK: - Init

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }

    // MARK: - Public methods
    
    public func update(arguments: [String]) {
        self.arguments = arguments
    }

    public func parse() -> CLAction {
        guard arguments.count > 1 else {
            return .error(.noArguments)
        }

        return getAction(commandArg: arguments[.commandArg])
    }

    // MARK: - Private methods
    
    private func getAction(commandArg: String) -> CLAction {
        var action: CLAction?

        CLAction.allCases.forEach {
            guard $0.stringValue == commandArg else { return }

            action = configure(action: $0)
        }

        if let action = action {
            return action
        }

        return .error(.invalidArgumentName(name: commandArg))

    }

    private func configure(action: CLAction) -> CLAction {
        switch action {
        case .error(_):
            return .error(.unknown)

        case .help:
            return .help

        case .initialize(_):
            guard arguments.count >= .twoArgsCommand else {
                return .error(.notEnoughArguments(type: .initialize(name: .empty)))
            }
            
            return .initialize(name: arguments[.nameIndex])

        case .set(_):
            guard arguments.count >= .twoArgsCommand else {
                return .error(.notEnoughArguments(type: .set(name: .empty)))
            }

            return .set(name: arguments[.nameIndex])

        case .list:
            return .list

        case .track(_, _):
            guard arguments.count >= .threeArgsCommand else {
                return .error(.notEnoughArguments(type: .track(name: .empty, time: .empty)))
            }

            return .track(name: arguments[.nameIndex], time: arguments[.timeIndex])

        case .remove(_):
            guard arguments.count >= .twoArgsCommand else {
                return .error(.notEnoughArguments(type: .remove(name: .empty)))
            }

            return .remove(name: arguments[.nameIndex])

        case .increase(_, _):
            guard arguments.count >= .threeArgsCommand else {
                return .error(.notEnoughArguments(type: .increase(name: .empty, time: .empty)))
            }

            return .increase(name: arguments[.nameIndex], time: arguments[.timeIndex])

        case .decrease(_, _):
            guard arguments.count >= .threeArgsCommand else {
                return .error(.notEnoughArguments(type: .decrease(name: .empty, time: .empty)))
            }

            return .decrease(name: arguments[.nameIndex], time: arguments[.timeIndex])

        case .print(_):
            if arguments.count == 2 {
                return .print(name: nil)
            }

            return .print(name: arguments[.nameIndex])
        }
    }
}
