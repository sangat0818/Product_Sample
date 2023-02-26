//
//  ProductLandingItemViewModel.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import Foundation

class ProductLandingItemViewModel: ProductListItemDataSource {
    var dataProvider: ProductListWorkerDataSource?
    
    init(dataProvider: ProductListWorkerDataSource?) {
        self.dataProvider = dataProvider
    }
    
    
    var id: Int {
        return dataProvider?.getProductDetail()?.id ?? .zero
    }
    
    var image: String {
        return dataProvider?.getProductDetail()?.image ?? ""
    }
    
    var title: String {
        return dataProvider?.getProductDetail()?.title ?? ""
    }
    
    var rating: String {
        return String(dataProvider?.getProductDetail()?.rating?.rate ?? .zero)
    }
    
    var ratingCount: String {
        return "|  " + String(dataProvider?.getProductDetail()?.rating?.count ?? .zero)
    }
    
    var price: String {
        return "USD " + String(dataProvider?.getProductDetail()?.price ?? .zero)
    }
    
    var category: String {
        return dataProvider?.getProductDetail()?.category ?? ""
    }
    
    var description: String {
        return dataProvider?.getProductDetail()?.description ?? ""
    }
    
    func handleCategoryTapped(categoryId: String) {
        dataProvider?.handleCategoryTapped(categoryId: categoryId)
    }
}
