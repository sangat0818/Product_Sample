//
//  CategoryLandingConfiguration.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import Foundation
import UIKit


class CategoryLandingConfiguration {
    static func setup(categoryId: String) -> UIViewController {
        if let controller = UIStoryboard(name: "CategoryLanding", bundle: nil).instantiateViewController(withIdentifier: "CategoryLandingViewController") as? CategoryLandingViewController {
            let viewModel = CategoryLandingViewModel()
            viewModel.categoryId = categoryId
            viewModel.viewDelegate = controller
            controller.viewModel = viewModel
            return controller
        }
        return UIViewController()
    }
}
