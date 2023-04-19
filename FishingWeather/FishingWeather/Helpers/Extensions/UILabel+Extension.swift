//
//  UILabel+Extension.swift
//  FishingWeather
//
//  Created by Александр Янчик on 19.04.23.
//

import UIKit

extension UILabel {
    
    func addImageLabel(image: UIImage?) {
        let attachment = NSTextAttachment()
        attachment.image = image
        let attachmentString = NSAttributedString(attachment: attachment)
        
        let string = NSMutableAttributedString(string: self.text ?? "No text")
        string.append(attachmentString)
        self.attributedText = string
    }
    
    func addImageTest(image: UIImage?) {
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        // Set bound to reposition
        let imageOffsetY: CGFloat = -5.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 30, height: 30)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: " ")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: self.text ?? "No description")
        completeText.append(textAfterIcon)
        self.textAlignment = .center
        self.attributedText = completeText
    }
}



