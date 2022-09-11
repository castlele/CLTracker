public protocol LoggerRepresentable {
    func log(_ message: String)
}

public extension LoggerRepresentable {
    func log(_ message: String) {
        print(message)
    }
}
