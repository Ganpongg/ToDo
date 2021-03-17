@testable import ToDo
import XCTest

class ToDoListViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ToDoListViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupToDoListViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupToDoListViewController() {
        sut = UIStoryboard(name: "ToDo", bundle: nil).instantiateViewController(identifier: "ToDoListViewController")
    }
    
    func loadView() {
        window.rootViewController = sut
        XCTAssertNotNil(sut.view)
    }
    
    // MARK: Test doubles
    
    class ToDoListBusinessLogicSpy: ToDoListBusinessLogic {
        var logoutCalled = false
        var logoutRequest: ToDoList.LogOut.Request?
        func logout(request: ToDoList.LogOut.Request) {
            logoutCalled = true
            logoutRequest = request
        }
        
        var getToDoListCalled = false
        var getToDoListRequest: ToDoList.GetToDoList.Request?
        func getToDoList(request: ToDoList.GetToDoList.Request) {
            getToDoListCalled = true
            getToDoListRequest = request
        }
        
        var selectToDoCalled = false
        var selectToDoRequest: ToDoList.SelectToDo.Request?
        func selectToDo(request: ToDoList.SelectToDo.Request) {
            selectToDoCalled = true
            selectToDoRequest = request
        }
        
        var refreshToDoListCalled = false
        var refreshToDoListRequest: ToDoList.RefreshToDoList.Request?
        func refreshToDoList(request: ToDoList.RefreshToDoList.Request) {
            refreshToDoListCalled = true
            refreshToDoListRequest = request
        }
    }
    
    class ToDoListRoutingLogicSpy: NSObject & ToDoListDataPassing & ToDoListRoutingLogic {
        var dataStore: ToDoListDataStore?
        
        var routeToLoginScreenCalled = false
        func routeToLoginScreen() {
            routeToLoginScreenCalled = true
        }
        
        var routeToToDoDetailScreenCalled = false
        func routeToToDoDetailScreen() {
            routeToToDoDetailScreenCalled = true
        }
    }
    
    // MARK: Tests
    
    func testLoadViewShouldCallGetToDoList() {
        // Given
        let spy = ToDoListBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssert(spy.getToDoListCalled)
    }
    
    func testViewWillAppearShouldCallRefreshToDoList() {
        // Given
        loadView()
        let spy = ToDoListBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        sut.viewWillAppear(true)
        
        // Then
        XCTAssert(spy.refreshToDoListCalled)
    }
    
    func testDisplayLogoutShouldCallRouteToLoginScreen() {
        // Given
        loadView()
        let spy = ToDoListRoutingLogicSpy()
        sut.router = spy
        
        // When
        sut.displayLogOut(viewModel: ToDoList.LogOut.ViewModel())
        
        // Then
        XCTAssert(spy.routeToLoginScreenCalled)
    }
    
    func testDisplayToDoListShouldDisplayCorrectlyWhenHasToDosAndNotHasError() {
        // Given
        loadView()
        let spy = ToDoListBusinessLogicSpy()
        sut.interactor = spy
        let viewModel = ToDoList.GetToDoList.ViewModel(toDos: [ToDoMocks.ToDoMock], error: nil)
        
        // When
        sut.displayToDoList(viewModel: viewModel)
        
        // Then
        XCTAssertFalse(sut.displayToDoList.isEmpty)
        XCTAssert(sut.noContentView.isHidden)
    }
    
    func testDisplayToDoListShouldDisplayCorrectlyWhenHasNotToDosAndError() {
        // Given
        loadView()
        let spy = ToDoListBusinessLogicSpy()
        sut.interactor = spy
        let viewModel = ToDoList.GetToDoList.ViewModel(toDos: [], error: nil)
        
        // When
        sut.displayToDoList(viewModel: viewModel)
        
        // Then
        XCTAssert(sut.displayToDoList.isEmpty)
        XCTAssertFalse(sut.noContentView.isHidden)
    }
    
    func testDisplayToDoListShouldDisplayCorrectlyWhenHasError() {
        // Given
        loadView()
        let spy = ToDoListBusinessLogicSpy()
        sut.interactor = spy
        let viewModel = ToDoList.GetToDoList.ViewModel(toDos: [], error: APIError.unknownError(error: nil))
        
        // When
        sut.displayToDoList(viewModel: viewModel)
        
        // Then
        XCTAssert(sut.displayToDoList.isEmpty)
        XCTAssert(sut.noContentView.isHidden)
    }
}
