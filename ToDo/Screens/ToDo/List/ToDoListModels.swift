enum ToDoList {
    // MARK: Use cases
    
    enum LogOut {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
    enum GetToDoList {
        struct Request {
        }
        struct Response {
            let toDos: [ToDo]
            let error: APIError?
        }
        struct ViewModel {
            let toDos: [ToDo]
            let error: APIError?
        }
    }
    
    enum SelectToDo {
        struct Request {
            let toDo: ToDo
        }
    }
    
    enum RefreshToDoList {
        struct Request {
        }
    }
}
