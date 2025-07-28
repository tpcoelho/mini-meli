//
//  ErrorView.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 27/07/25.
//

import UIKit

final class ErrorView: UIView {
    // MARK: - UI
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.Feedback.alert
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s24, weight: .bold)
        label.textColor = Colors.Text.heading02
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s16, weight: .regular)
        label.textColor = Colors.Text.text
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = Space.s12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Initializers
    init(image: UIImage?, title: String, description: String) {
        super.init(frame: .zero)
        setupView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupError(image: String?, title: String, description: String) {
        if let imageString = image {
            imageView.image = UIImage(systemName: imageString)
        }
        titleLabel.text = title
        descriptionLabel.text = description
    }
}

extension ErrorView: ViewCodeConfiguration {
    func buildViewHierarchy() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Space.s40),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.s24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.s24),

            imageView.heightAnchor.constraint(equalToConstant: Space.s80),
            imageView.widthAnchor.constraint(equalToConstant: Space.s80)
        ])
    }
    
    func configureViews() {
        backgroundColor = Colors.Contrast.white
    }
}
