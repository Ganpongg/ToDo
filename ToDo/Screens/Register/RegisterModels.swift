enum Register {
    // MARK: Use cases
    
    enum UserRegister {
        struct Request {
            let name: String
            let age: Int
            let email: String
            let password: String
        }
        struct Response {
            let error: Error?
        }
        struct ViewModel {
            let error: Error?
        }
    }
}
