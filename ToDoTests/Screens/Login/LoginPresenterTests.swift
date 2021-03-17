@testable import ToDo
import XCTest

class LoginPresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: LoginPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupLoginPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupLoginPresenter() {
        sut = LoginPresenter()
    }
    
    // MARK: Test doubles
    
    class LoginDisplayLogicSpy: LoginDisplayLogic {
        var displayUserLoginCalled = false
        var displayLoginViewModel: Login.UserLogin.ViewModel?
        func displayUserLogin(viewModel: Login.UserLogin.ViewModel) {
            displayUserLoginCalled = true
            displayLoginViewModel = viewModel
        }
    }
    
    // MARK: Tests
    
    func testPresentUserLoginShouldCallDisplayUserLoginWhenNotHasError() {
        // Given
        let spy = LoginDisplayLogicSpy()
        sut.viewController = spy
        let response = Login.UserLogin.Response(error: nil)
        
        // When
        sut.presentUserLogin(response: response)
        
        // Then
        XCTAssert(spy.displayUserLoginCalled)
        XCTAssertNil(spy.displayLoginViewModel?.error)
    }
    
    func testPresentUserLoginShouldCallDisplayUserLoginWhenHasError() {
        // Given
        let spy = LoginDisplayLogicSpy()
        sut.viewController = spy
        let response = Login.UserLogin.Response(error: APIError.unknownError(error: nil))
        
        // When
        sut.presentUserLogin(response: response)
        
        // Then
        XCTAssert(spy.displayUserLoginCalled)
        XCTAssertNotNil(spy.displayLoginViewModel?.error)
    }
}
