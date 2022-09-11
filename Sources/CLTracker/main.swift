private class CLRunner {
    
    static let shared = CLRunner()

    private let service = CLService()

    private init() { }

    func main() {
        service.run()
    }
}

CLRunner.shared.main()
