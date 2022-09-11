import Foundation

// MARK: - Messages

private extension String {
    static let helpMessage = """
    USAGE:
    \t tracker init <file_name>                initializes file where tracking time can be saved. There can be multiples files like that.
    \t tracker set <file_name>                 set file as current.

    COMMANDS:
    \t tracker track <task_name> <time>        append new task with spent time. Repeated command will override time.
    \t tracker increase <task_name> <time>     increase task's time with given time. If there is no entry with the given name, tool will ask for tracking new task.
    \t tracker decrease <task_name>            decrease task's time with given time.
    \t tracker remove <task_name>              removes task with given name.

    \t tracker print <file_name>               print content of the file with given name.
    \t tracker print                           print content of the current file.
    \t tracker list                            print list of initialized files.
    """

    static func errorMessage(_ error: String) -> String {
        """
        \u{001B}[0;31mError occured: \(error)
        \u{001B}[0;0m
        For usage information use:
        \t tracker help
        """
    }
}

// MARK: - CLLogger

public final class CLLogger: LoggerRepresentable {

    public func error(_ error: CLError) {
        log(.errorMessage(error.stringValue))
    }

    public func error(_ errorMessage: String) {
        log(.errorMessage(errorMessage))
    }

    public func showHelp() {
        log(.helpMessage)
    }

    public func showList(ofFiles list: [String]) {
        log(list.joined(separator: "\n"))
    }
}
