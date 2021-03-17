@testable import ToDo

class ToDoMocks {
    static let ToDoListResponseMock = ToDoListResponse(count: 1, data: [ToDoMock])
    
    static let ToDoResponseMock = ToDoResponse(success: true, data: ToDoMock)
    
    static let ToDoMock = ToDo(id: "1", description: "description", completed: false)
}
