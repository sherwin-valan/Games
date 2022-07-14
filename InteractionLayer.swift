import Igis
import Scenes
import ScenesControls
  /*
     This class is responsible for the interaction Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */

class InteractionLayer : Layer{
    private static let Tictactoe = tictactoe()
    private static let Pictionary = pictionary()
    private static let Wordguess = wordguess()
    private static let Wordprint = wordprint()
    private static let background = Background()
    
    private static var drawer : Bool = false
    var guesser : Bool
 
    init() {
        // Using a meaningful name can be helpful for debugging
        if InteractionLayer.drawer == false{
            InteractionLayer.drawer = true
            guesser = false
        } else {
            guesser = true
        }
        super.init(name:"Interaction")
    
        // We insert our RenderableEntities in the constructor                
        let tictactoeButton = Button(name: "Tictactoe", labelString: "Tic-Tac-Toe", topLeft: Point(x: 20, y: 20))
        tictactoeButton.clickHandler = onTictactoeButtonClickHandler
        insert(entity: tictactoeButton, at: .back)
        
        let pictionaryButton = Button(name: "Pictionary", labelString: "Pictionary", topLeft: Point(x: 20, y: 50))
        pictionaryButton.clickHandler = onPictionaryButtonClickHandler
        insert(entity: pictionaryButton, at: .back)
    
        //erase drawings
        let eraseButton = Button(name: "Erase", labelString: "Erase", topLeft: Point(x: 200, y: 20))
        eraseButton.clickHandler = onEraseButtonClickHandler
        insert(entity: eraseButton, at: .back)
          //colors
        let blueButton = Button(name: "Blue", labelString: "Blue", topLeft: Point(x: 200, y: 50))
        blueButton.clickHandler = onBlueButtonClickHandler
        insert(entity: blueButton, at: .back)
        
        let redButton = Button(name: "Red", labelString: "Red", topLeft: Point(x: 300, y: 20))
        redButton.clickHandler = onRedButtonClickHandler
        insert(entity:redButton, at: .back)
        
        let greenButton = Button(name: "Green", labelString: "Green", topLeft: Point(x: 300, y: 50))
        greenButton.clickHandler = onGreenButtonClickHandler
        insert(entity: greenButton, at: .back)
        
        let yellowButton = Button(name: "Yellow", labelString: "Yellow", topLeft: Point(x: 400, y: 20))
        yellowButton.clickHandler = onYellowButtonClickHandler
        insert(entity: yellowButton, at: .back)

        let blackButton = Button(name: "Black", labelString: "Black", topLeft: Point(x: 400, y: 50))
        blackButton.clickHandler = onBlackButtonClickHandler
        insert(entity: blackButton, at: .back)
    }
    func onTictactoeButtonClickHandler(control: Control, localLocation: Point) {
        insert(entity:InteractionLayer.Tictactoe, at:.front)  
    }    
    func onPictionaryButtonClickHandler(control: Control, localLocation: Point) {
        if wordguess.isGameOver == false{
            insert(entity:InteractionLayer.Pictionary, at:.back)
            if guesser == false{
                insert(entity:InteractionLayer.Wordprint, at:.front)
            }
            if guesser == true{
                insert(entity:InteractionLayer.Wordguess, at:.front)
            }
        }
    }
    func onEraseButtonClickHandler(control: Control, localLocation: Point) {
        InteractionLayer.Pictionary.eraseDrawings()
    }
    func onBlueButtonClickHandler(control: Control, localLocation: Point) {
        InteractionLayer.Pictionary.changePenColorToBlue()
    }
    func onRedButtonClickHandler(control: Control, localLocation: Point) {
        InteractionLayer.Pictionary.changePenColorToRed() 
    }
    func onGreenButtonClickHandler(control: Control, localLocation: Point) {
        InteractionLayer.Pictionary.changePenColorToGreen() 
    }
    func onYellowButtonClickHandler(control: Control, localLocation: Point) {
        InteractionLayer.Pictionary.changePenColorToYellow() 
    }
    func onBlackButtonClickHandler(control: Control, localLocation: Point) {
        InteractionLayer.Pictionary.changePenColorToBlack() 
    }
}

