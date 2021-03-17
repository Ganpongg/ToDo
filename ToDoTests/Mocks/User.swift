@testable import ToDo

class UserMocks {
    static let UserResponseMock = UserResponse(user: UserMock, token: "token")
    
    static let UserMock = User(name: "test", age: 26, email: "test@gmail.com")
}
