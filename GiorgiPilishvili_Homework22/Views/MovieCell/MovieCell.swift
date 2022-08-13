//
//  MovieCell.swift
//  GiorgiPilishvili_Homework22
//
//  Created by GIORGI PILISSHVILI on 13.08.22.
//

import UIKit

class MovieCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelVoteAverage: UILabel!
    @IBOutlet weak var imageViewMovie: UIImageView!
    
    // MARK: Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureDesign()
    }
    
    // MARK: Functinos

    func configureDesign() {
        imageViewMovie.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movie: MovieResponseData.Movie) {
        
        labelName.text = movie.name
        labelVoteAverage.text = "\(movie.voteAverage)"
        
        if let urlString = URL(string: "https://image.tmdb.org/t/p/w500/\(movie.imageUrl)") {
            imageViewMovie.load(url: urlString)
        }
        
    }
    
}
