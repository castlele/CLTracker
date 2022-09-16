import CLArgumentsParser
import Foundation

// TODO: - Refactor
@available(*, deprecated, message: "needs refactoring")
public struct CLService {

    private let logger = CLLogger()

    private let fileManager = CLFileManager.shared
    private let register = CLRegister()
    private let parser: CLParser

    public init() {
        register.configure(with: CLCommand.availableCommands)
        parser = CLParser(register: register)
    }

    public func run() {
        do {
            let commands = try parser.parse(CommandLine.arguments)

            commands.forEach { command in
                guard let type = command.type as? CLCommandType else { return }

                switch type {
                case .tracker:
                    if command.options.contains(.help) {
                        handleHelp()
                        return
                    }

                case .initialize:
                    handleInitialization(withName: command.arguments[0])

                case .set:
                    handleSetting(withName: command.arguments[0])
                    
                case .list:
                    handleListing()

                case .track:
                    handleTracking(withName: command.arguments[0], time: command.arguments[1])

                case .remove:
                    return

                case .increase:
                    handleIncreasing(withName: command.arguments[0], time: command.arguments[1])

                case .decrease:
                    handleDecreasing(withName: command.arguments[0], time: command.arguments[1])

                case .print:
                    command.options.contains(.stats)
                    ? handlePrintingStats(withName: command.arguments[safe: 0])
                    : handlePrinting(withName: command.arguments[safe: 0])
                }
            }

        } catch let CLParserError.invalidArgument(argument) {
            logger.error("invalid argument \(argument)")

        } catch let CLParserError.invalidUsage(command) {
            logger.error("invalid usage of \(command)")

        } catch let CLParserError.optionUseOfOption(option, command) { // TODO: fix naming
            logger.error("invalid usage of \(option) for \(command)")

        } catch {
            logger.error(error.localizedDescription)
        }

    }

    private func handleError(_ error: CLError) {
        logger.error(error)
    }

    private func handleHelp() {
        logger.showHelp()
    }

    private func handleInitialization(withName name: String) {
        fileManager.create(name, logger: logger)
    }
 
    private func handleSetting(withName name: String) {
        fileManager.setCurrentFile(withName: name, logger: logger)
    }

    private func handleListing() {
        fileManager.showListOfFiles(logger: logger)
    }

    private func handleTracking(withName name: String, time: String) {
        fileManager.track(name, time: makeTime(time), date: Date(), logger: logger)
    }

    private func handleRemoving(withName name: String) {
    }

    private func handleIncreasing(withName name: String, time: String) {
        fileManager.increase(name, time: makeTime(time), logger: logger)
    }

    private func handleDecreasing(withName name: String, time: String) {
        fileManager.decrease(name, time: makeTime(time), logger: logger)
    }

    private func handlePrintingStats(withName name: String?) {
        fileManager.printStats(name, logger: logger)
    }

    private func handlePrinting(withName name: String?) {
        fileManager.print(name, logger: logger)
    }

    private func makeTime(_ stringTime: String) -> Float {
        Float(stringTime) ?? 0
    }
}
