protocol LoginBusinessLogic {
    func login(request: Login.UserLogin.Request)
}

protocol LoginDataStore {}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var userService = UserService()
    
    func login(request: Login.UserLogin.Request) {
        userService.login(email: request.email, password: request.password) { [weak self] (user, error) in
            if let user = user, let token = user.token {
                KeychainHelper.shared[.token] = token
            }
            
            let response = Login.UserLogin.Response(error: error)
            self?.presenter?.presentUserLogin(response: response)
        }
    }
}
