//
//  ProductLandingConfiguration.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import Foundation
import UIKit


class ProductLandingConfiguration {
    static func setup(productId: String) -> UIViewController {
        if let controller = UIStoryboard(name: "ProductLanding", bundle: nil).instantiateViewController(withIdentifier: "ProductLandingViewController") as? ProductLandingViewController {
            let viewModel = ProductLandingViewModel()
            viewModel.productId = productId
            viewModel.viewDelegate = controller
            controller.viewModel = viewModel
            return controller
        }
        return UIViewController()
    }
}
