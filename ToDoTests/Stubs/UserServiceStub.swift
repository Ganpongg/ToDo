@testable import ToDo

class UserServiceStub: UserService {
    override func login(email: String, password: String, completion: @escaping LoginResponse) {
        if email.isEmpty || password.isEmpty {
            completion(nil, APIError.unknownError(error: nil))
            return
        }
        completion(UserMocks.UserResponseMock, nil)
    }
    
    override func register(name: String, age: Int, email: String, password: String, completion: @escaping RegisterResponse) {
        if name.isEmpty || email.isEmpty || password.isEmpty {
            completion(nil, APIError.unknownError(error: nil))
            return
        }
        completion(UserMocks.UserResponseMock, nil)
    }
    
    override func logout(completion: @escaping LogoutResponse) {
        completion(nil, nil)
    }
}
