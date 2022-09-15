//
//  MainViewControllerTests.swift
//  ios-web-browserTests
//
//  Created by Mauricio Cesar on 15/09/22.
//

import XCTest
import ios_web_browser

class MainViewControllerTests: XCTestCase {
    func test_textFieldShouldReturn_sendsText() {
        let delegate = MainViewControllerDelegateSpy()
        let sut = MainViewController()
        sut.delegate = delegate
                
        let textField = UITextField()
        textField.text = "http://some-website.com"
        
        _ = sut.textFieldShouldReturn(textField)
        
        XCTAssertEqual(delegate.receivedMessages, [.sendText("http://some-website.com")])
    }
    
    // MARK: - Helpers
    
    private class MainViewControllerDelegateSpy: MainViewControllerDelegate {
        enum Message: Equatable {
            case sendText(_ text: String)
        }

        var receivedMessages = [Message]()
        
        func sendText(_ text: String) {
            receivedMessages.append(.sendText(text))
        }
    }
}
