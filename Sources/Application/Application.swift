import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Generated
import Health

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class App {
    let router = Router()
    let cloudEnv = CloudEnv()
    let swaggerPath = projectPath + "/definitions/exmaple-swift-server.yaml"

    public init() throws {
    }

    func postInit() throws {
        // Capabilities
        initializeMetrics(app: self)

        // Middleware
        router.all(middleware: StaticFileServer())

        // Endpoints
        
        
        try initializeCRUDResources(cloudEnv: cloudEnv, router: router)
        initializeHealthRoutes(app: self)
        initializeSwaggerRoutes(app: self)
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
