import Foundation

public struct JSONConverter {
    private static var encoder = JSONEncoder()
    private static let decoder = JSONDecoder()

    private static var outputFormatting: JSONEncoder.OutputFormatting {
        var formatting = JSONEncoder.OutputFormatting()

        formatting.insert(.prettyPrinted)
        formatting.insert(.withoutEscapingSlashes)

        return formatting
    }

    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        return formatter
    }

    public static func encode<T: Encodable>(_ object: T) -> Data? {
        encoder.outputFormatting = outputFormatting
        encoder.dateEncodingStrategy = .formatted(dateFormatter)

        return try? encoder.encode(object)
    }

    public static func decode<T: Decodable>(_ data: Data) -> T? {
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try? decoder.decode(T.self, from: data)
    }
}
