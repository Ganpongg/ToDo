@testable import ToDo
import XCTest

class ToDoListInteractorTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ToDoListInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupToDoListInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupToDoListInteractor() {
        sut = ToDoListInteractor()
    }
    
    // MARK: Test doubles
    
    class ToDoListPresentationLogicSpy: ToDoListPresentationLogic {
        var presentLogOutCalled = false
        var presentLogOutResponse: ToDoList.LogOut.Response?
        func presentLogOut(response: ToDoList.LogOut.Response) {
            presentLogOutCalled = true
            presentLogOutResponse = response
        }
        
        var presentToDoListCalled = false
        var presentToDoListResponse: ToDoList.GetToDoList.Response?
        func presentToDoList(response: ToDoList.GetToDoList.Response) {
            presentToDoListCalled = true
            presentToDoListResponse = response
        }
    }
    
    // MARK: Tests
    
    func testLogoutShouldCallPresentLogOut() {
        // Given
        let userServiceStub = UserServiceStub()
        sut.userService = userServiceStub
        let spy = ToDoListPresentationLogicSpy()
        sut.presenter = spy
        let request = ToDoList.LogOut.Request()
        
        // When
        sut.logout(request: request)
        
        // Then
        XCTAssert(spy.presentLogOutCalled)
    }
    
    func testGetToDoListShouldCallPresentToDoListAndNotHasErrorWhenGetToDoListSuccessfully() {
        // Given
        let stub = TaskServiceStub()
        sut.taskService = stub
        let spy = ToDoListPresentationLogicSpy()
        sut.presenter = spy
        let request = ToDoList.GetToDoList.Request()
        
        // When
        sut.getToDoList(request: request)
        
        // Then
        XCTAssert(spy.presentToDoListCalled)
        XCTAssertNil(spy.presentToDoListResponse?.error)
    }
    
    func testGetToDoListShouldCallPresentToDoListAndHasErrorWhenGetToDoListFailed() {
        // Given
        let stub = TaskServiceStub()
        sut.taskService = stub
        stub.getToDoListSuccessStub = false
        let spy = ToDoListPresentationLogicSpy()
        sut.presenter = spy
        let request = ToDoList.GetToDoList.Request()
        
        // When
        sut.getToDoList(request: request)
        
        // Then
        XCTAssert(spy.presentToDoListCalled)
        XCTAssertNotNil(spy.presentToDoListResponse?.error)
    }
}
