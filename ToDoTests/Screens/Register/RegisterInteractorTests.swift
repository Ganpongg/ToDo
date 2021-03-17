@testable import ToDo
import XCTest

class RegisterInteractorTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: RegisterInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupRegisterInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupRegisterInteractor() {
        sut = RegisterInteractor()
    }
    
    // MARK: Test doubles
    
    class RegisterPresentationLogicSpy: RegisterPresentationLogic {
        var presentUserRegisterCalled = false
        var presentUserRegisterResponse: Register.UserRegister.Response?
        func presentUserRegister(response: Register.UserRegister.Response) {
            presentUserRegisterCalled = true
            presentUserRegisterResponse = response
        }
    }
    
    // MARK: Tests
    
    func testRegisterShouldCallPresentUserRegisterAndNotHasErrorWhenRegisterSuccessfully() {
        // Given
        let stub = UserServiceStub()
        sut.userService = stub
        let spy = RegisterPresentationLogicSpy()
        sut.presenter = spy
        let request = Register.UserRegister.Request(name: "test", age: 26, email: "test@gmail.com", password: "test1234")
        
        // When
        sut.register(request: request)
        
        // Then
        XCTAssert(spy.presentUserRegisterCalled)
        XCTAssertNil(spy.presentUserRegisterResponse?.error)
    }
    
    func testRegisterShouldCallPresentUserRegisterAndHaveErrorWhenRegisterFailed() {
        // Given
        let stub = UserServiceStub()
        sut.userService = stub
        let spy = RegisterPresentationLogicSpy()
        sut.presenter = spy
        let request = Register.UserRegister.Request(name: "", age: 26, email: "", password: "")
        
        // When
        sut.register(request: request)
        
        // Then
        XCTAssert(spy.presentUserRegisterCalled)
        XCTAssertNotNil(spy.presentUserRegisterResponse?.error)
    }
}
