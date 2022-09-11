public indirect enum CLError: StringRepresentable {
    case unknown
    case noArguments
    case notEnoughArguments
    case invalidArgumentName
    case fileAlreadyExists
    case noFilesInitializedOrSet

    public var stringValue: String {
        switch self {
        case .unknown:
            return "unknown error"

        case .noArguments:
            return "No arguments was given"

        case .notEnoughArguments:
            return "Not enough arguments were given for command:"

        case .invalidArgumentName:
            return "Invalid argument name was given"

        case .fileAlreadyExists:
            return "File with name: {} already exists"

        case .noFilesInitializedOrSet:
            return "No files were initialized or set"
        }
    }
}
