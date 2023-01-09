import UIKit
import WebKit

public protocol MainViewProtocol {
    func sendText(_ text: String)
}

public final class MainView: UIView {
    public var delegate: MainViewProtocol?

    internal let searchBar = SearchBarView()

    internal let webView: WKWebView = {
        let webView = WKWebView()
        webView.isHidden = true
        return webView
    }()

    internal let bottomNavigationView = BottomNavigationView()

    convenience init() {
        self.init(frame: .zero)        
        setupView()
    }

    private func setupView() {
        searchBar.searchBar.delegate = self

        addSubview(searchBar)
        addSubview(webView)
        addSubview(bottomNavigationView)

        backgroundColor = .systemGray4
        setupConstraints()
    }

    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        bottomNavigationView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),

            webView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),

            bottomNavigationView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 10),
            bottomNavigationView.heightAnchor.constraint(equalToConstant: 70),
            bottomNavigationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomNavigationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomNavigationView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension MainView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        delegate?.sendText(text)
        return true
    }
}
