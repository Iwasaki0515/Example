
import UIKit

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

class ColorSwitchViewController: UIViewController {

    
    var opponentNumber:Int?
    var selfNumber:Int?
    var turn:Int = 1
    
    var treasurePoint:Int = 0
    var treasureCards:[Int] = []
    
    var selfPoint:Int = 0
    var opponentPoint:Int = 0
    
    @IBAction func startGame(_ sender: UIButton) {
        
    
        sender.isEnabled = false
        
        self.treasureCards = [1,2,3,4,5].shuffled()
        self.updateDisplay()
        colorService.send(self.treasureCards)
    }
    
    @IBOutlet weak var opponentPointLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    @IBOutlet weak var connectionsLabel: UILabel!

    let colorService = ColorServiceManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        colorService.delegate = self
    }

    @IBOutlet var treasure: [UILabel]!
    
    @IBOutlet var opHanded: [UILabel]!
    

    @IBAction func one(_ sender: UIButton) {
        if selfNumber != nil{ return }
        self.selfNumber = 1
        colorService.sendNumber(1)
        advanceGame()
        sender.isEnabled = false
    }
    
    @IBAction func two(_ sender: UIButton) {
        if selfNumber != nil{ return }
        self.selfNumber = 2
        colorService.sendNumber(2)
        advanceGame()
        sender.isEnabled = false
    }

    @IBAction func three(_ sender: UIButton) {
        if selfNumber != nil{ return }
        self.selfNumber = 3
        colorService.sendNumber(3)
        advanceGame()
        sender.isEnabled = false
    }
    
    @IBAction func four(_ sender: UIButton) {
        if selfNumber != nil{ return }
        self.selfNumber = 4
        colorService.sendNumber(4)
        advanceGame()
        sender.isEnabled = false
    }

    @IBAction func five(_ sender: UIButton) {
        if selfNumber != nil{ return }
        self.selfNumber = 5
        colorService.sendNumber(5)
        advanceGame()
        sender.isEnabled = false
    }

    func advanceGame(){

        guard
            let me = selfNumber,
            let op = opponentNumber else{
                return
        }
        treasurePoint += treasureCards[turn - 1]
        if me > op{
            selfPoint += treasurePoint
            treasurePoint = 0
            treasure[turn-1].backgroundColor = UIColor.red
        }else if op > me{
            opponentPoint += treasurePoint
            treasurePoint = 0
        }else{
            treasure[turn-1].backgroundColor = UIColor.yellow
            
        }
        opHanded[turn - 1].text = "\(op)"
        
        selfNumber = nil
        opponentNumber = nil

        turn += 1
        updateDisplay()
    }

    func updateDisplay(){
        OperationQueue.main.addOperation {
            
            self.opponentPointLabel.text = "\(self.opponentPoint)"
            self.pointLabel.text = "\(self.selfPoint)"
            if self.treasureCards.count > 0{
                for num in 0...4{
                    print("\(self.treasureCards[num])")
                    self.treasure[num].text = "\(self.treasureCards[num])"
                }
            }
        }
    }

}

extension ColorSwitchViewController : ColorServiceManagerDelegate {

    func connectedDevicesChanged(_ manager: ColorServiceManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
            self.updateDisplay()
        }
    }

    func initGame(_ manager: ColorServiceManager, numbers:[Int]) {
        treasureCards = numbers
    }

    func colorChanged(_ manager: ColorServiceManager, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "red":
                print("###")
            case "yellow":
                print("###")
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
    
    func numberSelected(_ manager : ColorServiceManager, number: Int){
        OperationQueue.main.addOperation {

            self.opponentNumber = number
            self.advanceGame()

        }
        
    }
    
    func gameInit(_ manager : ColorServiceManager, numbers: [Int]){
        self.treasureCards = numbers
        updateDisplay()
        
    }


}

