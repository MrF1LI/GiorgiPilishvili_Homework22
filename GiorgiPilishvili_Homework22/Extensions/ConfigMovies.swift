//
//  ConfigMovies.swift
//  GiorgiPilishvili_Homework22
//
//  Created by GIORGI PILISSHVILI on 13.08.22.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell
        guard let cell = cell else { return UITableViewCell() }
        
        let currentMovie = arrayOfMovies[indexPath.row]
        cell.configure(with: currentMovie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentMovie = arrayOfMovies[indexPath.row]
        showDetails(of: currentMovie)
    }
    
    func showDetails(of movie: MovieResponseData.Movie) {
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        guard let detailsVC = detailsVC else { return }
        
        detailsVC.movie = movie
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
