@testable import ToDo
import XCTest

class ToDoDetailInteractorTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ToDoDetailInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupToDoDetailInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupToDoDetailInteractor() {
        sut = ToDoDetailInteractor()
    }
    
    // MARK: Test doubles
    
    class ToDoDetailPresentationLogicSpy: ToDoDetailPresentationLogic {
        var presentGetToDoDetailCalled = false
        var presentGetToDoDetailResponse: ToDoDetail.GetToDoDetail.Response?
        func presentGetToDoDetail(response: ToDoDetail.GetToDoDetail.Response) {
            presentGetToDoDetailCalled = true
            presentGetToDoDetailResponse = response
        }
        
        var presentCreateToDoCalled = false
        var presentCreateToDoResponse: ToDoDetail.CreateToDo.Response?
        func presentCreateToDo(response: ToDoDetail.CreateToDo.Response) {
            presentCreateToDoCalled = true
            presentCreateToDoResponse = response
        }
        
        var presentUpdateToDoCalled = false
        var presentUpdateToDoResponse: ToDoDetail.UpdateToDo.Response?
        func presentUpdateToDo(response: ToDoDetail.UpdateToDo.Response) {
            presentUpdateToDoCalled = true
            presentUpdateToDoResponse = response
        }
        
        var presentDeleteToDoCalled = false
        var presentDeleteToDoResponse: ToDoDetail.DeleteToDo.Response?
        func presentDeleteToDo(response: ToDoDetail.DeleteToDo.Response) {
            presentDeleteToDoCalled = true
            presentDeleteToDoResponse = response
        }
    }
    
    // MARK: Tests
    
    func testGetToDoDetailShouldCallPresentGetToDoDetailWithCorrectParametersWhenGetToDoDetailSuccessfully() {
        // Given
        let stub = TaskServiceStub()
        sut.taskService = stub
        let spy = ToDoDetailPresentationLogicSpy()
        sut.presenter = spy
        let request = ToDoDetail.GetToDoDetail.Request(id: "1")
        
        // When
        sut.getToDoDetail(request: request)
        
        // Then
        XCTAssert(spy.presentGetToDoDetailCalled)
        XCTAssertNotNil(spy.presentGetToDoDetailResponse?.toDo)
        XCTAssertNil(spy.presentGetToDoDetailResponse?.error)
    }
    
    func testGetToDoDetailShouldCallPresentGetToDoDetailWithCorrectParametersWhenGetToDoDetailFailed() {
        // Given
        let stub = TaskServiceStub()
        sut.taskService = stub
        let spy = ToDoDetailPresentationLogicSpy()
        sut.presenter = spy
        let request = ToDoDetail.GetToDoDetail.Request(id: "0")
        
        // When
        sut.getToDoDetail(request: request)
        
        // Then
        XCTAssert(spy.presentGetToDoDetailCalled)
        XCTAssertNil(spy.presentGetToDoDetailResponse?.toDo)
        XCTAssertNotNil(spy.presentGetToDoDetailResponse?.error)
    }
    
    func testCreateToDoShouldCallPresentCreateToDoWithCorrectParametersWhenCreateToDoSuccessfully() {
        // Given
        let stub = TaskServiceStub()
        sut.taskService = stub
        let spy = ToDoDetailPresentationLogicSpy()
        sut.presenter = spy
        let request = ToDoDetail.CreateToDo.Request(description: "description")
        
        // When
        sut.createToDo(request: request)
        
        // Then
        XCTAssert(spy.presentCreateToDoCalled)
        XCTAssertNil(spy.presentCreateToDoResponse?.error)
    }
    
    func testCreateToDoShouldCallPresentCreateToDoWithCorrectParametersWhenCreateToDoFailed() {
        // Given
        let stub = TaskServiceStub()
        sut.taskService = stub
        let spy = ToDoDetailPresentationLogicSpy()
        sut.presenter = spy
        let request = ToDoDetail.CreateToDo.Request(description: "")
        
        // When
        sut.createToDo(request: request)
        
        // Then
        XCTAssert(spy.presentCreateToDoCalled)
        XCTAssertNotNil(spy.presentCreateToDoResponse?.error)
    }
    
    func testUpdateToDoShouldCallPresentUpdateToDoWithCorrectParametersWhenUpdateToDoSuccessfully() {
        // Given
        let stub = TaskServiceStub()
        sut.taskService = stub
        let spy = ToDoDetailPresentationLogicSpy()
        sut.presenter = spy
        let request = ToDoDetail.UpdateToDo.Request(id: "1", description: "description", completed: true)
        
        // When
        sut.updateToDo(request: request)
        
        // Then
        XCTAssert(spy.presentUpdateToDoCalled)
        XCTAssertNil(spy.presentUpdateToDoResponse?.error)
    }
    
    func testUpdateToDoShouldCallPresentUpdateToDoWithCorrectParametersWhenUpdateToDoFailed() {
        // Given
        let stub = TaskServiceStub()
        sut.taskService = stub
        let spy = ToDoDetailPresentationLogicSpy()
        sut.presenter = spy
        let request = ToDoDetail.UpdateToDo.Request(id: "0", description: "", completed: false)
        
        // When
        sut.updateToDo(request: request)
        
        // Then
        XCTAssert(spy.presentUpdateToDoCalled)
        XCTAssertNotNil(spy.presentUpdateToDoResponse?.error)
    }
    
    func testDeleteToDoShouldCallPresentDeleteToDoWithCorrectParametersWhenDeleteToDoSuccessfully() {
        // Given
        let stub = TaskServiceStub()
        sut.taskService = stub
        let spy = ToDoDetailPresentationLogicSpy()
        sut.presenter = spy
        let request = ToDoDetail.DeleteToDo.Request(id: "1")
        
        // When
        sut.deleteToDo(request: request)
        
        // Then
        XCTAssert(spy.presentDeleteToDoCalled)
        XCTAssertNil(spy.presentDeleteToDoResponse?.error)
    }
    
    func testDeleteToDoShouldCallPresentDeleteToDoWithCorrectParametersWhenDeleteToDoFailed() {
        // Given
        let stub = TaskServiceStub()
        sut.taskService = stub
        let spy = ToDoDetailPresentationLogicSpy()
        sut.presenter = spy
        let request = ToDoDetail.DeleteToDo.Request(id: "0")
        
        // When
        sut.deleteToDo(request: request)
        
        // Then
        XCTAssert(spy.presentDeleteToDoCalled)
        XCTAssertNotNil(spy.presentDeleteToDoResponse?.error)
    }
}
