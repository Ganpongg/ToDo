@testable import ToDo
import XCTest

class ToDoDetailViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ToDoDetailViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupToDoDetailViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupToDoDetailViewController() {
        sut = UIStoryboard(name: "ToDo", bundle: nil).instantiateViewController(identifier: "ToDoDetailViewController")
    }
    
    func loadView() {
        window.rootViewController = sut
        XCTAssertNotNil(sut.view)
    }
    
    // MARK: Test doubles
    
    class ToDoDetailBusinessLogicSpy: ToDoDetailBusinessLogic {
        var getToDoDetailCalled = false
        var getToDoDetailRequest: ToDoDetail.GetToDoDetail.Request?
        func getToDoDetail(request: ToDoDetail.GetToDoDetail.Request) {
            getToDoDetailCalled = true
            getToDoDetailRequest = request
        }
        
        var createToDoCalled = false
        var createToDoRequest: ToDoDetail.CreateToDo.Request?
        func createToDo(request: ToDoDetail.CreateToDo.Request) {
            createToDoCalled = true
            createToDoRequest = request
        }
        
        var updateToDoCalled = false
        var updateToDoRequest: ToDoDetail.UpdateToDo.Request?
        func updateToDo(request: ToDoDetail.UpdateToDo.Request) {
            updateToDoCalled = true
            updateToDoRequest = request
        }
        
        var deleteToDoCalled = false
        var deleteToDoRequest: ToDoDetail.DeleteToDo.Request?
        func deleteToDo(request: ToDoDetail.DeleteToDo.Request) {
            deleteToDoCalled = true
            deleteToDoRequest = request
        }
    }
    
    class ToDoDetailRoutingLogicSpy: NSObject & ToDoDetailDataPassing & ToDoDetailRoutingLogic {
        var dataStore: ToDoDetailDataStore?
        
        var routeToToDoListScreenAfterCreateCalled = false
        func routeToToDoListScreenAfterCreate() {
            routeToToDoListScreenAfterCreateCalled = true
        }
        
        var routeToToDoListScreenAfterUpdateCalled = false
        func routeToToDoListScreenAfterUpdate() {
            routeToToDoListScreenAfterUpdateCalled = true
        }
        
        var routeToToDoListScreenAfterDeleteCalled = false
        func routeToToDoListScreenAfterDelete() {
            routeToToDoListScreenAfterDeleteCalled = true
        }
        
        var routeToToDoListScreenCalled = false
        func routeToToDoListScreen() {
            routeToToDoListScreenCalled = true
        }
    }
    
    // MARK: Tests
    
    func testTappedSaveButtonShouldCallCreateToDoWhenNotHasDisplayToDo() {
        // Given
        loadView()
        let spy = ToDoDetailBusinessLogicSpy()
        sut.interactor = spy
        let description = "description"
        sut.descriptionTextField.text = description
        
        // When
        sut.saveButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssert(spy.createToDoCalled)
        XCTAssertEqual(spy.createToDoRequest?.description, description)
        XCTAssertFalse(spy.updateToDoCalled)
    }
    
    func testTappedSaveButtonShouldCallUpdateToDoWhenHasDisplayToDo() {
        // Given
        loadView()
        let spy = ToDoDetailBusinessLogicSpy()
        sut.interactor = spy
        sut.displayToDo = ToDo(id: "1", description: "description", completed: false)
        let description = "new description"
        let completed = true
        sut.descriptionTextField.text = description
        sut.completedSwitch.isOn = completed
        
        // When
        sut.saveButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertFalse(spy.createToDoCalled)
        XCTAssert(spy.updateToDoCalled)
        XCTAssertEqual(spy.updateToDoRequest?.description, description)
        XCTAssertEqual(spy.updateToDoRequest?.completed, completed)
    }
    
    func testDisplayGetToDoDetailShouldDisplayCorrectlyWhenNotHasError() {
        // Given
        loadView()
        let viewModel = ToDoDetail.GetToDoDetail.ViewModel(toDo: ToDoMocks.ToDoMock, error: nil)
        
        // When
        sut.displayGetToDoDetail(viewModel: viewModel)
        
        // Then
        XCTAssertNotNil(sut.displayToDo)
    }
    
    func testDisplayGetToDoDetailShouldDisplayCorrectlyWhenHasError() {
        // Given
        let viewModel = ToDoDetail.GetToDoDetail.ViewModel(toDo: nil, error: APIError.unknownError(error: nil))
        
        // When
        sut.displayGetToDoDetail(viewModel: viewModel)
        
        // Then
        XCTAssertNil(sut.displayToDo)
    }
    
    func testDisplayCreateToDoShouldCallRouteToToDoListScreenAfterCreateWhenNotHasError() {
        // Given
        let spy = ToDoDetailRoutingLogicSpy()
        sut.router = spy
        let viewModel = ToDoDetail.CreateToDo.ViewModel(error: nil)
        
        // When
        sut.displayCreateToDo(viewModel: viewModel)
        
        // Then
        XCTAssert(spy.routeToToDoListScreenAfterCreateCalled)
    }
    
    func testDisplayCreateToDoShouldNotCallRouteToToDoListScreenAfterCreateWhenHasError() {
        // Given
        let spy = ToDoDetailRoutingLogicSpy()
        sut.router = spy
        let viewModel = ToDoDetail.CreateToDo.ViewModel(error: APIError.unknownError(error: nil))
        
        // When
        sut.displayCreateToDo(viewModel: viewModel)
        
        // Then
        XCTAssertFalse(spy.routeToToDoListScreenAfterCreateCalled)
    }
    
    func testDisplayUpdateToDoShouldCallRouteToToDoListScreenAfterUpdateWhenNotHasError() {
        // Given
        let spy = ToDoDetailRoutingLogicSpy()
        sut.router = spy
        let viewModel = ToDoDetail.UpdateToDo.ViewModel(error: nil)
        
        // When
        sut.displayUpdateToDo(viewModel: viewModel)
        
        // Then
        XCTAssert(spy.routeToToDoListScreenAfterUpdateCalled)
    }
    
    func testDisplayUpdateToDoShouldNotCallRouteToToDoListScreenAfterUpdateWhenHasError() {
        // Given
        let spy = ToDoDetailRoutingLogicSpy()
        sut.router = spy
        let viewModel = ToDoDetail.UpdateToDo.ViewModel(error: APIError.unknownError(error: nil))
        
        // When
        sut.displayUpdateToDo(viewModel: viewModel)
        
        // Then
        XCTAssertFalse(spy.routeToToDoListScreenAfterUpdateCalled)
    }
    
    func testDisplayDeleteToDoShouldCallRouteToToDoListScreenAfterDeleteWhenNotHasError() {
        // Given
        let spy = ToDoDetailRoutingLogicSpy()
        sut.router = spy
        let viewModel = ToDoDetail.DeleteToDo.ViewModel(error: nil)
        
        // When
        sut.displayDeleteToDo(viewModel: viewModel)
        
        // Then
        XCTAssert(spy.routeToToDoListScreenAfterDeleteCalled)
    }
    
    func testDisplayDeleteToDoShouldNotCallRouteToToDoListScreenAfterDeleteWhenHasError() {
        // Given
        let spy = ToDoDetailRoutingLogicSpy()
        sut.router = spy
        let viewModel = ToDoDetail.DeleteToDo.ViewModel(error: APIError.unknownError(error: nil))
        
        // When
        sut.displayDeleteToDo(viewModel: viewModel)
        
        // Then
        XCTAssertFalse(spy.routeToToDoListScreenAfterDeleteCalled)
    }
}
