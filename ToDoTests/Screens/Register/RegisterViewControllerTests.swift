@testable import ToDo
import XCTest

class RegisterViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: RegisterViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupRegisterViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupRegisterViewController() {
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegisterViewController")
    }
    
    func loadView() {
        window.rootViewController = sut
        XCTAssertNotNil(sut.view)
    }
    
    // MARK: Test doubles
    
    class RegisterBusinessLogicSpy: RegisterBusinessLogic {
        var registerCalled = false
        var registerRequest: Register.UserRegister.Request?
        func register(request: Register.UserRegister.Request) {
            registerCalled = true
            registerRequest = request
        }
    }
    
    class RegisterRoutingLogicSpy: NSObject & RegisterDataPassing & RegisterRoutingLogic {
        var dataStore: RegisterDataStore?
        
        var routeToPreviousScreenCalled = false
        func routeToPreviousScreen() {
            routeToPreviousScreenCalled = true
        }
    }
    
    // MARK: Tests
    
    func testTappedSubmitButtonShouldCallRegisterWithCorrectParameters() {
        // Given
        loadView()
        let spy = RegisterBusinessLogicSpy()
        sut.interactor = spy
        let name = "test"
        let age = 26
        let email = "test@gmail.com"
        let password = "test1234"
        sut.nameTextField.text = name
        sut.ageTextField.text = "\(age)"
        sut.emailTextField.text = email
        sut.passwordTextField.text = password
        
        // When
        sut.submitButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssert(spy.registerCalled)
        XCTAssertEqual(spy.registerRequest?.name, name)
        XCTAssertEqual(spy.registerRequest?.age, age)
        XCTAssertEqual(spy.registerRequest?.email, email)
        XCTAssertEqual(spy.registerRequest?.password, password)
    }
    
    func testTappedSubmitButtonShouldNotCallRegisterWhenFormIsEmpty() {
        // Given
        loadView()
        let spy = RegisterBusinessLogicSpy()
        sut.interactor = spy
        sut.nameTextField.text = ""
        sut.ageTextField.text = ""
        sut.emailTextField.text = ""
        sut.passwordTextField.text = ""
        
        // When
        sut.submitButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertFalse(spy.registerCalled)
        XCTAssertNil(spy.registerRequest)
    }
    
    func testTappedSubmitButtonShouldNotCallRegisterWhenNameIsEmpty() {
        // Given
        loadView()
        let spy = RegisterBusinessLogicSpy()
        sut.interactor = spy
        sut.nameTextField.text = ""
        sut.ageTextField.text = "\(26)"
        sut.emailTextField.text = "test@gmail.com"
        sut.passwordTextField.text = "test1234"
        
        // When
        sut.submitButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertFalse(spy.registerCalled)
        XCTAssertNil(spy.registerRequest)
    }
    
    func testTappedSubmitButtonShouldNotCallRegisterWhenAgeIsEmpty() {
        // Given
        loadView()
        let spy = RegisterBusinessLogicSpy()
        sut.interactor = spy
        sut.nameTextField.text = "test"
        sut.ageTextField.text = ""
        sut.emailTextField.text = "test@gmail.com"
        sut.passwordTextField.text = "test1234"
        
        // When
        sut.submitButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertFalse(spy.registerCalled)
        XCTAssertNil(spy.registerRequest)
    }
    
    func testTappedSubmitButtonShouldNotCallRegisterWhenEmailIsEmpty() {
        // Given
        loadView()
        let spy = RegisterBusinessLogicSpy()
        sut.interactor = spy
        sut.nameTextField.text = "test"
        sut.ageTextField.text = "\(26)"
        sut.emailTextField.text = ""
        sut.passwordTextField.text = "test1234"
        
        // When
        sut.submitButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertFalse(spy.registerCalled)
        XCTAssertNil(spy.registerRequest)
    }
    
    func testTappedSubmitButtonShouldNotCallRegisterWhenPasswordIsEmpty() {
        // Given
        loadView()
        let spy = RegisterBusinessLogicSpy()
        sut.interactor = spy
        sut.nameTextField.text = "test"
        sut.ageTextField.text = "\(26)"
        sut.emailTextField.text = "test@gmail.com"
        sut.passwordTextField.text = ""
        
        // When
        sut.submitButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertFalse(spy.registerCalled)
        XCTAssertNil(spy.registerRequest)
    }
    
    func testTappedClearButtonShouldClearForm() {
        // Given
        loadView()
        let spy = RegisterBusinessLogicSpy()
        sut.interactor = spy
        sut.nameTextField.text = "test"
        sut.ageTextField.text = "\(26)"
        sut.emailTextField.text = "test@gmail.com"
        sut.passwordTextField.text = "test1234"
        
        // When
        sut.clearButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssert(sut.nameTextField.text!.isEmpty)
        XCTAssert(sut.ageTextField.text!.isEmpty)
        XCTAssert(sut.emailTextField.text!.isEmpty)
        XCTAssert(sut.nameTextField.text!.isEmpty)
    }
    
    func testDisplayUserRegisterShouldNotCallRouteToPreviousScreenWhenRegisterFailed() {
        // Given
        loadView()
        let spy = RegisterRoutingLogicSpy()
        sut.router = spy
        let viewModel = Register.UserRegister.ViewModel(error: APIError.unknownError(error: nil))
        
        // When
        sut.displayUserRegister(viewModel: viewModel)
        
        // Then
        XCTAssertFalse(spy.routeToPreviousScreenCalled)
    }
}
