import Foundation
import UIKit

protocol RegisterDisplayLogic: class {
    func displayUserRegister(viewModel: Register.UserRegister.ViewModel)
}

class RegisterViewController: UIViewController {
    var interactor: RegisterBusinessLogic?
    var router: (NSObjectProtocol & RegisterRoutingLogic & RegisterDataPassing)?

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
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
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
        navigationItem.title = "Register"
    }
    
    // MARK: Do something
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard !(nameTextField.text?.isEmpty ?? true),
            !(ageTextField.text?.isEmpty ?? true),
            !(emailTextField.text?.isEmpty ?? true),
            !(passwordTextField.text?.isEmpty ?? true) else {
            showErrorDialog(title: "Error", message: "Please fill email and password")
            return
        }
        
        showLoading()
        let request = Register.UserRegister.Request(name: nameTextField.text!,
                                                    age: Int(ageTextField.text!)!,
                                                    email: emailTextField.text!,
                                                    password: passwordTextField.text!)
        interactor?.register(request: request)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        nameTextField.text = ""
        ageTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
}

extension RegisterViewController: RegisterDisplayLogic {
    func displayUserRegister(viewModel: Register.UserRegister.ViewModel) {
        hideLoading()
        guard viewModel.error == nil else {
            showErrorDialog(title: "Error", message: viewModel.error?.localizedDescription)
            return
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let `self` = self else {
                return
            }
            
            self.router?.routeToPreviousScreen()
        }
        showAlertDialog(title: "Success", message: "Register successfully", actions: okAction)
    }
}
