
import UIKit

protocol CustomLayOutDelegate {
    func hightAndWidthFor(index: Int) -> (widthForCell: CGFloat, heightForCell: CGFloat)
    
}

class NewPhotoViewController: UIViewController, CustomLayOutDelegate {
    
    var myCollectionView: UICollectionView?
    var users = User(userName: "", userImageName: "", userPhotossName: [""])
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let view = UIView()
        
        
        let layout: PhotosCollectionViewLayout = PhotosCollectionViewLayout()
        layout.layOutDelegate = self
        
        let collectionViewFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        myCollectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        myCollectionView?.register(NewPhotoCollectionViewCell.self, forCellWithReuseIdentifier: NewPhotoCollectionViewCell.identifier)
        myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView?.backgroundColor = .white
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        
        view.addSubview(myCollectionView ?? UICollectionView())
        
        self.view = view
        addCinstraints()
        
    }
    
    func addCinstraints(){
        view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        myCollectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        myCollectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        myCollectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        myCollectionView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    }
    
    func hightAndWidthFor(index: Int) -> (widthForCell: CGFloat, heightForCell: CGFloat) {
        let image = UIImage(named: users.userPhothosName[index])
        let h = image?.size.height
        let w = image?.size.width
        guard let imagewidth = w else { return (1, 1)}
        guard let imageHeight = h else { return (1, 1)}
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        
        if screenWidth <= imagewidth {
            let mult = (imagewidth / screenWidth) + 0.3
            return (imagewidth / mult, imageHeight / mult )
            
        } else {
            return (imagewidth, imageHeight)
        }
    }
}


extension NewPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.userPhothosName.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! NewPhotoCollectionViewCell
        myCell.photoImageView.image = UIImage(named: users.userPhothosName[indexPath.row])
        myCell.photoImageView.isUserInteractionEnabled = true
        myCell.likeControlItem.isUserInteractionEnabled = true
        
        return myCell 
    }
    
}
