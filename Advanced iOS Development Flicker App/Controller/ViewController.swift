//
//  ViewController.swift
//  Advanced iOS Development Flicker App
//
//  Created by Timofei Sopin on 2018-03-12.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate, UISearchControllerDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var images:[ImageSearching] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        cell.imageSearch = images[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
    }
    
    
    // MARK: - UISearchBarDelegate
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//        performSearchWithText(searchText: searchBar.text!)
//    }
    
    func performSearchWithText(searchText: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        SearchAPI.fetchPhotosForSearchText(searchText: searchText, onCompletion: { (error: NSError?, flickrPhotos: [ImageSearching]?) -> Void in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if error == nil {
                self.images = flickrPhotos!
            } else {
                self.images = []
                if (error!.code == SearchAPI.Errors.invalidAccessErrorCode) {
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.showAlert()
                    })
                }
            }
            DispatchQueue.main.async(execute: { () -> Void in
                self.title = searchText
                self.collectionView.reloadData()
            })
        })
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//        performSearchWithText(searchText: searchBar.text!)
//    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Please provide a valid API key", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetSearchAPI(_ sender: Any) {
        images.removeAll(keepingCapacity: false);
        searchBar.resignFirstResponder()
        searchBar.text = ""
        collectionView.reloadData()
        self.title = "Search in Flickr"
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        
        searchBar.resignFirstResponder()
                performSearchWithText(searchText: searchBar.text!)

    }
    
    
}
