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

class Robot: Codable {
    
    var name:String?
    var modelNumber:String?
    var batteryLevel:Float?
    var job:String?
    
}

public class App {
    let router = Router()
    let cloudEnv = CloudEnv()
    let swaggerPath = projectPath + "/definitions/exmaple-swift-server.yaml"

    var robots = [Robot]()
    
    public init() throws {
    }

    func postInit() throws {
        // Capabilities
        initializeMetrics(app: self)

        // Middleware
        router.all(middleware: StaticFileServer())
        router.get("/", handler: getHandler)
        // Endpoints
        
        try initializeCRUDResources(cloudEnv: cloudEnv, router: router)
        initializeHealthRoutes(app: self)
        initializeSwaggerRoutes(app: self)
    }
    
    func getHandler(completion: ([Robot]?, RequestError?) -> Void ) -> Void {
        let robot = Robot()
        robot.batteryLevel = 0.78
        robot.job = "War Bot"
        robot.modelNumber = "XZBB12"
        robots.append(robot)
        completion(robots, nil)
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
