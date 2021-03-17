enum Login {
    // MARK: Use cases
    
    enum UserLogin {
        struct Request {
            let email: String
            let password: String
        }
        struct Response {
            let error: APIError?
        }
        struct ViewModel {
            let error: APIError?
        }
    }
}
