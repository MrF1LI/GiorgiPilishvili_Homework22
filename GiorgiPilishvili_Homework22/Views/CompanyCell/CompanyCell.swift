//
//  CompanyCell.swift
//  GiorgiPilishvili_Homework22
//
//  Created by GIORGI PILISSHVILI on 13.08.22.
//

import UIKit

class CompanyCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelOriginCountry: UILabel!
    @IBOutlet weak var imageViewLogo: UIImageView!
    
    // MARK: Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: Functions
    
    func configure(with company: MovieDetails.Company) {
        
        labelName.text = company.name
        labelOriginCountry.text = company.originCountry

        if let urlString = URL(string: "https://image.tmdb.org/t/p/w500/\(company.logoUrl ?? "")") {
            imageViewLogo.load(url: urlString)
        }
        
    }

}
