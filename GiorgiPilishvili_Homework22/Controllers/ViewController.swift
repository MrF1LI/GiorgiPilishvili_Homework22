//
//  ViewController.swift
//  GiorgiPilishvili_Homework22
//
//  Created by GIORGI PILISSHVILI on 13.08.22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Variables
    
    @IBOutlet weak var tableViewMovies: UITableView!
    
    var arrayOfMovies = [MovieResponseData.Movie]()
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTableView()
        getCountriesData()
        checkGuestSession()
    }
    
    // MARK: Functions
    
    func configureTableView() {
        tableViewMovies.delegate = self
        tableViewMovies.dataSource = self
        tableViewMovies.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    func getCountriesData() {
        
        let urlString = "https://api.themoviedb.org/3/tv/top_rated?api_key=\(MovieDatabase.APIKey)&language=en-US&page=1"
        
        MovieDatabase.shared.getData(urlString: urlString) { (object: MovieResponseData) in
            self.arrayOfMovies = object.movies
            self.tableViewMovies.reloadData()
        }
    }
    
    func checkGuestSession() {
        let guestSessionId = UserDefaults.standard.value(forKey: "guestSessionId") as? String
        
        if guestSessionId == nil {
            generateGuestSession()
        }
    }
    
    func generateGuestSession() {
        let urlString = "https://api.themoviedb.org/3/authentication/guest_session/new?api_key=\(MovieDatabase.APIKey)"
        
        MovieDatabase.shared.getData(urlString: urlString) { (object: GuestSession) in
            UserDefaults.standard.setValue(object.guestSessionId, forKey: "guestSessionId")
        }
    }
    
}
