//
//  PreLoginView.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 24/07/25.
//

import UIKit

protocol PreLoginViewDelegate: AnyObject {
    func startWithAPI()
    func startWithMock()
}

class PreLoginView: UIView {
    private struct Layout {
        static let buttonWidth: CGFloat = 220
    }
    
    let apiButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Start with API"
        config.image = UIImage(systemName: "lock.fill")
        config.imagePadding = 8
        config.baseBackgroundColor = Colors.Action.primary
        config.baseForegroundColor = Colors.Contrast.white
        config.cornerStyle = .medium
        
        let button = UIButton(configuration: config, primaryAction: nil)
        return button
    }()
    
    let mockButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Start with Mock"
        config.image = UIImage(systemName: "doc.text.fill")
        config.imagePadding = 8
        config.baseBackgroundColor = Colors.Action.secondary
        config.baseForegroundColor = Colors.Contrast.black
        config.cornerStyle = .medium
        
        let button = UIButton(configuration: config, primaryAction: nil)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Space.s24
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private weak var delegate: PreLoginViewDelegate?
    
    init(delegate: PreLoginViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Private methods
    @objc
    private func apiButtonTapped() {
        delegate?.startWithAPI()
    }
    
    @objc
    private func mockButtonTapped() {
        delegate?.startWithMock()
    }
}

extension PreLoginView: ViewCodeConfiguration {
    func buildViewHierarchy() {
        stackView.addArrangedSubview(apiButton)
        stackView.addArrangedSubview(mockButton)
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            apiButton.widthAnchor.constraint(equalToConstant: Layout.buttonWidth),
            mockButton.widthAnchor.constraint(equalToConstant: Layout.buttonWidth),
            apiButton.heightAnchor.constraint(equalToConstant: Space.s40),
            mockButton.heightAnchor.constraint(equalToConstant: Space.s40)
        ])
    }
    
    func configureViews() {
        backgroundColor = Colors.Background.base
        apiButton.addTarget(self, action: #selector(apiButtonTapped), for: .touchUpInside)
        mockButton.addTarget(self, action: #selector(mockButtonTapped), for: .touchUpInside)
    }
}
