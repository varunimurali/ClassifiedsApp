//
//  ViewController.swift
//  jsonPractice1
//
//  Created by Varuni R on 1/23/21.
//

import UIKit


class ViewController: UIViewController {
    
    private var productList: [Products]?
    var results : Results!
    var imageLoader = ImageLoader()
    private var resultsViewModel = ResultsViewModel()
    private var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var collectionview: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "PRODUCTS"
        collectionview.dataSource = self
        collectionview.delegate = self
    
//      let myurl = URL(string:"https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer")
//
//
//        URLSession.shared.dataTask( with: myurl!) { ( data, response, error) in
//        if error == nil {
//
//            do{
//
//                self.results = try JSONDecoder().decode(Results.self, from: data!)
//
//           print("Results..\(self.results.results)")
//        print("Results..\(self.results.results.count)")
//
//
//
//
//            }
//            catch{
//                print("parse error")
//            }
//
//            DispatchQueue.main.async{
//
//                self.collectionview.reloadData()
//            }
//        }
//
        
//    }.resume()
        self.getProductsList()

}
    private func addActivityIndicatorView() {
        DispatchQueue.main.async {
            self.activityIndicator.style = .large
            self.activityIndicator.center = self.view.center
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
       }
       
       private func removeActivityIndicator() {
        DispatchQueue.main.async {
           self.activityIndicator.stopAnimating()
           self.activityIndicator.removeFromSuperview()
        }
       }
    
    func getProductsList() {
        self.addActivityIndicatorView()
        self.resultsViewModel.fetchProductsList() { [weak self] (completed) in
            self?.removeActivityIndicator()
                       if completed {
                           self?.productList = self?.resultsViewModel.products
                           DispatchQueue.main.async {
                               self?.collectionview.reloadData()
                           }
                       }
                       DispatchQueue.main.async {
                           //Activityindicator
                          // self?.removeActivityIndicator()
                       }
                   }
    }
    
   
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.productList?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.nameLb.text = self.productList?[indexPath.row].name
        cell.priceLb.text = self.productList?[indexPath.row].price
      
        cell.carImageView.contentMode = .scaleAspectFill
        
        if let completeLink =  self.productList?[indexPath.row].image_urls_thumbnails[0]{
       
        imageLoader.obtainImageWithPath(imagePath: completeLink) { (image: UIImage) in
            cell.carImageView.image = image
        }
        }
       
        
        return cell
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController")  as? ProductViewController
        vc?.product = self.productList![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        
       
        
       
    }
    
}
