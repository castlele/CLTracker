private class CLRunner {
    
    static let shared = CLRunner()
    
    private let service = CLService()
    private let parser = CLParser()
    private let logger = CLLogger()
    private let fileManager = CLFileManager.shared

    private init() { }

    func main() {
        //service.run(parser: parser, logger: logger, fileManager: fileManager)
        test()
    }
}

CLRunner.shared.main()
