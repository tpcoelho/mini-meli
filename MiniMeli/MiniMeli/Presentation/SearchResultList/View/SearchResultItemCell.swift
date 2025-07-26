//
//  SearchResultItemCell.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//


import UIKit

protocol SearchResultItemCellDelegate: AnyObject {
    func cellDidSingleTap(_ cell: SearchResultItemCell)
}

class SearchResultItemCell: UITableViewCell {
    
    // MARK: - Properties
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Background.variant01
        view.layer.cornerRadius = Space.s16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImg: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s16, weight: .medium)
        label.textColor = Colors.Feedback.information
        label.text = "\u{2605}" // Unicode for star icon
        label.textAlignment = .center
        //        label.backgroundColor = NFColors.Background.variant02
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s16, weight: .medium)
        label.textColor = Colors.Feedback.information
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s16, weight: .bold)
        label.textColor = Colors.Feedback.information
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let icon1 = UIImageView(image: UIImage(systemName: "star"))
        icon1.translatesAutoresizingMaskIntoConstraints = false
        icon1.widthAnchor.constraint(equalToConstant: Spacing.sm).isActive = true
        icon1.heightAnchor.constraint(equalToConstant: Spacing.sm).isActive = true
        
        let icon2 = UIImageView(image: UIImage(systemName: "heart"))
        icon2.translatesAutoresizingMaskIntoConstraints = false
        icon2.widthAnchor.constraint(equalToConstant: Spacing.sm).isActive = true
        icon2.heightAnchor.constraint(equalToConstant: Spacing.sm).isActive = true
        
        let icon3 = UIImageView(image: UIImage(systemName: "bell"))
        icon3.translatesAutoresizingMaskIntoConstraints = false
        icon3.widthAnchor.constraint(equalToConstant: Spacing.sm).isActive = true
        icon3.heightAnchor.constraint(equalToConstant: Spacing.sm).isActive = true
        icon3.tintColor = Colors.Feedback.alert
        
        let stack = UIStackView(arrangedSubviews: [ icon1, icon2, icon3])
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = Space.s4
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .clear
        return stack
    }()
    
    // MARK: - Delegate
    weak var delegate: SearchResultItemCellDelegate?
    
    // MARK: - Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupGestures() {
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(singleTapGesture)
    }
    
    func configureCell(_ item: Product) {
//        titleLabel.text = item.name
//        descriptionLabel.text = item.value.asCurrency()
    }
    
    @objc
    private func handleSingleTap() {
        print("Cell single tapped")
        delegate?.cellDidSingleTap(self)
    }
}

extension SearchResultItemCell: ViewCodeConfiguration {
    func buildViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(iconImg)
        containerView.addSubview(mainStackView)
        containerView.addSubview(infoStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.xxs),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Spacing.xxs),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.xs),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.xs),
            
            iconImg.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Spacing.xs),
            iconImg.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImg.heightAnchor.constraint(equalToConstant: Spacing.xxl),
            iconImg.widthAnchor.constraint(equalToConstant: Spacing.xxl),
            
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Spacing.xxs),
            mainStackView.leadingAnchor.constraint(equalTo: iconImg.trailingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Spacing.xs),
            
            infoStackView.heightAnchor.constraint(equalToConstant: Spacing.sm),
            infoStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -Spacing.xs),
            infoStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Spacing.xxs),
        ])
    }
    
    func configureViews() {
        setupGestures()
    }
}
