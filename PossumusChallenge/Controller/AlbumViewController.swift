//
//  ViewController.swift
//  PossumusChallenge
//
//  Created by Francisco Donadio on 12/09/2022.
//

import UIKit

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var albumModel: AlbumModel?

    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performAlbumRequest { (albums) in
            for album in albums {
                print(album.title!)
            }
        }
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return albumModel?.data.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let albumModel = albumModel {
            return albumModel.data.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        performAlbumRequest { (albums) in
            
        }
        let text = self.albumModel?.data[indexPath.section].title
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = text
        return cell
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

    


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
