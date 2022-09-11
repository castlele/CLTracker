import Foundation

// MARK: - File names

private extension String {
    static let trackerDirectory = ".config/tracker/"
    static let configFilePath = .trackerDirectory + "config.json"
    static let fileExtension = ".json"
    static let prefix = "file://"
}

// MARK: - CLFileManager

public final class CLFileManager {

    public static let shared = CLFileManager()

    private let fileManager = FileManager.default

    private var configuration: Config?

    private var homeDirectory: String {
        fileManager.homeDirectoryForCurrentUser.absoluteString
    }

    private init() {
        setConfig()
    }

    public func showListOfFiles(logger: CLLogger?) {
        guard let logger = logger else {
            fatalError("System error: write to castlelecs@gmail.com with error description")
        }
        
        guard let url = URL(string: homeDirectory + .trackerDirectory) else {
            logger.error(.unknown)
            return
        }

        do {
            let filesPaths = try fileManager.contentsOfDirectory(at: url,
                                                                 includingPropertiesForKeys: nil,
                                                                 options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            let files = filesPaths
                .map { $0.lastPathComponent }
                .filter { $0 != "config.json" }

            logger.showList(ofFiles: files)

        } catch {
            logger.error(error.localizedDescription)
        }
    }

    public func setCurrentFile(withName name: String, logger: CLLogger?) {
        guard let configuration = configuration else {
            logger?.error(.noFilesInitializedOrSet)
            return
        }

        renameCurrentFile(name, config: configuration, logger: logger)
    }

    public func track(_ name: String, time: Double, date: Date, logger: CLLogger?) {
        guard let configuration = configuration else {
            logger?.error(.noFilesInitializedOrSet)
            return
        }

        let newTrack = Track(date: date, taskName: name, time: time)
        addNewTrack(newTrack, config: configuration, logger: logger)
    }

    public func create(_ name: String, logger: CLLogger?) {
        let trackerDirectoryPath = homeDirectory + .trackerDirectory
        let fullFilePath = trackerDirectoryPath + name + .fileExtension

        if !isFileExists(atPath: trackerDirectoryPath, logger: logger) {
            createDirectory(atPath: trackerDirectoryPath, logger: logger)
        }

        createFile(atPath: fullFilePath, logger: logger)
        createConfigFileIfNeeded(createdFilePath: fullFilePath, logger: logger)
    }

    private func renameCurrentFile(_ name: String, config: Config, logger: CLLogger?) {
        let configPath = homeDirectory + .configFilePath
        var config = config

        config.set(name)

        let json = JSONConverter.encode(config)
        write(toPath: configPath, data: json, logger: logger)
    }

    private func addNewTrack(_ track: Track, config: Config, logger: CLLogger?) {
        var tracks: Tracks = getFilesData(fromPath: config.currentTrackingFile, logger: logger)
        tracks.track(track)

        let json = JSONConverter.encode(tracks)
        write(toPath: config.currentTrackingFile, data: json, logger: logger)
    }

    private func getFilesData<T: Decodable & EmptyStateRepresentable>(fromPath path: String, logger: CLLogger?) -> T {
        guard let url = URL(string: path) else { return .empty }

        do {
            if let data = try String(contentsOf: url).data(using: .utf8) {
                let object: T? = JSONConverter.decode(data)

                return object ?? .empty
            }

            return .empty

        } catch {
            return .empty
        }
    }

    private func isFileExists(atPath path: String, logger: CLLogger?) -> Bool {
        let isFileExists = fileManager.fileExists(atPath: path)

        if isFileExists {
            logger?.error(.fileAlreadyExists(name: path))
        }

        return isFileExists
    }

    private func createDirectory(atPath path: String, logger: CLLogger?) {
        let url = URL(string: path)

        if let url = url {
            do {
                try fileManager.createDirectory(at: url, withIntermediateDirectories: true)

            } catch {
                logger?.error(error.localizedDescription)
            }
        }
    }

    private func createFile(atPath path: String, data: Data? = nil, logger: CLLogger?) {
        let formattedPath = removePrefix(forPath: path)

        guard !isFileExists(atPath: formattedPath, logger: logger) else {
            return
        }
        
        fileManager.createFile(atPath: formattedPath, contents: data)
    }

    private func write(toPath path: String, data: Data?, logger: CLLogger?) {
        guard let url = URL(string: path) else { return }

        do {
            try data?.write(to: url)
        } catch {
            logger?.error(error.localizedDescription)
        }
    }

    private func removePrefix(forPath path: String) -> String {
        guard path.starts(with: String.prefix) else { return path }

        var formattedPath = path
        formattedPath.removeSubrange(path.startIndex..<path.index(path.startIndex, offsetBy: String.prefix.count))

        return formattedPath
    }

    private func setConfig() {
        let configPath = homeDirectory + .configFilePath

        guard !isFileExists(atPath: configPath, logger: nil) else {
            return
        }

        let config: Config = getFilesData(fromPath: configPath, logger: nil)
        
        self.configuration = config
    }

    private func createConfigFileIfNeeded(createdFilePath path: String, logger: CLLogger?) {
        let configPath = homeDirectory + .configFilePath

        guard !isFileExists(atPath: configPath, logger: nil) else {
            return
        }

        let newConfig = Config(currentTrackingFile: path)
        configuration = newConfig

        let jsonConfig = JSONConverter.encode(newConfig)
        createFile(atPath: configPath, data: jsonConfig, logger: logger)
    }
}