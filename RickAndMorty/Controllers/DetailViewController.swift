//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Александр Жуков on 24.10.2021.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
    
    var detailCharacters: Characters?
    var detailResults: Results?
    
    @IBOutlet weak var detailsCharacterImage: UIImageView!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsLocationLabel: UILabel!
    @IBOutlet weak var detailsGenderLabel: UILabel!
    @IBOutlet weak var detailsStatusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsCharacterImage.af.setImage(withURL: URL(string: detailResults!.image)!, placeholderImage: UIImage(named: "placeholder")!)
        detailsNameLabel.text = detailResults?.name
        detailsLocationLabel.text = "Location: \(detailResults!.location.name)"
        detailsGenderLabel.text = "Gender: \(detailResults!.gender)"
        detailsStatusLabel.text = "Created: \(detailResults!.status)"
    }
}
