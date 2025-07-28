//
//  SearchResultItemCell.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//


import UIKit

protocol SearchResultItemCellDelegate: AnyObject {
    func cellDidSingleTap(_ cell: SearchResultItemCell)
    func loadImage(for url: String) async -> Data?
}

class SearchResultItemCell: UITableViewCell {
    
    // MARK: - Properties
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Background.variant02
        view.layer.cornerRadius = Space.s12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var shimmerView: ShimmerView = {
        let view = ShimmerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var itemImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isHidden = true
        return image
    }()
    
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s16, weight: .bold)
        label.textColor = Colors.Text.heading01
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s12, weight: .light)
        label.textColor = Colors.Feedback.information
        label.numberOfLines = 1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var firstRowStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceLabel, quantityLabel])
        stack.axis = .horizontal
        stack.spacing = Space.s4
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .clear
        return stack
    }()
    
    private let secondRowLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s16, weight: .regular)
        label.textColor = Colors.Feedback.information
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let thirdRowLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s12, weight: .light)
        label.textColor = Colors.Feedback.information
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let fourthRowLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s12, weight: .light)
        label.textColor = Colors.Feedback.information
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstRowStackView, secondRowLabel, thirdRowLabel, fourthRowLabel])
        stack.axis = .vertical
        stack.spacing = Space.s4
        stack.distribution = .fill
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
    
    func configureCell(_ product: Product) {
        priceLabel.text = product.price.asCurrency(currencyCode: product.currencyId)
        quantityLabel.text = "\(DefaultText.quantity): \(product.availableQuantity)"
        secondRowLabel.text = product.title
        thirdRowLabel.text = "\(DefaultText.sellerBy): \(product.seller.nickname)"
        fourthRowLabel.text = "id: \(product.id)" // Mostrando o id apenas para facilitar o uso de mock
        Task { [weak self] in
            await self?.setImage(from: product.thumbnail)
        }
    }
    
    @MainActor
    func setImage(from urlString: String?) async {
        shimmerView.startShimmer()
        shimmerView.isHidden = false
        itemImageView.image = nil
        guard let urlString = urlString, !urlString.isEmpty else {
            shimmerView.stopShimmering()
            shimmerView.isHidden = true
            itemImageNotAvailable()
            return
        }
        
        let data = await delegate?.loadImage(for: urlString)
        shimmerView.stopShimmering()
        shimmerView.isHidden = true
        
        if let data = data, let image = UIImage(data: data) {
            itemImageView.image = image
            itemImageView.isHidden = false
        } else {
            itemImageNotAvailable()
        }
    }
    
    private func itemImageNotAvailable() {
        let config = UIImage.SymbolConfiguration(pointSize: Space.s32, weight: .regular)
        itemImageView.image = UIImage(systemName: "cart.circle.fill", withConfiguration: config)
        itemImageView.tintColor = Colors.Action.disabledVariant
        itemImageView.layer.cornerRadius = Space.s8
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .center
        itemImageView.isHidden = false
        
    }
    
    @objc
    private func handleSingleTap() {
        delegate?.cellDidSingleTap(self)
    }
}

extension SearchResultItemCell: ViewCodeConfiguration {
    func buildViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(itemImageView)
        containerView.addSubview(shimmerView)
        containerView.addSubview(mainStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(lessThanOrEqualToConstant: 140),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.s4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.s4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.s8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Space.s8),
            
            itemImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Space.s8),
            itemImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            itemImageView.heightAnchor.constraint(equalToConstant: Space.s80),
            itemImageView.widthAnchor.constraint(equalToConstant: Space.s64),
            
            shimmerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Space.s8),
            shimmerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            shimmerView.heightAnchor.constraint(equalToConstant: Space.s64),
            shimmerView.widthAnchor.constraint(equalToConstant: Space.s48),
            
            
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Space.s8),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Space.s8),
            mainStackView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: Space.s4),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Space.s8),
        ])
    }
    
    func configureViews() {
        setupGestures()
        secondRowLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        secondRowLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
}
