protocol ToDoDetailBusinessLogic {
    func getToDoDetail(request: ToDoDetail.GetToDoDetail.Request)
    func createToDo(request: ToDoDetail.CreateToDo.Request)
    func updateToDo(request: ToDoDetail.UpdateToDo.Request)
    func deleteToDo(request: ToDoDetail.DeleteToDo.Request)
}

protocol ToDoDetailDataStore {
    var toDo: ToDo? { get set }
}

class ToDoDetailInteractor: ToDoDetailBusinessLogic, ToDoDetailDataStore {
    var presenter: ToDoDetailPresentationLogic?
    var taskService = TaskService()

    var toDo: ToDo?
    
    func getToDoDetail(request: ToDoDetail.GetToDoDetail.Request) {
        if let toDo = toDo {
            let response = ToDoDetail.GetToDoDetail.Response(toDo: toDo, error: nil)
            presenter?.presentGetToDoDetail(response: response)
        } else {
            taskService.getToDoDetail(id: request.id) { [weak self] (toDo, error) in
                self?.toDo = toDo?.data
                let response = ToDoDetail.GetToDoDetail.Response(toDo: toDo?.data, error: error)
                self?.presenter?.presentGetToDoDetail(response: response)
            }
        }
    }
    
    func createToDo(request: ToDoDetail.CreateToDo.Request) {
        taskService.createToDo(description: request.description) { [weak self] (toDo, error) in
            self?.toDo = toDo?.data
            let response = ToDoDetail.CreateToDo.Response(error: error)
            self?.presenter?.presentCreateToDo(response: response)
        }
    }
    
    func updateToDo(request: ToDoDetail.UpdateToDo.Request) {
        taskService.updateToDo(id: request.id, description: request.description, completed: request.completed) { [weak self] (toDo, error) in
            self?.toDo = toDo?.data
            let response = ToDoDetail.UpdateToDo.Response(error: error)
            self?.presenter?.presentUpdateToDo(response: response)
        }
    }
    
    func deleteToDo(request: ToDoDetail.DeleteToDo.Request) {
        taskService.deleteToDo(id: request.id) { [weak self] (success, error) in
            let response = ToDoDetail.DeleteToDo.Response(error: error)
            self?.presenter?.presentDeleteToDo(response: response)
        }
    }
}
