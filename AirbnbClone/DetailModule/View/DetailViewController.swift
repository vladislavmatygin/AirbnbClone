import UIKit
import CloudKit

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

        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        updateRightBarButtonItems()
    }
    
    private func setup() {
        changeDateButton.layer.cornerRadius = 12
        config()
    }
    
    //MARK: display data from model
    private func config() {
        guard let viewModel = viewModel else { return }

        floorImage.image = UIImage(named: viewModel.floor.imageName)
        nameLabel.text = viewModel.floor.name
        hostLabel.text = viewModel.floor.minimalizedName
    }
    
    private func updateRightBarButtonItems() {
        guard let viewModel = viewModel else {
            return
        }

        let color = viewModel.floor.isLiked ? UIColor.red : UIColor.black
        let image = UIImage(named: "like")
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: image,
                            style: .done,
                            target: self,
                            action: #selector(like(_:))),
            UIBarButtonItem(image: UIImage(named:"share"),
                            style: .done,
                            target: self,
                            action: #selector(share(sender:)))
        ]
        
        navigationItem.rightBarButtonItems?.first?.tintColor = color
    }

    private func setupNavigationBar() {
        guard let navController = navigationController else { return }
        
        navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.isTranslucent = true
    }
    
    //MARK: add action for like
    @objc private func like(_ sender: UIBarButtonItem) {
        guard let viewModel = viewModel else { return }

        sender.isSelected = !sender.isSelected
        sender.tintColor = .clear
        
        if !viewModel.floor.isLiked {
            viewModel.floor.isLiked = true
            
            updateRightBarButtonItems()
            DataSourceManager.shared.saveLike(viewModel: viewModel)
        } else {
            viewModel.floor.isLiked = false
            updateRightBarButtonItems()
            DataSourceManager.shared.deleteLike(viewModel: viewModel)
        }
    }
    
    //MARK: add action for share
    @objc private func share(sender: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndImageContext()

        if let viewModel = viewModel, let myImage = UIImage(named: viewModel.floor.imageName) {
            let objectsToShare = [viewModel.floor.name, myImage] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            activityVC.popoverPresentationController?.sourceView = sender

            self.present(activityVC, animated: true, completion: nil)
        }
    }
}
