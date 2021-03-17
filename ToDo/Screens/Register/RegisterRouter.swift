import Foundation

@objc protocol RegisterRoutingLogic {
    func routeToPreviousScreen()
}

protocol RegisterDataPassing {
    var dataStore: RegisterDataStore? { get }
}

class RegisterRouter: NSObject, RegisterRoutingLogic, RegisterDataPassing {
    weak var viewController: RegisterViewController?
    var dataStore: RegisterDataStore?
    
    // MARK: Routing
    
    func routeToPreviousScreen() {
        navigateToPreviousScreen(source: viewController!)
    }

    // MARK: Navigation
    
    private func navigateToPreviousScreen(source: RegisterViewController) {
        source.navigationController?.popViewController(animated: true)
    }
}
