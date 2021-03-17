protocol RegisterBusinessLogic {
    func register(request: Register.UserRegister.Request)
}

protocol RegisterDataStore {}

class RegisterInteractor: RegisterBusinessLogic, RegisterDataStore {
    var presenter: RegisterPresentationLogic?
    var userService = UserService()
    
    func register(request: Register.UserRegister.Request) {
        userService.register(name: request.name, age: request.age, email: request.email, password: request.password) { [weak self] (user, error) in
            let response = Register.UserRegister.Response(error: error)
            self?.presenter?.presentUserRegister(response: response)
        }
    }
}
