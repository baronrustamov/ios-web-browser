import UIKit

final class MainComposer {
    static func makeScreen() -> UIViewController {
        let mainView = MainView()
        let mainViewController = UIViewController()
        let mainViewDelegate = WebViewProxy(webView: mainView.webView)

        mainViewController.view = mainView
        mainView.delegate = mainViewDelegate

        return mainViewController
    }
}
