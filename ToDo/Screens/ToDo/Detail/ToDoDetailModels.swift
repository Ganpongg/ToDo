enum ToDoDetail {
    // MARK: Use cases
    
    enum GetToDoDetail {
        struct Request {
            let id: String
        }
        struct Response {
            let toDo: ToDo?
            let error: APIError?
        }
        struct ViewModel {
            let toDo: ToDo?
            let error: APIError?
        }
    }
    
    enum CreateToDo {
        struct Request {
            let description: String
        }
        struct Response {
            let error: APIError?
        }
        struct ViewModel {
            let error: APIError?
        }
    }
    
    enum UpdateToDo {
        struct Request {
            let id: String
            let description: String
            let completed: Bool
        }
        struct Response {
            let error: APIError?
        }
        struct ViewModel {
            let error: APIError?
        }
    }
    
    enum DeleteToDo {
        struct Request {
            let id: String
        }
        struct Response {
            let error: APIError?
        }
        struct ViewModel {
            let error: APIError?
        }
    }
}
