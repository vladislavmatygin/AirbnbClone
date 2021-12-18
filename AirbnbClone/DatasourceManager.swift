import UIKit
import CoreData

class DataSourceManager {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let shared = DataSourceManager()

    func saveLike(viewModel: DetailedViewModel) {
        let context = appDelegate.persistentContainer.viewContext
        
        if let like = getLike(context: context, floorId: viewModel.floor.id) {
            print(like)
        } else {
            guard let entity = NSEntityDescription.entity(forEntityName: "ToDoLikeItem", in: context),
                  let item = NSManagedObject(entity: entity, insertInto: context) as? ToDoLikeItem
            else { return }
            
            let floor = viewModel.floor
            item.id = UUID()
            item.floorId = floor.id
            item.isLiked = NSNumber(value: floor.isLiked)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteLike(viewModel: DetailedViewModel) {
        let context = appDelegate.persistentContainer.viewContext

        guard let like = getLike(context: context, floorId: viewModel.floor.id) else { return }
        context.delete(like)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getLike(context: NSManagedObjectContext, floorId: String) -> ToDoLikeItem? {
        let request: NSFetchRequest<ToDoLikeItem> = ToDoLikeItem.fetchRequest()
        do {
            let likes = try context.fetch(request) as [ToDoLikeItem]
            guard let like = likes.filter { $0.floorId == floorId }.first
            else { return nil }

            return like
        } catch  {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
