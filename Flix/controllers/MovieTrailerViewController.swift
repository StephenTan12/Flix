//
//  MovieTrailerViewController.swift
//  Flix
//
//  Created by Stephen Tan on 10/22/20.
//  Copyright © 2020 Stephen Tan. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {
    @IBOutlet weak var trailerView: WKWebView!
    var trailerURL = ""
    var youtubeURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: trailerURL)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
              let movieTrailerDetails = dataDictionary["results"] as! [[String:Any]]
              for item in movieTrailerDetails {
                let movieTrailerKey = item["key"] as! String
                let baseURL = "https://www.youtube.com/watch?v="
                self.youtubeURL = baseURL + movieTrailerKey
                break
              }
              let trailer = URL(string: self.youtubeURL)!
              let myRequest = URLRequest(url: trailer)
              self.trailerView.load(myRequest)
           }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
