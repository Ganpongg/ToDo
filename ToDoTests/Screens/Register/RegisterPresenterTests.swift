@testable import ToDo
import XCTest

class RegisterPresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: RegisterPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupRegisterPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupRegisterPresenter() {
        sut = RegisterPresenter()
    }
    
    // MARK: Test doubles
    
    class RegisterDisplayLogicSpy: RegisterDisplayLogic {
        var displayUserRegisterCalled = false
        var displayUserRegisterViewModel: Register.UserRegister.ViewModel?
        func displayUserRegister(viewModel: Register.UserRegister.ViewModel) {
            displayUserRegisterCalled = true
            displayUserRegisterViewModel = viewModel
        }
    }
    
    // MARK: Tests
    
    func testPresentUserRegisterShouldCallDisplayUserRegisterWhenNotHasError() {
        // Given
        let spy = RegisterDisplayLogicSpy()
        sut.viewController = spy
        let response = Register.UserRegister.Response(error: nil)
        
        // When
        sut.presentUserRegister(response: response)
        
        // Then
        XCTAssert(spy.displayUserRegisterCalled)
        XCTAssertNil(spy.displayUserRegisterViewModel?.error)
    }
    
    func testPresentUserRegisterShouldCallDisplayUserRegisterWhenHasError() {
        // Given
        let spy = RegisterDisplayLogicSpy()
        sut.viewController = spy
        let response = Register.UserRegister.Response(error: APIError.unknownError(error: nil))
        
        // When
        sut.presentUserRegister(response: response)
        
        // Then
        XCTAssert(spy.displayUserRegisterCalled)
        XCTAssertNotNil(spy.displayUserRegisterViewModel?.error)
    }
}
