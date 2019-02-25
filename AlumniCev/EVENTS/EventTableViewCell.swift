import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var imageEventView: UIImageView!
    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var imageTypeEvent: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.typeLbl.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/(-2)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
