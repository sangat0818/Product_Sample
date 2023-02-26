//
//  ProductLandingViewModel.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import Foundation
import UIKit

protocol ProductLandingViewModelDelegate: ProductListWorkerDataSource, TableViewInteractorDelegate {
    var viewDelegate: ProductListViewDelegate? { get set }
    func triggerFetchProductDetailsAPI(productId: String, completion handler: @escaping ((ProductListResponseModel?, String?) -> Void?))
}


class ProductLandingViewModel: ProductLandingViewModelDelegate {
    func getProductDetail() -> ProductListResponseModel? {
        return productDetailModel
    }
    
    func handleCategoryTapped(categoryId: String) {
        let controller = CategoryLandingConfiguration.setup(categoryId: categoryId)
        (self.viewDelegate as? ProductLandingViewController)?.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    var productDetailModel: ProductListResponseModel?
    var productId: String?
    weak var viewDelegate: ProductListViewDelegate?
    
    func triggerFetchProductDetailsAPI(productId: String, completion handler: @escaping ((ProductListResponseModel?, String?) -> Void?)) {
        NetworkUtility.request(urlString: "https://fakestoreapi.com/products/\(productId)") { data, response, error in
            let networkModel = NetworkUtility.getResponseModel(data: data, error: error, response: response, type: ProductListResponseModel.self)
            handler(networkModel.model, error.debugDescription)
        }
    }
    
    func fetchProductDetail() {
        triggerFetchProductDetailsAPI(productId: productId ?? "") { model, _ in
            self.productDetailModel = model
            self.viewDelegate?.reloadBaseView()
        }
    }
    
    func prepareTableView(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductLandingItemCell", for: indexPath) as? ProductLandingItemCell else {
            return UITableViewCell()
        }
        let viewModel = ProductLandingItemViewModel(dataProvider: self)
        cell.dataSource = viewModel
        cell.selectionStyle = .none
        return cell
    }
    
    func didSelectRowAt(tableView: UITableView, indexPath: IndexPath) {}
}
