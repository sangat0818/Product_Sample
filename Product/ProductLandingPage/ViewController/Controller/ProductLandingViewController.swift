//
//  ProductLandingViewController.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import UIKit

class ProductLandingViewController: BaseViewController {

    @IBOutlet weak var productLandingTableView: UITableView!
    var viewModel: ProductLandingViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLoading()
        viewModel?.fetchProductDetail()
        prepareTableView()
        title = "Product Detail"
        // Do any additional setup after loading the view.
    }
    
    private func prepareTableView() {
        self.productLandingTableView.dataSource = self
        self.productLandingTableView.delegate = self
        self.productLandingTableView.showsVerticalScrollIndicator = false
        self.productLandingTableView.separatorStyle = .none
        self.productLandingTableView.register(UINib(nibName: "ProductLandingItemCell", bundle: nil), forCellReuseIdentifier: "ProductLandingItemCell")
    }
}

extension ProductLandingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.productDetailModel != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel?.prepareTableView(tableView: tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
}

extension ProductLandingViewController: ProductListViewDelegate {
    func reloadBaseView() {
        DispatchQueue.main.async {
            self.stopLoading()
            self.productLandingTableView.reloadData()
        }
    }
}
