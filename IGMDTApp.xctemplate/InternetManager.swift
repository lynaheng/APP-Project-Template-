import Network
import UIKit

class InternetManager {
    static var shared = InternetManager()
    
    private var monitor: NWPathMonitor
    private var queue: DispatchQueue
    private var isConnected = true
    private var firstLaunch = false
    private let setting = SettingsLauncher()
    
    init() {
        monitor = NWPathMonitor()
        queue = DispatchQueue.global()
        monitor.pathUpdateHandler = { path in
            switch path.status {
            case .satisfied:
                print("satified")
                if self.firstLaunch == false {
                    self.firstLaunch = true
                }else{
                    if self.isConnected == false {
                        self.isConnected = true
                        self.setting.dismiss()
                    }
                }
            case .unsatisfied:
                print("unsatisfied")
//            case .requiresConnection:
//                print("requiresConnection")
            
            default:
                if self.isConnected {
                    self.isConnected = false
                    self.firstLaunch = true
                    self.setting.showSettings(color: UIColor.systemRed.withAlphaComponent(0.75), message: "No Internet Connection")
                }
            }
        }
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
    
    func isConnectedToNetwork() -> Bool {
        return isConnected
    }
}
