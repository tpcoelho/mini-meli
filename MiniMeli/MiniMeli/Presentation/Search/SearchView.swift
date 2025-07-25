//
//  SearchView.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 24/07/25.
//


import UIKit

class SearchView: UIView {
    private struct Text {
        static let placeHolder: String = "Encontre produtos no MiniMeli"
    }
    private struct Layout {
        static let buttonWidth: CGFloat = 220
        static let iconSize: CGFloat = Space.s24
    }
    
    private let searchIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = Colors.Text.text
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = Colors.Text.text
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let searchBar: UITextField = {
        let textField = UITextField()
        textField.placeholder = Text.placeHolder
        textField.backgroundColor = Colors.Background.variant01
        textField.layer.cornerRadius = Space.s8
        textField.clearButtonMode = .never
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Private methods
    @objc private func clearTapped() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        updateSearchBarState(isEditing: false)
    }
    
    private func updateSearchBarState(isEditing: Bool) {
        searchIcon.isHidden = isEditing
        clearButton.isHidden = !isEditing
        searchBar.placeholder = isEditing ? "" : Text.placeHolder
    }
}

extension SearchView: ViewCodeConfiguration {
    func buildViewHierarchy() {
        addSubview(searchBar)
        searchBar.leftView = searchIcon
        searchBar.rightView = clearButton
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.s16),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.s16),
            searchBar.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -Space.s32),
            searchBar.heightAnchor.constraint(equalToConstant: Space.s40),
            searchIcon.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            searchIcon.heightAnchor.constraint(equalToConstant: Layout.iconSize),
            clearButton.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            clearButton.heightAnchor.constraint(equalToConstant: Layout.iconSize)
        ])
    }
    
    func configureViews() {
        backgroundColor = Colors.Background.base
        
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        searchBar.delegate = self
    }
}


extension SearchView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateSearchBarState(isEditing: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSearchBarState(isEditing: false)
    }
}
