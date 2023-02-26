//
//  ProductLandingItemCell.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import UIKit

class ProductLandingItemCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var lblCount: UILabel!
    lazy var dataSource: ProductListItemDataSource? = nil {
        didSet {
            setData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(categoryTapped(tapGestureRecognizer:)))
        tapGesture.cancelsTouchesInView = false
        tapGesture.numberOfTapsRequired = 1
        tapGesture.delegate = self
        lblCategory.addGestureRecognizer(tapGesture)
        lblCategory.isUserInteractionEnabled = true
        lblTitle.font = .latoBold(size: 16)
        lblDescription.font = .latoRegular(size: 14)
        lblPrice.font = .latoRegular(size: 14)
        lblCategory.font = .latoBold(size: 14)
        lblRating.font = .latoRegular(size: 13)
        lblCount.font = .latoRegular(size: 13)
        categoryView.layer.cornerRadius = 8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func categoryTapped(tapGestureRecognizer _: UITapGestureRecognizer) {
        self.dataSource?.handleCategoryTapped(categoryId: self.dataSource?.category ?? "")
    }
    
    fileprivate func setData() {
        self.lblTitle.text = dataSource?.title ?? ""
        self.lblDescription.text = dataSource?.description ?? ""
        self.lblPrice.text = dataSource?.price ?? ""
        self.lblCategory.text = dataSource?.category ?? ""
        self.lblRating.text = dataSource?.rating ?? ""
        self.lblCount.text = dataSource?.ratingCount ?? ""
        if let url = URL(string: dataSource?.image ?? "") {
            self.productImage.downloaded(from: url)
        }
    }
    
}
