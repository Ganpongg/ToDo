import Foundation

protocol ToDoListPresentationLogic {
    func presentLogOut(response: ToDoList.LogOut.Response)
    func presentToDoList(response: ToDoList.GetToDoList.Response)
}

class ToDoListPresenter: ToDoListPresentationLogic {
    weak var viewController: ToDoListDisplayLogic?
    
    // MARK: Do something
    
    func presentLogOut(response: ToDoList.LogOut.Response) {
        let viewModel = ToDoList.LogOut.ViewModel()
        viewController?.displayLogOut(viewModel: viewModel)
    }
    
    func presentToDoList(response: ToDoList.GetToDoList.Response) {
        let viewModel = ToDoList.GetToDoList.ViewModel(toDos: response.toDos, error: response.error)
        viewController?.displayToDoList(viewModel: viewModel)
    }
}
