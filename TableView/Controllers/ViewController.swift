//
//  ViewController.swift
//  TableView
//
//  Created by 오정석 on 5/12/2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    
//    var moviesArray: [Movie] = []
    
    var movieDataManager = DataManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
    
        
        
        movieDataManager.makeMovieData()
//        moviesArray = movieDataManager.getMovieData()
        
        
    }
}

extension ViewController: UITableViewDataSource {
    
    //셀을 몇개 표시할까
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDataManager.getMovieData().count
    }
    
    
    //어떻게 셀을 표시할까
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let array = movieDataManager.getMovieData()
        let movie = array[indexPath.row]
        
        cell.mainImageView.image = movie.movieImage
        cell.movieNameLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
        
        //cell.selectionStyle = .none //클릭했을때 이팩트가 없음
        
        return cell
    }
    
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail"{
            let detailVC = segue.destination as! DetailViewController
            
            let array =  movieDataManager.getMovieData()
            
            let indexPath = sender as! IndexPath
            
            //데이터 전달
            detailVC.movieData = array[indexPath.row]  //우리가 전달하기 원하는 영화 데이터
        }
        
        
    }
}
