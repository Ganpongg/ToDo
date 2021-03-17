import Foundation
import UIKit

protocol ToDoListDisplayLogic: class {
    func displayLogOut(viewModel: ToDoList.LogOut.ViewModel)
    func displayToDoList(viewModel: ToDoList.GetToDoList.ViewModel)
}

class ToDoListViewController: UIViewController {
    var interactor: ToDoListBusinessLogic?
    var router: (NSObjectProtocol & ToDoListRoutingLogic & ToDoListDataPassing)?

    var displayToDoList: [ToDo] = []
    
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
        let interactor = ToDoListInteractor()
        let presenter = ToDoListPresenter()
        let router = ToDoListRouter()
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
        getToDoList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.refreshToDoList(request: ToDoList.RefreshToDoList.Request())
    }
    
    // MARK: Do something
    
    @IBOutlet weak var tableView: UITableView!
    var noContentView: UIView!
    var refreshControl: UIRefreshControl!
    
    private func setLayout() {
        navigationItem.title = "To Do List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDo))
        
        noContentView = createNoContentView()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getToDoList), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func logout() {
        let request = ToDoList.LogOut.Request()
        interactor?.logout(request: request)
    }
    
    @objc private func addToDo() {
        router?.routeToToDoDetailScreen()
    }
    
    @objc private func getToDoList() {
        showLoading()
        let request = ToDoList.GetToDoList.Request()
        interactor?.getToDoList(request: request)
    }
}

extension ToDoListViewController: ToDoListDisplayLogic {
    func displayLogOut(viewModel: ToDoList.LogOut.ViewModel) {
        router?.routeToLoginScreen()
    }
    
    func displayToDoList(viewModel: ToDoList.GetToDoList.ViewModel) {
        hideLoading()
        refreshControl.endRefreshing()
        
        guard viewModel.error == nil else {
            showErrorDialog(title: "Error", message: viewModel.error?.localizedDescription)
            return
        }
        
        displayToDoList = viewModel.toDos
        tableView.reloadData()
        
        if displayToDoList.isEmpty {
            showNoContentView(noContentView)
        } else {
            hideNoContentView(noContentView)
        }
    }
}

extension ToDoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayToDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCell", for: indexPath) as! ToDoListTableViewCell
        cell.display(toDo: displayToDoList[indexPath.row])
        return cell
    }
}

extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = displayToDoList[indexPath.row]
        let request = ToDoList.SelectToDo.Request(toDo: toDo)
        interactor?.selectToDo(request: request)
        router?.routeToToDoDetailScreen()
    }
}
