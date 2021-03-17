import Foundation
import UIKit

@objc protocol ToDoListRoutingLogic {
    func routeToLoginScreen()
    func routeToToDoDetailScreen()
}

protocol ToDoListDataPassing {
    var dataStore: ToDoListDataStore? { get }
}

class ToDoListRouter: NSObject, ToDoListRoutingLogic, ToDoListDataPassing {
    weak var viewController: ToDoListViewController?
    var dataStore: ToDoListDataStore?
    
    // MARK: Routing
    
    func routeToLoginScreen() {
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        navigateToLoginScreen(source: viewController!, destination: destination!)
    }
    
    func routeToToDoDetailScreen() {
        let destination = UIStoryboard(name: "ToDo", bundle: nil).instantiateViewController(identifier: "ToDoDetailViewController") as! ToDoDetailViewController
        var destinationDataStore = destination.router!.dataStore
        passDataToToDoDetailScreen(source: dataStore!, destination: &destinationDataStore!)
        navigateToToDoDetailScreen(source: viewController!, destination: destination)
    }
    
    // MARK: Navigation
    
    private func navigateToLoginScreen(source: ToDoListViewController, destination: UIViewController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = destination
    }
    
    private func navigateToToDoDetailScreen(source: ToDoListViewController, destination: ToDoDetailViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Passing data
    
    private func passDataToToDoDetailScreen(source: ToDoListDataStore, destination: inout ToDoDetailDataStore) {
        destination.toDo = source.selectedToDo
    }
}
