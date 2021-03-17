import Foundation

protocol RegisterPresentationLogic {
    func presentUserRegister(response: Register.UserRegister.Response)
}

class RegisterPresenter: RegisterPresentationLogic {
    weak var viewController: RegisterDisplayLogic?
    
    // MARK: Do something
    
    func presentUserRegister(response: Register.UserRegister.Response) {
        let viewModel = Register.UserRegister.ViewModel(error: response.error)
        viewController?.displayUserRegister(viewModel: viewModel)
    }
}
