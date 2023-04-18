//
//  InformationFilterCell.swift
//  FishingWeather
//
//  Created by Александр Янчик on 5.04.23.
//

import UIKit

class InformationFilterCell: UICollectionViewCell {
    
    static var id = String(describing: InformationFilterCell.self)
    
    lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageViewWeather: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
