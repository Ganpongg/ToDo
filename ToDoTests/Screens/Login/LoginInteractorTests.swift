@testable import ToDo
import XCTest

class LoginInteractorTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: LoginInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupLoginInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupLoginInteractor() {
        sut = LoginInteractor()
    }
    
    // MARK: Test doubles
    
    class LoginPresentationLogicSpy: LoginPresentationLogic {
        var presentUserLoginCalled = false
        var userLoginResponse: Login.UserLogin.Response?
        func presentUserLogin(response: Login.UserLogin.Response) {
            presentUserLoginCalled = true
            userLoginResponse = response
        }
    }
    
    // MARK: Tests
    
    func testLoginShouldCallPresentUserLoginAndNotHasErrorWhenLoginSuccessfully() {
        // Given
        sut.userService = UserServiceStub()
        let spy = LoginPresentationLogicSpy()
        sut.presenter = spy
        let request = Login.UserLogin.Request(email: "test@gmail.com", password: "test1234")
        
        // When
        sut.login(request: request)
        
        // Then
        XCTAssert(spy.presentUserLoginCalled)
        XCTAssertNil(spy.userLoginResponse?.error)
    }
    
    func testLoginShouldCallPresentUserLoginAndHaveErrorWhenLoginFailed() {
        // Given
        sut.userService = UserServiceStub()
        let spy = LoginPresentationLogicSpy()
        sut.presenter = spy
        let request = Login.UserLogin.Request(email: "", password: "")
        
        // When
        sut.login(request: request)
        
        // Then
        XCTAssert(spy.presentUserLoginCalled)
        XCTAssertNotNil(spy.userLoginResponse?.error)
    }
}
