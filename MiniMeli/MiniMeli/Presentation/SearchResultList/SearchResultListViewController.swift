//
//  SearchResultListViewController.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//


import UIKit

class SearchResultListViewController: UIViewController {
    
    private lazy var menuBar: SearchView = {
        let view = SearchView(viewDelegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainView: SearchResultListView = {
        let view = SearchResultListView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emptyView: EmptyStateView = {
        let view = EmptyStateView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Model
    private let viewModel: SearchResultListViewModelProtocol
    
    init(viewModel: SearchResultListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewOutput = self
    }
}

extension SearchResultListViewController: ViewCodeConfiguration {
    func buildViewHierarchy() {
        view.addSubview(menuBar)
        view.addSubview(mainView)
        view.addSubview(emptyView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Space.s8),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -Space.s8),
            menuBar.heightAnchor.constraint(equalToConstant: Space.s32),
            
            mainView.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: Space.s1),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyView.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: Space.s1),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureViews() {
        view.backgroundColor = Colors.Contrast.white
        setupNavigationBar()
    }
}

extension SearchResultListViewController: SearchResultListViewModelOutput {
    func updateState(_ state: SearchResultListState) {
        switch state {
        case .loading:
            LoadingHUD.shared.start()
        case .loaded:
            LoadingHUD.shared.stop()
        case .refreshList:
            LoadingHUD.shared.stop()
            if viewModel.productsList.isEmpty {
                emptyView.isHidden = false
                mainView.isHidden = true
            } else {
                emptyView.isHidden = true
                mainView.isHidden = false
            }
            self.mainView.tableView.reloadData()
        case .goToDetails(let product):
            viewModel.coordinator.route(.productDetails(product))
        case .error:
            LoadingHUD.shared.stop()
            viewModel.coordinator.route(.error(.genericError))
        }
    }
}

extension SearchResultListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultItemCell", for: indexPath) as? SearchResultItemCell else {
            return UITableViewCell()
        }
        cell.configureCell(viewModel.productsList[indexPath.row])
        cell.delegate = self
        return cell
    }
}
// MARK: - CellDelegate
extension SearchResultListViewController: SearchResultItemCellDelegate {
    func cellDidSingleTap(_ cell: SearchResultItemCell) {
        if let indexPath = mainView.tableView.indexPath(for: cell) {
            let product = viewModel.productsList[indexPath.row]
            updateState(.goToDetails(product))
        }
    }
    
    func loadImage(for url: String) async -> Data? {
        return await viewModel.loadImage(for: url)
    }
}
// MARK: - SearchBarDelegate
extension SearchResultListViewController: SearchViewDelegate {
    func textFieldShouldReturn(_ text: String?) {
        viewModel.search(text)
    }
}
