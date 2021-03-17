import Foundation
import UIKit

protocol LoginDisplayLogic: class {
    func displayUserLogin(viewModel: Login.UserLogin.ViewModel)
}

class LoginViewController: UIViewController {
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?

    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Login"
        emailTextField.text = "register@gmail.com"
        passwordTextField.text = "test1234"
    }
    
    // MARK: Do something
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard !(emailTextField.text?.isEmpty ?? true),
            !(passwordTextField.text?.isEmpty ?? true) else {
            showErrorDialog(title: "Error", message: "Please fill email and password")
            return
        }
        
        showLoading()
        let request = Login.UserLogin.Request(email: emailTextField.text ?? "",
                                              password: passwordTextField.text ?? "")
        interactor?.login(request: request)
    }
}

extension LoginViewController: LoginDisplayLogic {
    func displayUserLogin(viewModel: Login.UserLogin.ViewModel) {
        hideLoading()
        guard viewModel.error == nil else {
            showErrorDialog(title: "Error", message: viewModel.error?.localizedDescription)
            return
        }
        
        router?.routeToToDoList()
    }
}
