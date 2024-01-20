//
//  EscapeRooViewController.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 20/01/2024.
//

import UIKit
import SDWebImage

class EscapeRoomViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: EscapeRoomViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up UICollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCellId")

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }

        viewModel?.EscapeMovieListView.bindAndFire { [weak self] success in
            if success {
                self?.collectionView.reloadData()
            }
        }
    }
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getMovieCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCellId", for: indexPath) as? CustomCollectionViewCell else {
            fatalError("Unable to dequeue reusable cell")
        }
        
        if let data = viewModel?.getMovie(index: indexPath.row) {
            cell.titleLabel.text = data.title
            
            // Safely set the image only if the URL is valid
            if let url = URL(string: data.imageUrl) {
                cell.imageView?.sd_setImage(with: url, completed: nil)
            }
        } else {
            // Handle the case where data is nil (optional is not set)
            cell.titleLabel.text = "No Title"
        }
        
        return cell
    }

    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 20) / 2 // Assuming 10pt spacing on each side
        let cellHeight: CGFloat = 450
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
