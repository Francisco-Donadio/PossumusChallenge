//
//  PhotoViewController.swift
//  PossumusChallenge
//
//  Created by Francisco Donadio on 14/09/2022.
//

import UIKit
import Kingfisher

class PhotoViewController: UIViewController {
    
    var albums: [Albums] = []
    var photos: [Photos] = []
    var albumId: Int = 0
    var photoURL: String = ""
    var phototitle: String = ""
    var albumTitle: String = ""
    
    
    @IBOutlet weak var photoView: UICollectionView!

    
    override func viewDidLoad() {
        
        photoView.delegate = self
        photoView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        photoView.collectionViewLayout = layout
        
        performPhotoDetailRequest { photos in
            self.photos = photos
            DispatchQueue.main.async {
                self.photoView.reloadData()
            }
        }
    }

    func performPhotoDetailRequest(completionHandler: @escaping ([Photos]) -> Void) {
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


extension PhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let url = URL(string: photoURL)
        cell.image.kf.setImage(with: url)
        cell.albumTitle.text = "Album Title: \(albumTitle.capitalized)"
        cell.imageTitle.text = "Photo Title: \(phototitle.capitalized)"
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let h = photoView.frame.height
        let w = view.frame.width
        return CGSize(width: w, height: h)
    }
}


