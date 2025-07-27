//
//  SearchResultListView.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//


import UIKit

class SearchResultListView: UIView {
    
    // MARK: - Properties
    lazy var menuBar: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchResultItemCell.self, forCellReuseIdentifier: "SearchResultItemCell")
        //TODO: Criar cell para fim da busca
//        tableView.register(NoMoreItemsCell.self, forCellReuseIdentifier: "NoMoreItemsCell")
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.alwaysBounceHorizontal = false
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Model
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultListView: ViewCodeConfiguration {
    func buildViewHierarchy() {
        addSubview(menuBar)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
//            menuBar.topAnchor.constraint(equalTo: topAnchor, constant: Space.s24),
//            menuBar.leadingAnchor.constraint(equalTo: leadingAnchor),
//            menuBar.trailingAnchor.constraint(equalTo: trailingAnchor),
//            menuBar.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Space.s8)
        ])
    }
    
    func configureViews() {
        backgroundColor = Colors.Contrast.white
    }
}
