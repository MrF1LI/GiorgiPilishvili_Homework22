//
//  DetailsViewController.swift
//  GiorgiPilishvili_Homework22
//
//  Created by GIORGI PILISSHVILI on 13.08.22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: Variables
    
    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var labelOverview: UILabel!
    
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelVoteCount: UILabel!
    
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelType: UILabel!
    
    @IBOutlet weak var movieRating: CosmosView!
    
    @IBOutlet weak var collectionViewCompanies: UICollectionView!
    
    var movie: MovieResponseData.Movie!
    
    var arrayOfCompanies = [MovieDetails.Company]()
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showMovieDetails()
        configureMovieRating()
        fetchMovieDetails()
        configureCollectionView()
    }
    
    // MARK: - Functions
    
    func showMovieDetails() {
        title = movie.name
        labelOverview.text = movie.overview
        
        labelRating.text = "\(movie.voteAverage)"
        labelVoteCount.text = "Based on \(movie.voteCount) rates"
        
        movieRating.fillMode = 1
        movieRating.rating = Double(movie.voteAverage) / 2
        
        imageViewMovie.layer.cornerRadius = 15
        let urlString = "https://image.tmdb.org/t/p/w500/\(movie.imageUrl)"
        if let url = URL(string: urlString) {
            imageViewMovie.load(url: url)

        }
    }
    
    func configureMovieRating() {
        
        movieRating.didFinishTouchingCosmos = { rating in
            
            let guestSessionId = UserDefaults.standard.value(forKey: "guestSessionId") as? String
            guard let guestSessionId = guestSessionId else { return }
            
            let urlString = "https://api.themoviedb.org/3/tv/100/rating"
            
            var urlComponent = URLComponents(string: urlString)
            
            urlComponent?.queryItems = [
                URLQueryItem(name: "api_key", value: MovieDatabase.APIKey),
                URLQueryItem(name: "guest_session_id", value: guestSessionId),
                URLQueryItem(name: "value", value: "\(rating)")
            ]
            
            var request = URLRequest(url: (urlComponent?.url!)!)
            request.httpMethod = "POST"
                             
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else { return }
                
                guard let data = data else {
                    return
                }
                
                do {
                    let object = try JSONDecoder().decode(RateResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Rate Movie", message: object.statusMessage, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    
                } catch {
                    print("[MovieDatabase] - Decoding error.")
                }

            }.resume()
            
        }
        
    }
    
    func fetchMovieDetails() {
        
        let urlString = "https://api.themoviedb.org/3/tv/\(movie.id)?api_key=\(MovieDatabase.APIKey)&language=en-US"
        
        MovieDatabase.shared.getData(urlString: urlString) { (object: MovieDetails) in
            self.loadDetails(of: object)
        }
        
    }
    
    func loadDetails(of movieDetails: MovieDetails) {
        labelType.text = movieDetails.type
        labelStatus.text = movieDetails.status
        
        for each in movieDetails.productionCompanies ?? [] {
            print(each.name, each.originCountry)
        }
        
        arrayOfCompanies = movieDetails.productionCompanies ?? []
        collectionViewCompanies.reloadData()
    }
    
    func configureCollectionView() {
        collectionViewCompanies.delegate = self
        collectionViewCompanies.dataSource = self
        collectionViewCompanies.register(UINib(nibName: "CompanyCell", bundle: nil), forCellWithReuseIdentifier: "CompanyCell")
    }

}
