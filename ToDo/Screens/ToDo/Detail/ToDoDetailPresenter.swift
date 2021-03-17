import Foundation

protocol ToDoDetailPresentationLogic {
    func presentGetToDoDetail(response: ToDoDetail.GetToDoDetail.Response)
    func presentCreateToDo(response: ToDoDetail.CreateToDo.Response)
    func presentUpdateToDo(response: ToDoDetail.UpdateToDo.Response)
    func presentDeleteToDo(response: ToDoDetail.DeleteToDo.Response)
}

class ToDoDetailPresenter: ToDoDetailPresentationLogic {
    weak var viewController: ToDoDetailDisplayLogic?
    
    // MARK: Do something
    
    func presentGetToDoDetail(response: ToDoDetail.GetToDoDetail.Response) {
        let viewModel = ToDoDetail.GetToDoDetail.ViewModel(toDo: response.toDo, error: response.error)
        viewController?.displayGetToDoDetail(viewModel: viewModel)
    }
    
    func presentCreateToDo(response: ToDoDetail.CreateToDo.Response) {
        let viewModel = ToDoDetail.CreateToDo.ViewModel(error: response.error)
        viewController?.displayCreateToDo(viewModel: viewModel)
    }
    
    func presentUpdateToDo(response: ToDoDetail.UpdateToDo.Response) {
        let viewModel = ToDoDetail.UpdateToDo.ViewModel(error: response.error)
        viewController?.displayUpdateToDo(viewModel: viewModel)
    }
    
    func presentDeleteToDo(response: ToDoDetail.DeleteToDo.Response) {
        let viewModel = ToDoDetail.DeleteToDo.ViewModel(error: response.error)
        viewController?.displayDeleteToDo(viewModel: viewModel)
    }
}
