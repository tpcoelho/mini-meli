//
//  EmptyStateView.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 27/07/25.
//

import UIKit

class EmptyStateView: UIView {

    // MARK: - Subviews

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass.circle")
        imageView.tintColor = .systemGray3
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Nenhum resultado encontrado"
        label.font = .systemFont(ofSize: Space.s16, weight: .medium)
        label.textColor = Colors.Feedback.neutral
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, messageLabel])
        stack.axis = .vertical
        stack.spacing = Space.s16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {
        backgroundColor = .clear
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.s32),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.s32),

            imageView.heightAnchor.constraint(equalToConstant: Space.s80),
            imageView.widthAnchor.constraint(equalToConstant: Space.s80)
        ])
    }
}
