//
//  ProductListItemCell.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import UIKit

class ProductListItemCell: UITableViewCell {

    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var lblCount: UILabel!
    lazy var dataSource: ProductListItemDataSource? = nil {
        didSet {
            setData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        lblProduct.font = .latoBold(size: 16)
        lblPrice.font = .latoRegular(size: 14)
        lblRating.font = .latoRegular(size: 13)
        lblCount.font = .latoRegular(size: 13)
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.productImage.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setData() {
        lblRating.text = dataSource?.rating ?? ""
        lblCount.text = dataSource?.ratingCount ?? ""
        lblPrice.text = dataSource?.price ?? ""
        lblProduct.text = dataSource?.title ?? ""
        if let url = URL(string: dataSource?.image ?? "") {
            productImage.downloaded(from: url)
        }
        
    }
    
}
