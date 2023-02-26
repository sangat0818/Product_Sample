//
//  ProductListViewModel.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import Foundation
import UIKit

protocol ProductListViewModelDelegate: ProductListWorkerDataSource, TableViewInteractorDelegate {
    var viewDelegate: ProductListViewDelegate? { get set }
    func triggerFetchProductAPI(completion handler: @escaping (([ProductListResponseModel]?, String?) -> Void?))
}

protocol TableViewInteractorDelegate {
    func prepareTableView(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func didSelectRowAt(tableView: UITableView, indexPath: IndexPath)
}

protocol ProductListViewDelegate: AnyObject {
    func reloadBaseView()
}

protocol ProductListWorkerDataSource {
    func getProductList() -> [ProductListResponseModel]?
    func getProductDetail() -> ProductListResponseModel?
    func handleCategoryTapped(categoryId: String)
}

extension ProductListWorkerDataSource {
    func getProductList() -> [ProductListResponseModel]? {
        return []
    }
    
    func getProductDetail() -> ProductListResponseModel? {
        return nil
    }
    
    func handleCategoryTapped(categoryId: String) {}
}


class ProductListViewModel {
    var productListModel: [ProductListResponseModel]?
    weak var viewDelegate: ProductListViewDelegate?
    
    func fetchAllProduct() {
        self.triggerFetchProductAPI { model, _ in
            self.productListModel = model
            self.viewDelegate?.reloadBaseView()
        }
    }
}

extension ProductListViewModel: ProductListViewModelDelegate {
    func triggerFetchProductAPI(completion handler: @escaping (([ProductListResponseModel]?, String?) -> Void?)) {
        NetworkUtility.request(urlString: "https://fakestoreapi.com/products") { data, response, error in
            let networkModel = NetworkUtility.getResponseModel(data: data, error: error, response: response, type: [ProductListResponseModel].self)
            handler(networkModel.model, error.debugDescription)
        }
    }
    
    func getProductList() -> [ProductListResponseModel]? {
        return productListModel
    }
    
    func prepareTableView(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListItemCell", for: indexPath) as? ProductListItemCell else {
            return UITableViewCell()
        }
        let viewModel = ProductListItemViewModel(dataProvider: self, index: indexPath.row)
        cell.dataSource = viewModel
        cell.selectionStyle = .none
        return cell
    }
    
    func didSelectRowAt(tableView: UITableView, indexPath: IndexPath) {
        let productId = self.getProductList()?.get(index: indexPath.row)?.id ?? .zero
        let controller = ProductLandingConfiguration.setup(productId: String(productId))
        (viewDelegate as? ViewController)?.navigationController?.pushViewController(controller, animated: true)
    }
}
