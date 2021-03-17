@testable import ToDo

class TaskServiceStub: TaskService {
    var getToDoListSuccessStub: Bool = true
    
    override func getToDoList(completion: @escaping GetToDoListResponse) {
        if !getToDoListSuccessStub {
            completion(nil, APIError.unknownError(error: nil))
            return
        }
        completion(ToDoMocks.ToDoListResponseMock, nil)
    }
    
    override func getToDoDetail(id: String, completion: @escaping GetToDoDetailResponse) {
        if id == "0" {
            completion(nil, APIError.unknownError(error: nil))
            return
        }
        completion(ToDoMocks.ToDoResponseMock, nil)
    }
    
    override func createToDo(description: String, completion: @escaping CreateToDoResponse) {
        if description.isEmpty {
            completion(nil, APIError.unknownError(error: nil))
            return
        }
        completion(ToDoMocks.ToDoResponseMock, nil)
    }
    
    override func updateToDo(id: String, description: String, completed: Bool, completion: @escaping UpdateToDoResponse) {
        if id == "0" {
            completion(nil, APIError.unknownError(error: nil))
            return
        }
        completion(ToDoMocks.ToDoResponseMock, nil)
    }
    
    override func deleteToDo(id: String, completion: @escaping DeleteToDoResponse) {
        if id == "0" {
            completion(nil, APIError.unknownError(error: nil))
            return
        }
        completion(nil, nil)
    }
}
