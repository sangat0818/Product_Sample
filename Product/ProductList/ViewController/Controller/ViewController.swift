//
//  ViewController.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var productListTableView: UITableView!
    var viewModel: ProductListViewModel = ProductListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDelegate = self
        prepareTableView()
        self.startLoading()
        viewModel.fetchAllProduct()
        title = "Home"
        // Do any additional setup after loading the view.
    }
    
    private func prepareTableView() {
        self.productListTableView.dataSource = self
        self.productListTableView.delegate = self
        self.productListTableView.showsVerticalScrollIndicator = false
        self.productListTableView.separatorStyle = .none
        self.productListTableView.register(UINib(nibName: "ProductListItemCell", bundle: nil), forCellReuseIdentifier: "ProductListItemCell")
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.productListModel?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.viewModel.prepareTableView(tableView: tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectRowAt(tableView: tableView, indexPath: indexPath)
    }
}


extension ViewController: ProductListViewDelegate {
    func reloadBaseView() {
        DispatchQueue.main.async {
            self.stopLoading()
            self.productListTableView.reloadData()
        }
        
    }
}
