import UIKit

class MainViewController: UIViewController {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var viewModel: MainViewModel?
    
    let customView = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationController()
        updateLikedViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "cell")
    }
    
    private func updateLikedViews() {
        guard let viewModel = viewModel else {
            return
        }

        for index in 0 ... viewModel.floorsArray.count - 1 {
            var floor = viewModel.floorsArray[index]
            let isLiked = DataSourceManager.shared.getLike(context: appDelegate.persistentContainer.viewContext, floorId: floor.id)?.isLiked.boolValue
            floor.isLiked = isLiked ?? false
            viewModel.floorsArray[index] = floor
        }
        
        tableView.reloadData()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    //MARK: add items to Navigation Bar
    private func configureItems() {
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "setting"),
                            style: .done,
                            target: self,
                            action: nil),
            UIBarButtonItem(customView: customView)
        ]
    }
}

//MARK: - Setup TableView
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.config(floor: viewModel.floorsArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }

        let floor = viewModel.floorsArray[indexPath.row]
        let detailedViewModel = DetailedViewModel(floor: floor)
        let viewController = DetailViewController()
        viewController.viewModel = detailedViewModel
        navigationController?.pushViewController(viewController, animated: true)
    }
}
