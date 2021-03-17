@testable import ToDo
import XCTest

class ToDoDetailPresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ToDoDetailPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupToDoDetailPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupToDoDetailPresenter() {
        sut = ToDoDetailPresenter()
    }
    
    // MARK: Test doubles
    
    class ToDoDetailDisplayLogicSpy: ToDoDetailDisplayLogic {
        var displayGetToDoDetailCalled = false
        var displayGetToDoDetailViewModel: ToDoDetail.GetToDoDetail.ViewModel?
        func displayGetToDoDetail(viewModel: ToDoDetail.GetToDoDetail.ViewModel) {
            displayGetToDoDetailCalled = true
            displayGetToDoDetailViewModel = viewModel
        }
        
        var displayCreateToDoCalled = false
        var displayCreateToDoViewModel: ToDoDetail.CreateToDo.ViewModel?
        func displayCreateToDo(viewModel: ToDoDetail.CreateToDo.ViewModel) {
            displayCreateToDoCalled = true
            displayCreateToDoViewModel = viewModel
        }
        
        var displayUpdateToDoCalled = false
        var displayUpdateToDoViewModel: ToDoDetail.UpdateToDo.ViewModel?
        func displayUpdateToDo(viewModel: ToDoDetail.UpdateToDo.ViewModel) {
            displayUpdateToDoCalled = true
            displayUpdateToDoViewModel = viewModel
        }
        
        var displayDeleteToDoCalled = false
        var displayDeleteToDoViewModel: ToDoDetail.DeleteToDo.ViewModel?
        func displayDeleteToDo(viewModel: ToDoDetail.DeleteToDo.ViewModel) {
            displayDeleteToDoCalled = true
            displayDeleteToDoViewModel = viewModel
        }
    }
    
    // MARK: Tests
    
    func testPresentGetToDoDetailShouldCallDisplayGetToDoDetailWithCorrectParametersWhenNotHasError() {
        // Given
        let spy = ToDoDetailDisplayLogicSpy()
        sut.viewController = spy
        let response = ToDoDetail.GetToDoDetail.Response(toDo: ToDoMocks.ToDoMock, error: nil)
        
        // When
        sut.presentGetToDoDetail(response: response)
        
        // Then
        XCTAssert(spy.displayGetToDoDetailCalled)
        XCTAssertNotNil(spy.displayGetToDoDetailViewModel?.toDo)
        XCTAssertNil(spy.displayGetToDoDetailViewModel?.error)
    }
    
    func testPresentGetToDoDetailShouldCallDisplayGetToDoDetailWithCorrectParametersWhenHasError() {
        // Given
        let spy = ToDoDetailDisplayLogicSpy()
        sut.viewController = spy
        let response = ToDoDetail.GetToDoDetail.Response(toDo: nil, error: APIError.unknownError(error: nil))
        
        // When
        sut.presentGetToDoDetail(response: response)
        
        // Then
        XCTAssert(spy.displayGetToDoDetailCalled)
        XCTAssertNil(spy.displayGetToDoDetailViewModel?.toDo)
        XCTAssertNotNil(spy.displayGetToDoDetailViewModel?.error)
    }
    
    func testPresentCreateToDoShouldCallDisplayCreateToDoWithCorrectParametersWhenNotHasError() {
        // Given
        let spy = ToDoDetailDisplayLogicSpy()
        sut.viewController = spy
        let response = ToDoDetail.CreateToDo.Response(error: nil)
        
        // When
        sut.presentCreateToDo(response: response)
        
        // Then
        XCTAssert(spy.displayCreateToDoCalled)
        XCTAssertNil(spy.displayCreateToDoViewModel?.error)
    }
    
    func testPresentCreateToDoShouldCallDisplayCreateToDoWithCorrectParametersWhenHasError() {
        // Given
        let spy = ToDoDetailDisplayLogicSpy()
        sut.viewController = spy
        let response = ToDoDetail.CreateToDo.Response(error: APIError.unknownError(error: nil))
        
        // When
        sut.presentCreateToDo(response: response)
        
        // Then
        XCTAssert(spy.displayCreateToDoCalled)
        XCTAssertNotNil(spy.displayCreateToDoViewModel?.error)
    }
    
    func testPresentUpdateToDoShouldCallDisplayUpdateToDoWithCorrectParametersWhenNotHasError() {
        // Given
        let spy = ToDoDetailDisplayLogicSpy()
        sut.viewController = spy
        let response = ToDoDetail.UpdateToDo.Response(error: nil)
        
        // When
        sut.presentUpdateToDo(response: response)
        
        // Then
        XCTAssert(spy.displayUpdateToDoCalled)
        XCTAssertNil(spy.displayUpdateToDoViewModel?.error)
    }
    
    func testPresentUpdateToDoShouldCallDisplayUpdateToDoWithCorrectParametersWhenHasError() {
        // Given
        let spy = ToDoDetailDisplayLogicSpy()
        sut.viewController = spy
        let response = ToDoDetail.UpdateToDo.Response(error: APIError.unknownError(error: nil))
        
        // When
        sut.presentUpdateToDo(response: response)
        
        // Then
        XCTAssert(spy.displayUpdateToDoCalled)
        XCTAssertNotNil(spy.displayUpdateToDoViewModel?.error)
    }
    
    func testPresentDeleteToDoShouldCallDisplayDeleteToDoWithCorrectParametersWhenNotHasError() {
        // Given
        let spy = ToDoDetailDisplayLogicSpy()
        sut.viewController = spy
        let response = ToDoDetail.DeleteToDo.Response(error: nil)
        
        // When
        sut.presentDeleteToDo(response: response)
        
        // Then
        XCTAssert(spy.displayDeleteToDoCalled)
        XCTAssertNil(spy.displayDeleteToDoViewModel?.error)
    }
    
    func testPresentDeleteToDoShouldCallDisplayDeleteToDoWithCorrectParametersWhenHasError() {
        // Given
        let spy = ToDoDetailDisplayLogicSpy()
        sut.viewController = spy
        let response = ToDoDetail.DeleteToDo.Response(error: APIError.unknownError(error: nil))
        
        // When
        sut.presentDeleteToDo(response: response)
        
        // Then
        XCTAssert(spy.displayDeleteToDoCalled)
        XCTAssertNotNil(spy.displayDeleteToDoViewModel?.error)
    }
}
