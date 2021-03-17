import Foundation
import UIKit

@objc protocol LoginRoutingLogic {
    func routeToToDoList()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    // MARK: Routing
    
    func routeToToDoList() {
        let destination = UIStoryboard(name: "ToDo", bundle: nil).instantiateInitialViewController()
        navigateToToDoList(source: viewController!, destination: destination!)
    }

    // MARK: Navigation
    
    private func navigateToToDoList(source: LoginViewController, destination: UIViewController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = destination
    }
}
