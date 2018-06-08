//
//  TableViewCell.swift
//  NewsFeed
//
//  Created by steig hallquist on 6/8/18.
//  Copyright © 2018 steig hallquist. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var newsContent: DataFeed.Content? {
        didSet {
            guard let image = newsContent?.images.first else { return }
            
            heightConstraint.constant = newsImageView.bounds.width * CGFloat(image.originalHeight) / CGFloat(image.originalWidth)
            titleLabel.text = newsContent?.title
            
            retrieveImage(urlString: image.originalUrl) { (image, error) in
                self.newsImageView.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        newsImageView.image = nil
    }

    func retrieveImage(urlString:String?, handler:@escaping (_ image:UIImage?,_ error:Error?)->Void) {
        guard let urlStr = urlString, let url = URL(string: urlStr) else {
            handler(nil,nil)
            return
        }
        var anImage:UIImage?
        var anError:Error?
        
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: url)
                anImage = UIImage(data: imageData)
            } catch {
                anError = error
            }
            
            DispatchQueue.main.async {
                handler(anImage, anError)
            }
        }
    }
}
