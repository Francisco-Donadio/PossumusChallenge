//
//  AlbumDetailViewController.swift
//  PossumusChallenge
//
//  Created by Francisco Donadio on 13/09/2022.
//

import UIKit
import Kingfisher

class AlbumDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var albums: [Albums] = []
    var photos: [Photos] = []
    var albumId: Int = 0
    var albumTitle: String = ""
    
    override func viewDidLoad() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.navigationItem.title = albumTitle.capitalized
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        collectionView.collectionViewLayout = layout
        
        performPhotosRequest { photos in
            self.photos = photos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func performPhotosRequest(completionHandler: @escaping ([Photos]) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/albums/\(albumId)/photos"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let photosData = try JSONDecoder().decode([Photos].self, from: data)
                completionHandler(photosData)
            } catch {
                let error = error
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension AlbumDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let url = URL(string: photos[indexPath.row].thumbnailUrl)
        cell.imageView.kf.setImage(with: url)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let h = 70.0
        let w = (view.frame.width / 6)
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        let photoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        photoViewController.albumId = photo.albumId
        photoViewController.photoURL = photo.url
        photoViewController.phototitle = photo.title
        photoViewController.albumTitle = albumTitle
        self.navigationController?.pushViewController(photoViewController, animated: true)
    }
}

