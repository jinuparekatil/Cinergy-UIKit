//
//  DateCell.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 21/01/2024.
//

import UIKit

class DateCell: UICollectionViewCell {

    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func configure(with dateModel: DateModel) {
        weekLabel.text = dateModel.title
        // Customize appearance as needed
    }
}
