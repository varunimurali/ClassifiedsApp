//
//  ProductViewController.swift
//  jsonPractice1
//
//  Created by Varuni R on 2/22/21.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productImageView : UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var created_at: UILabel!
    
    var product : Products!
    var imageLoader = ImageLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        name.text = product.name
        price.text = product.price
        created_at.text = product.created_at
        
        imageLoader.obtainImageWithPath(imagePath: (product?.image_urls[0])!) { (image: UIImage) in
            self.productImageView.image = image
        }
    }
    

   

}
