import Foundation

protocol LoginPresentationLogic {
    func presentUserLogin(response: Login.UserLogin.Response)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    // MARK: Do something
    
    func presentUserLogin(response: Login.UserLogin.Response) {
        let viewModel = Login.UserLogin.ViewModel(error: response.error)
        viewController?.displayUserLogin(viewModel: viewModel)
    }
}
