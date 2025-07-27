//
//  ItemDetailsView.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//

import UIKit

class ItemDetailsView: UIView {
    // MARK: - UI Properties
    private let categoryBreadcrumb: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s12, weight: .light)
        label.textColor = Colors.Text.text
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let imageGallery: ImageCarouselView = {
        let carousel = ImageCarouselView()
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s24, weight: .semibold)
        label.textColor = Colors.Text.heading01
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s24, weight: .bold)
        label.textColor = Colors.Text.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let quantityAvailableLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s12, weight: .regular)
        label.textColor = Colors.Text.text
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var firstRowDetailsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceLabel, quantityAvailableLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = Space.s4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let secondRowDetailsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s12, weight: .regular)
        label.textColor = Colors.Text.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let sellerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s12, weight: .regular)
        label.textColor = Colors.Text.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let sellerCityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s12, weight: .regular)
        label.textColor = Colors.Text.text
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var thirdRowDetailsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sellerLabel, sellerCityLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = Space.s4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var detailsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstRowDetailsStackView, secondRowDetailsLabel, thirdRowDetailsStackView])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = Space.s4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s16, weight: .semibold)
        label.textColor = Colors.Text.text
        label.text = DefaultText.descriptionTxt
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Space.s12, weight: .semibold)
        label.textColor = Colors.Text.body01
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDetails(for product: Product) {
        categoryBreadcrumb.text = "Loja > Alimento > Arroz"
        Task {
            await MainActor.run {
                imageGallery.setImages([])
            }
        }
        titleLabel.text = product.title
        priceLabel.text = product.price.asCurrency(currencyCode: product.currencyId)
        quantityAvailableLabel.attributedText = formatTextWithBold(DefaultText.quantity, "\(product.availableQuantity)")
        secondRowDetailsLabel.attributedText = formatTextWithBold(DefaultText.productCondition, "Novo")
        sellerLabel.attributedText = formatTextWithBold(DefaultText.sellerBy, "\(product.seller.nickname)")
        sellerCityLabel.attributedText = formatTextWithBold(DefaultText.sellerCity, "Florianopolis")
        descriptionValueLabel.text = "Harina De Arroz Dicomere 1kg\n\nProducto alimenticio a base de arroz molido, ideal para recetas sin gluten. Este paquete contiene 1 kilogramo de harina de arroz de la marca Dicomere, perfecta para la elaboración de diversas preparaciones culinarias como panes, tortas y otros platillos que requieran de un sustituto de la harina de trigo. Su textura fina y su capacidad para absorber la humedad la hacen una opción versátil en la cocina. \n\nEste producto es apto para personas que llevan una dieta libre de gluten o para aquellos que desean experimentar con alternativas a la harina tradicional. La harina de arroz Dicomere es un ingrediente esencial para quienes buscan opciones saludables y nutritivas en su alimentación diaria."
    }
    
    private func formatTextWithBold(_ label: String, _ text: String) -> NSAttributedString {
        let newText = "\(label): \(text)"
        let attributedText = NSMutableAttributedString(string: newText)
        let range = (newText as NSString).range(of: label)
        attributedText.addAttributes([.font: UIFont.systemFont(ofSize: Space.s12, weight: .bold)], range: range)
        return attributedText
    }
}

extension ItemDetailsView: ViewCodeConfiguration {
    func buildViewHierarchy() {
        addSubview(categoryBreadcrumb)
        addSubview(imageGallery)
        addSubview(titleLabel)
        addSubview(detailsStackView)
        addSubview(descriptionLabel)
        addSubview(descriptionValueLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryBreadcrumb.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Space.s4),
            categoryBreadcrumb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.s16),
            categoryBreadcrumb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.s16),
            
            imageGallery.topAnchor.constraint(equalTo: categoryBreadcrumb.bottomAnchor, constant: Space.s8),
            imageGallery.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.s16),
            imageGallery.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.s16),
            imageGallery.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: imageGallery.bottomAnchor, constant: Space.s8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.s16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.s16),
            
            detailsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Space.s8),
            detailsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.s16),
            detailsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.s16),
            
            descriptionLabel.topAnchor.constraint(equalTo: detailsStackView.bottomAnchor, constant: Space.s16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.s16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.s16),
            
            descriptionValueLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Space.s4),
            descriptionValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.s16),
            descriptionValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.s16),
            descriptionValueLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Space.s4)
        ])
    }
    
    func configureViews() {
        backgroundColor = Colors.Background.variant02
    }
}
