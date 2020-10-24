//
//  MovieGridDetailsViewController.swift
//  Flix
//
//  Created by Stephen Tan on 10/22/20.
//  Copyright © 2020 Stephen Tan. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridDetailsViewController: UIViewController {
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var backdropView: UIImageView!
    var movie: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backdropView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af.setImage(withURL: posterUrl!)

        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
               
        backdropView.af.setImage(withURL: backdropUrl!)
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let url = "https://api.themoviedb.org/3/movie/\(movie["id"]!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let trailerViewController = segue.destination as! MovieTrailerViewController
        trailerViewController.trailerURL = url
    }

}
