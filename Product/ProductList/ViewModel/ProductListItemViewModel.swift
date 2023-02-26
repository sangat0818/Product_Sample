//
//  ProductListItemViewModel.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import Foundation


protocol ProductListItemDataSource {
    var id: Int { get }
    var image: String { get }
    var title: String { get }
    var rating: String { get }
    var ratingCount: String { get }
    var price: String { get }
    var category: String { get }
    var description: String { get }
    func handleCategoryTapped(categoryId: String)
}

extension ProductListItemDataSource {
    func handleCategoryTapped(categoryId: String) {}
}

public extension Array {
    
    func get(index: Int) -> Element? {
        if index >= .zero, index < count {
            return self[index]
        } else {
            return nil
        }
    }
}


class ProductListItemViewModel: ProductListItemDataSource {
    
    var dataProvider: ProductListWorkerDataSource?
    var index: Int = .zero
    
    init(dataProvider: ProductListWorkerDataSource? = nil, index: Int = .zero) {
        self.dataProvider = dataProvider
        self.index = index
    }
    
    var id: Int {
        return dataProvider?.getProductList()?.get(index: index)?.id ?? .zero
    }
    
    var image: String {
        return dataProvider?.getProductList()?.get(index: index)?.image ?? ""
    }
    
    var title: String {
        return dataProvider?.getProductList()?.get(index: index)?.title ?? ""
    }
    
    var rating: String {
        return String(dataProvider?.getProductList()?.get(index: index)?.rating?.rate ?? .zero)
    }
    
    var ratingCount: String {
        return "|  " + String(dataProvider?.getProductList()?.get(index: index)?.rating?.count ?? .zero)
    }
    
    var price: String {
        return "USD " + String(dataProvider?.getProductList()?.get(index: index)?.price ?? .zero)
    }
    
    var category: String {
        return ""
    }
    
    var description: String {
        return ""
    }
}
