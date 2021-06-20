//
//  FeedTableViewCell.swift
//  Blockers
//
//  Created by Rohit on 19/06/21.
//

import UIKit

class FeedTableViewModel{
    let titile: String
    let subtitle: String
    let imageURL: URL?
    var ImageData: Data?
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?
        
    ){
        self.titile = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        
    }
}

class FeedTableViewCell: UITableViewCell {
    static let identifier = "FeedCell"
    
    private let FeedTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 25 ,   weight: .medium)
        return label
    }()
    private let FeedSubTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15 ,   weight: .medium)
        label.numberOfLines = 2
        return label
    }()
  
    private let FeedImadeView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.5
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(FeedImadeView)
        contentView.addSubview(FeedTitleLabel)
        contentView.addSubview(FeedSubTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
     override func layoutSubviews() {
        super.layoutSubviews()
        FeedTitleLabel.frame = CGRect(x: 15,
                                      y: 140,
                                      width: contentView.frame.size.width - 40 ,
                                      height: contentView.frame.size.height/2)
        FeedSubTitleLabel.frame = CGRect(x: 20,
                                      y: 230,
                                      width: contentView.frame.size.width - 65,
                                      height: contentView.frame.size.height/3)
        FeedImadeView.frame = CGRect(x: 10 , y: 10, width: contentView.frame.size.width - 20, height: contentView.frame.size.height - 25)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        FeedTitleLabel.text = nil
        FeedSubTitleLabel.text = nil
        FeedImadeView.image = nil
    }
    
    
    
    func configure(with viewModel: FeedTableViewModel ){
        
        FeedTitleLabel.text = viewModel.titile
        FeedSubTitleLabel.text = viewModel.subtitle
        
        if let data = viewModel.ImageData {
            FeedImadeView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url){ [weak self] data, _ , error in
                guard let data = data ,error == nil else {
                    return
                }
               
                DispatchQueue.main.async {
                    viewModel.ImageData = data
                    
                    self?.imageView?.alpha = 0.6
                    
                }
            }.resume()
            
            
        }
    }
    
    
    
    

}
