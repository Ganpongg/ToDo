@testable import ToDo
import XCTest

class ToDoListPresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ToDoListPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupToDoListPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupToDoListPresenter() {
        sut = ToDoListPresenter()
    }
    
    // MARK: Test doubles
    
    class ToDoListDisplayLogicSpy: ToDoListDisplayLogic {
        var displayLogOutCalled = false
        var displayLogOutViewModel: ToDoList.LogOut.ViewModel?
        func displayLogOut(viewModel: ToDoList.LogOut.ViewModel) {
            displayLogOutCalled = true
            displayLogOutViewModel = viewModel
        }
        
        var displayToDoListCalled = false
        var displayToDoListViewModel: ToDoList.GetToDoList.ViewModel?
        func displayToDoList(viewModel: ToDoList.GetToDoList.ViewModel) {
            displayToDoListCalled = true
            displayToDoListViewModel = viewModel
        }
    }
    
    // MARK: Tests
    
    func testPresentLogOutShouldCallDisplayLogOut() {
        // Given
        let spy = ToDoListDisplayLogicSpy()
        sut.viewController = spy
        let response = ToDoList.LogOut.Response()
        
        // When
        sut.presentLogOut(response: response)
        
        // Then
        XCTAssert(spy.displayLogOutCalled)
    }
    
    func testPresentToDoListShouldCallDisplayToDoListWithCorrectParametersWhenNotHasError() {
        // Given
        let spy = ToDoListDisplayLogicSpy()
        sut.viewController = spy
        let response = ToDoList.GetToDoList.Response(toDos: [], error: nil)
        
        // When
        sut.presentToDoList(response: response)
        
        // Then
        XCTAssert(spy.displayToDoListCalled)
        XCTAssertNil(spy.displayToDoListViewModel?.error)
    }
    
    func testPresentToDoListShouldCallDisplayToDoListWithCorrectParametersWhenHasError() {
        // Given
        let spy = ToDoListDisplayLogicSpy()
        sut.viewController = spy
        let response = ToDoList.GetToDoList.Response(toDos: [], error: APIError.unknownError(error: nil))
        
        // When
        sut.presentToDoList(response: response)
        
        // Then
        XCTAssert(spy.displayToDoListCalled)
        XCTAssertNotNil(spy.displayToDoListViewModel?.error)
    }
}
