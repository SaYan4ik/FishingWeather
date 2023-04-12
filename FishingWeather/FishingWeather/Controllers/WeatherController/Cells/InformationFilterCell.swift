//
//  InformationFilterCell.swift
//  FishingWeather
//
//  Created by Александр Янчик on 5.04.23.
//

import UIKit

class InformationFilterCell: UICollectionViewCell {
    
    lazy var weatherLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {

    }
    
    private func layoutTitleLabel() {

    }
    
}
