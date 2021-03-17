import Foundation
import UIKit

protocol ToDoDetailDisplayLogic: class {
    func displayGetToDoDetail(viewModel: ToDoDetail.GetToDoDetail.ViewModel)
    func displayCreateToDo(viewModel: ToDoDetail.CreateToDo.ViewModel)
    func displayUpdateToDo(viewModel: ToDoDetail.UpdateToDo.ViewModel)
    func displayDeleteToDo(viewModel: ToDoDetail.DeleteToDo.ViewModel)
}

class ToDoDetailViewController: UIViewController {
    var interactor: ToDoDetailBusinessLogic?
    var router: (NSObjectProtocol & ToDoDetailRoutingLogic & ToDoDetailDataPassing)?
    
    var displayToDo: ToDo?

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
        let interactor = ToDoDetailInteractor()
        let presenter = ToDoDetailPresenter()
        let router = ToDoDetailRouter()
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
        setLayout()
        getToDoDetail()
    }
    
    // MARK: Do something
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var completedSwitchStackView: UIStackView!
    @IBOutlet weak var completedSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if displayToDo == nil {
            createToDoDetail()
        } else {
            updateToDoDetail()
        }
    }
    
    private func setLayout() {
        navigationItem.title = "To Do"
    }
    
    private func getToDoDetail() {
        guard let id = router?.dataStore?.toDo?.id else {
            return
        }
        
        showLoading()
        let request = ToDoDetail.GetToDoDetail.Request(id: id)
        interactor?.getToDoDetail(request: request)
    }
    
    private func createToDoDetail() {
        guard let description = descriptionTextField.text, !description.isEmpty else {
            showErrorDialog(title: "Error", message: "Please fill in the form")
            return
        }
        
        showLoading()
        let request = ToDoDetail.CreateToDo.Request(description: description)
        interactor?.createToDo(request: request)
    }
    
    private func updateToDoDetail() {
        guard let id = displayToDo?.id,
            let description = descriptionTextField.text, !description.isEmpty else {
            return
        }
        
        showLoading()
        let request = ToDoDetail.UpdateToDo.Request(id: id, description: description, completed: completedSwitch.isOn)
        interactor?.updateToDo(request: request)
    }
    
    @objc private func deleteToDoDetail() {
        guard let id = displayToDo?.id else {
            return
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.showLoading()
            let request = ToDoDetail.DeleteToDo.Request(id: id)
            self?.interactor?.deleteToDo(request: request)
        }
        showAlertDialog(title: "Delete", message: "Are you sure you want to delete?", actions: cancelAction, deleteAction)
    }
}

extension ToDoDetailViewController: ToDoDetailDisplayLogic {
    func displayGetToDoDetail(viewModel: ToDoDetail.GetToDoDetail.ViewModel) {
        hideLoading()
        guard let toDo = viewModel.toDo, viewModel.error == nil else {
            showErrorDialog(title: "Error", message: viewModel.error?.localizedDescription)
            return
        }
        
        displayToDo = toDo
        descriptionTextField.text = toDo.description
        completedSwitchStackView.isHidden = false
        completedSwitch.isOn = toDo.completed ?? false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteToDoDetail))
    }
    
    func displayCreateToDo(viewModel: ToDoDetail.CreateToDo.ViewModel) {
        hideLoading()
        guard viewModel.error == nil else {
            showErrorDialog(title: "Error", message: viewModel.error?.localizedDescription)
            return
        }
        
        router?.routeToToDoListScreenAfterCreate()
    }
    
    func displayUpdateToDo(viewModel: ToDoDetail.UpdateToDo.ViewModel) {
        hideLoading()
        guard viewModel.error == nil else {
            showErrorDialog(title: "Error", message: viewModel.error?.localizedDescription)
            return
        }
        
        router?.routeToToDoListScreenAfterUpdate()
    }
    
    func displayDeleteToDo(viewModel: ToDoDetail.DeleteToDo.ViewModel) {
        hideLoading()
        guard viewModel.error == nil else {
            showErrorDialog(title: "Error", message: viewModel.error?.localizedDescription)
            return
        }
        
        router?.routeToToDoListScreenAfterDelete()
    }
}
