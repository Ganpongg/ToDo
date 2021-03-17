import Foundation
import UIKit

@objc protocol ToDoDetailRoutingLogic {
    func routeToToDoListScreenAfterCreate()
    func routeToToDoListScreenAfterUpdate()
    func routeToToDoListScreenAfterDelete()
    func routeToToDoListScreen()
}

protocol ToDoDetailDataPassing {
    var dataStore: ToDoDetailDataStore? { get }
}

class ToDoDetailRouter: NSObject, ToDoDetailRoutingLogic, ToDoDetailDataPassing {
    weak var viewController: ToDoDetailViewController?
    var dataStore: ToDoDetailDataStore?
    
    // MARK: Routing
    
    func routeToToDoListScreenAfterCreate() {
        if let toDoListDataStore = toDoListDataStore() {
            var toDoListDataStore = toDoListDataStore
            passDataToToDoListScreenAfterCreate(source: dataStore!, destination: &toDoListDataStore)
        }
        navigateToPreviousScreen(source: viewController!)
    }
    
    func routeToToDoListScreenAfterUpdate() {
        if let toDoListDataStore = toDoListDataStore() {
            var toDoListDataStore = toDoListDataStore
            passDataToToDoListScreenAfterUpdate(source: dataStore!, destination: &toDoListDataStore)
        }
        navigateToPreviousScreen(source: viewController!)
    }
    
    func routeToToDoListScreenAfterDelete() {
        if let toDoListDataStore = toDoListDataStore() {
            var toDoListDataStore = toDoListDataStore
            passDataToToDoListScreenAfterDelete(source: dataStore!, destination: &toDoListDataStore)
        }
        navigateToPreviousScreen(source: viewController!)
    }
    
    func routeToToDoListScreen() {
        navigateToPreviousScreen(source: viewController!)
    }

    // MARK: Navigation
    
    private func toDoListDataStore() -> ToDoListDataStore? {
        if let destinationVC = viewController?.navigationController?.viewControllers.first as? ToDoListViewController,
            let destinationDS = destinationVC.router?.dataStore {
            return destinationDS
        }
        return nil
    }
    
    private func navigateToPreviousScreen(source: ToDoDetailViewController) {
        source.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Passing data
    
    private func passDataToToDoListScreenAfterCreate(source: ToDoDetailDataStore, destination: inout ToDoListDataStore) {
        if let toDo = source.toDo {
            destination.toDoList?.insert(toDo, at: 0)
        }
    }
    
    private func passDataToToDoListScreenAfterUpdate(source: ToDoDetailDataStore, destination: inout ToDoListDataStore) {
        if let toDo = source.toDo,
            let index = destination.toDoList?.firstIndex(where: { $0.id == source.toDo?.id }) {
            destination.toDoList?[index] = toDo
        }
    }
    
    private func passDataToToDoListScreenAfterDelete(source: ToDoDetailDataStore, destination: inout ToDoListDataStore) {
        if let index = destination.toDoList?.firstIndex(where: { $0.id == source.toDo?.id }) {
            destination.toDoList?.remove(at: index)
        }
    }
}
