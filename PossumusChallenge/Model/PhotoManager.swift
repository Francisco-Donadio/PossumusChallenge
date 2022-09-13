//
//  PhotoManager.swift
//  PossumusChallenge
//
//  Created by Francisco Donadio on 12/09/2022.
//

import Foundation
import UIKit

var model: Albums?

//struct PhotoManager {
//    let baseURL = "https://jsonplaceholder.typicode.com/"
//
//    func performAlbumRequest() {
//        if let url = URL(string: "\(baseURL)albums") {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { data, response, error in
//
//                guard let data = data else { return }
//
//                do {
//                    let albumData = try JSONDecoder().decode(AlbumModel.self, from: data)
//                } catch {
//                    let error = error
//                    print(error.localizedDescription)
//                }
//            }.resume()
//        }
//    }
//}


//protocol AlbumManagerDelegate {
//    func loadAlbums(title: String)
//    func didFailWithError(error: Error)
//}
//
//struct PhotoManager {
//
//    var delegate: AlbumManagerDelegate?
//
//    let baseURL = "https://jsonplaceholder.typicode.com/albums"
//
//    func getAlbumTitle() {
//
//        if let url = URL(string: baseURL) {
//
//            let session = URLSession(configuration: .default)
//
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    delegate?.didFailWithError(error: error!)
//                    return
//                }
//                if let safeData = data {
//                    let albumTitle = self.parseJSON(safeData)
//                    delegate?.loadAlbums(title: albumTitle ?? "")
//                    print(albumTitle)
//                }
//            }
//            task.resume()
//        }
//
//
//    }
//
//    func parseJSON(_ albumData: Data) -> [Albums] {
//        let decoder = JSONDecoder()
//        do{
//            let decodedData = try decoder.decode([Albums].self, from: albumData)
//            let albumTitle = decodedData.title
//            print(albumTitle)
//            return albumTitle
//        } catch {
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
//
//
//}
