protocol ToDoListBusinessLogic {
    func logout(request: ToDoList.LogOut.Request)
    func getToDoList(request: ToDoList.GetToDoList.Request)
    func selectToDo(request: ToDoList.SelectToDo.Request)
    func refreshToDoList(request: ToDoList.RefreshToDoList.Request)
}

protocol ToDoListDataStore {
    var toDoList: [ToDo]? { get set }
    var selectedToDo: ToDo? { get set }
}

class ToDoListInteractor: ToDoListBusinessLogic, ToDoListDataStore {
    var presenter: ToDoListPresentationLogic?
    var taskService = TaskService()
    var userService = UserService()
    
    var toDoList: [ToDo]?
    var selectedToDo: ToDo?
    
    func logout(request: ToDoList.LogOut.Request) {
        userService.logout { _, _ in }
        try? KeychainHelper.shared.remove(.token)
        
        let response = ToDoList.LogOut.Response()
        presenter?.presentLogOut(response: response)
    }
    
    func getToDoList(request: ToDoList.GetToDoList.Request) {
        taskService.getToDoList { [weak self] (toDoList, error) in
            self?.toDoList = toDoList?.data ?? []
            let response = ToDoList.GetToDoList.Response(toDos: self?.toDoList ?? [], error: error)
            self?.presenter?.presentToDoList(response: response)
        }
    }
    
    func selectToDo(request: ToDoList.SelectToDo.Request) {
        selectedToDo = request.toDo
    }
    
    func refreshToDoList(request: ToDoList.RefreshToDoList.Request) {
        if let toDoList = toDoList {
            let response = ToDoList.GetToDoList.Response(toDos: toDoList, error: nil)
            presenter?.presentToDoList(response: response)
        }
    }
}
