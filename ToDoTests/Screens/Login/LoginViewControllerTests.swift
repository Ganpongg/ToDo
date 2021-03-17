@testable import ToDo
import XCTest

class LoginViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: LoginViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupLoginViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupLoginViewController() {
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController")
    }
    
    func loadView() {
        window.rootViewController = sut
        XCTAssertNotNil(sut.view)
    }
    
    // MARK: Test doubles
    
    class LoginBusinessLogicSpy: LoginBusinessLogic {
        var loginCalled = false
        var loginRequest: Login.UserLogin.Request?
        func login(request: Login.UserLogin.Request) {
            loginCalled = true
            loginRequest = request
        }
    }
    
    class LoginRoutingLogicSpy: NSObject & LoginDataPassing & LoginRoutingLogic {
        var dataStore: LoginDataStore?
        
        var routeToToDoListCalled = false
        func routeToToDoList() {
            routeToToDoListCalled = true
        }
    }
    
    // MARK: Tests
    
    func testTappedLoginButtonShouldCallLoginWithCorrectParametersWhenTouchOnLoginButton() {
        // Given
        loadView()
        
        let spy = LoginBusinessLogicSpy()
        sut.interactor = spy
        let email = "test@gmail.com"
        let password = "test1234"
        sut.emailTextField.text = email
        sut.passwordTextField.text = password
        
        // When
        sut.loginButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssert(spy.loginCalled)
        XCTAssertEqual(spy.loginRequest?.email, email)
        XCTAssertEqual(spy.loginRequest?.password, password)
    }
    
    func testTappedLoginButtonShouldNotCallLoginWhenEmailAndPasswordIsEmpty() {
        // Given
        loadView()
        
        let spy = LoginBusinessLogicSpy()
        sut.interactor = spy
        sut.emailTextField.text = ""
        sut.passwordTextField.text = ""
        
        // When
        sut.loginButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertFalse(spy.loginCalled)
        XCTAssertNil(spy.loginRequest)
    }
    
    func testTappedLoginButtonShouldNotCallLoginWhenEmailIsEmpty() {
        // Given
        loadView()
        
        let spy = LoginBusinessLogicSpy()
        sut.interactor = spy
        sut.emailTextField.text = ""
        sut.passwordTextField.text = "test1234"
        
        // When
        sut.loginButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertFalse(spy.loginCalled)
        XCTAssertNil(spy.loginRequest)
    }
    
    func testTappedLoginButtonShouldNotCallLoginWhenPasswordIsEmpty() {
        // Given
        loadView()
        
        let spy = LoginBusinessLogicSpy()
        sut.interactor = spy
        sut.emailTextField.text = "test@gmail.com"
        sut.passwordTextField.text = ""
        
        // When
        sut.loginButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertFalse(spy.loginCalled)
        XCTAssertNil(spy.loginRequest)
    }
    
    func testDisplayUserLoginShouldCallRouteToToDoListWhenLoginSuccessfully() {
        // Given
        let spy = LoginRoutingLogicSpy()
        sut.router = spy
        let viewModel = Login.UserLogin.ViewModel(error: nil)
        
        // When
        sut.displayUserLogin(viewModel: viewModel)
        
        // Then
        XCTAssert(spy.routeToToDoListCalled)
    }
    
    func testDisplayUserLoginShouldNotCallRouteToToDoListWhenLoginFailed() {
        // Given
        let spy = LoginRoutingLogicSpy()
        sut.router = spy
        let viewModel = Login.UserLogin.ViewModel(error: APIError.unknownError(error: nil))
        
        // When
        sut.displayUserLogin(viewModel: viewModel)
        
        // Then
        XCTAssertFalse(spy.routeToToDoListCalled)
    }
}
