//
//  CategoryLandingViewController.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import UIKit

class CategoryLandingViewController: BaseViewController {

    @IBOutlet weak var categoryLandingTableView: UITableView!
    var viewModel: CategoryLandingViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLoading()
        viewModel?.fetchProductList()
        prepareTableView()
        title = "Category Landing"
        // Do any additional setup after loading the view.
    }
    
    private func prepareTableView() {
        self.categoryLandingTableView.dataSource = self
        self.categoryLandingTableView.delegate = self
        self.categoryLandingTableView.showsVerticalScrollIndicator = false
        self.categoryLandingTableView.separatorStyle = .none
        self.categoryLandingTableView.register(UINib(nibName: "ProductListItemCell", bundle: nil), forCellReuseIdentifier: "ProductListItemCell")
    }
}

extension CategoryLandingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.productListModel?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.viewModel?.prepareTableView(tableView: tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.didSelectRowAt(tableView: tableView, indexPath: indexPath)
    }
}


extension CategoryLandingViewController: ProductListViewDelegate {
    func reloadBaseView() {
        DispatchQueue.main.async {
            self.stopLoading()
            self.categoryLandingTableView.reloadData()
        }
    }
}
