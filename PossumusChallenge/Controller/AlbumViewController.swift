//
//  ViewController.swift
//  PossumusChallenge
//
//  Created by Francisco Donadio on 12/09/2022.
//

import UIKit

class AlbumViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var albums: [Albums] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        performAlbumRequest { albums in
            self.albums = albums
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func performAlbumRequest(completionHandler: @escaping ([Albums]) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let albumsData = try JSONDecoder().decode([Albums].self, from: data)
                completionHandler(albumsData)
            } catch {
                let error = error
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "AlbumCell")
        let album = self.albums[indexPath.row]
        cell.detailTextLabel?.text = album.title.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        print(album.id)
        let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlbumDetailViewController") as! AlbumDetailViewController
        detailViewController.albumId = album.id
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
