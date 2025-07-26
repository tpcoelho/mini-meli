//
//  SearchResultListViewController.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//


import UIKit

class SearchResultListViewController: UIViewController {
    
    private lazy var mainView: SearchResultListView = {
        let view = SearchResultListView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
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
        viewModel.viewDidLoad()
    }
}

extension SearchResultListViewController: ViewCodeConfiguration {
    func buildViewHierarchy() {
        view.addSubview(mainView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureViews() {
        view.backgroundColor = Colors.Background.base
    }
}

extension SearchResultListViewController: SearchResultListViewModelOutput {
    func updateState(_ state: SearchResultListState) {
        Task { @MainActor in
            switch state {
            case .loading:
                LoadingHUD.shared.start()
            case .loaded:
                LoadingHUD.shared.stop()
                self.mainView.tableView.reloadData()
            }
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
            let item = viewModel.productsList[indexPath.row]
            viewModel.openDetails(for: item)
        }
    }
}
