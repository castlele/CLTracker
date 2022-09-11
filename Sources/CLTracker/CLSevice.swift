import Foundation

public final class CLService {

    private var logger: CLLogger?
    private var fileManager: CLFileManager?

    public func run(parser: CLParser, logger: CLLogger, fileManager: CLFileManager) {
        self.logger = logger
        self.fileManager = fileManager

        let action = parser.parse()

        switch action {
        case let .error(error):
            handleError(error)

        case .help:
            handleHelp()

        case let .initialize(name):
            handleInitialization(withName: name)

        case let .set(name):
            handleSetting(withName: name)

        case .list:
            handleListing()

        case let .track(name, time):
            handleTracking(withName: name, time: time)

        case let .remove(name):
            handleRemoving(withName: name)

        case let .increase(name, time):
            handleIncreasing(withName: name, time: time)

        case let .decrease(name, time):
            handleDecreasing(withName: name, time: time)

        case let .print(name):
            handlePrinting(withName: name)
        }
    }

    private func handleError(_ error: CLError) {
        logger?.error(error)
    }

    private func handleHelp() {
        logger?.showHelp()
    }

    private func handleInitialization(withName name: String) {
        fileManager?.create(name, logger: logger)
    }
 
    private func handleSetting(withName name: String) {
        fileManager?.setCurrentFile(withName: name, logger: logger)
    }

    private func handleListing() {
        fileManager?.showListOfFiles(logger: logger)
    }

    private func handleTracking(withName name: String, time: String) {
        fileManager?.track(name, time: makeTime(time), date: Date(), logger: logger)
    }

    private func handleRemoving(withName name: String) {
    }

    private func handleIncreasing(withName name: String, time: String) {
    }

    private func handleDecreasing(withName name: String, time: String) {
    }

    private func handlePrinting(withName name: String?) {
    }

    private func makeTime(_ stringTime: String) -> Double {
        Double(stringTime) ?? 0
    }
}
