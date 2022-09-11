public indirect enum CLError: StringRepresentable {
    case unknown
    case noArguments
    case notEnoughArguments(type: CLAction)
    case invalidArgumentName(name: String)
    case fileAlreadyExists(name: String)
    case noFilesInitializedOrSet

    public var stringValue: String {
        switch self {
        case .unknown:
            return "unknown error"

        case .noArguments:
            return "No arguments was given"

        case let .notEnoughArguments(type):
            return "Not enough arguments were given for command: \(type)"

        case let .invalidArgumentName(name):
            return "Invalid argument name was given: \(name)"

        case let .fileAlreadyExists(name):
            return "File with name: {\(name)} already exists"

        case .noFilesInitializedOrSet:
            return "No files were initialized or set"
        }
    }
}
