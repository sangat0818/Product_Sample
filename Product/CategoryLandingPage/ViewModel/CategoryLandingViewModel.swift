//
//  CategoryLandingViewModel.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import Foundation
import UIKit

protocol CategoryLandingViewModelDelegate: ProductListWorkerDataSource, TableViewInteractorDelegate {
    var viewDelegate: ProductListViewDelegate? { get set }
    func triggerFetchCategoryAPI(categoryId: String, completion handler: @escaping (([ProductListResponseModel]?, String?) -> Void?))

}


class CategoryLandingViewModel: CategoryLandingViewModelDelegate {
    var productListModel: [ProductListResponseModel]?
    var categoryId: String?
    weak var viewDelegate: ProductListViewDelegate?
    
    func triggerFetchCategoryAPI(categoryId: String, completion handler: @escaping (([ProductListResponseModel]?, String?) -> Void?)) {
        let urlString = "https://fakestoreapi.com/products/category/\(categoryId)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        NetworkUtility.request(urlString: urlString) { data, response, error in
            let networkModel = NetworkUtility.getResponseModel(data: data, error: error, response: response, type: [ProductListResponseModel].self)
            handler(networkModel.model, error.debugDescription)
        }
    }
    
    func fetchProductList() {
        triggerFetchCategoryAPI(categoryId: categoryId ?? "") { model, _ in
            self.productListModel = model
            self.viewDelegate?.reloadBaseView()
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
        (self.viewDelegate as? CategoryLandingViewController)?.navigationController?.pushViewController(controller, animated: true)
    }
}
