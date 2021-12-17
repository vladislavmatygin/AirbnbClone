import UIKit

class DetailViewController: UIViewController {
    var viewModel: DetailedViewModel?
    
    @IBOutlet private var indicatorViewCollection: [UIView]!
    @IBOutlet private var floorImage: UIImageView!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var hostLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var locationDescriptionLabel: UILabel!
    @IBOutlet private var communicationLabel: UIStackView!
    @IBOutlet private var communicationDescriptionLabel: UILabel!
    @IBOutlet private var actionView: UIView!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var costLabel: UILabel!
    @IBOutlet private var changeDateButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Make the navigation bar background clear
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        configureItems()
    }
    
    private func setup() {
        changeDateButton.layer.cornerRadius = 12
        config()
    }
    
    private func config() {
        guard let viewModel = viewModel else { return }

        floorImage.image = UIImage(named: viewModel.floor.imageName)
        nameLabel.text = viewModel.floor.name
        hostLabel.text = viewModel.floor.minimalizedName
    }
    
    private func configureItems() {
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "like"),
                            style: .done,
                            target: self,
                            action: nil),
            UIBarButtonItem(image: UIImage(named:"share"),
                            style: .done,
                            target: self,
                            action: #selector(share(sender:)))
        ]
    }

    private func setupNavigationBar() {
        guard let navController = navigationController else { return }
        
        navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.isTranslucent = true
    }
    
    @objc func share(sender: UIView){
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let textToShare = "Check out my app"

        if let myImage = UIImage(named: "home") {
            let objectsToShare = [textToShare, myImage] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            activityVC.popoverPresentationController?.sourceView = sender

            self.present(activityVC, animated: true, completion: nil)
        }
    }
}
