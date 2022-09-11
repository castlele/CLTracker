public extension Array {
    subscript(safe index: Int) -> Element? {
        self.enumerated().first { _index, element in _index == index }?.element
    }
}
