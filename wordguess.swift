import Scenes
import Igis

class wordguess : RenderableEntity, KeyDownHandler{    

    static var word : String = ""
    static var isGameOver : Bool = false
    static var isGameLost : Bool = false
    
    var attemptsLeft : Int = 5
    var clearWord : Bool = false
    var clearAttempt : Bool = false
    var isEnter : Bool = false
    
    init(){
        wordguess.word = ""
        super.init(name:"wordguess")
    }
     
    override func setup(canvasSize: Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)
    }
    
    override func teardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
    
    func clearWord(canvas:Canvas) {
        let wordRect = Rect(topLeft:Point(x:900, y:350), size:Size(width:360, height:200))
        let wordClearRectangle = Rectangle(rect:wordRect, fillMode:.clear)
        canvas.render(wordClearRectangle)
    }

    func clearAttempt(canvas:Canvas) {
        let attemptRect = Rect(topLeft:Point(x:1210, y:250), size:Size(width:50, height:100))
        let attemptClearRectangle = Rectangle(rect:attemptRect, fillMode:.clear)
        canvas.render(attemptClearRectangle)
    }
    
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool){
        print(key)
        if key == "Backspace"{
            wordguess.word = ""
            clearWord = true
        } else if key == "Enter"{
            isEnter = true
        } else {
            wordguess.word += key 
        }
    }

    override func render(canvas:Canvas) {
        if wordguess.isGameOver == false{
            clearWord(canvas:canvas) 
            let text = Text(location:Point(x:1100, y:400), text:"\(wordguess.word)")
            text.font = "30pt Arial"
            canvas.render(FillStyle(color:Color(.black)))
            canvas.render(text)            
        }
        if isEnter == true{
            isEnter = false
            if wordguess.word == wordprint.chosenWord{
                wordguess.isGameOver = true
                let gameOverText = Text(location:Point(x:1100, y:200), text:"You found the word!")
                gameOverText.font = "30pt Arial"
                canvas.render(FillStyle(color:Color(.green)))
                canvas.render(gameOverText)
            } else {
                print(" wordprint - \(wordprint.chosenWord)")
                print("wordguess - \(wordguess.word)")
                wordguess.word = ""
                clearWord = true
                clearAttempt(canvas:canvas)
                attemptsLeft -= 1
                print(attemptsLeft)
            }
        }
                       
        let attemptsLeftText = Text(location:Point(x:1100, y:300), text:"Attempts left - \(attemptsLeft)")
        attemptsLeftText.font = "30pt Arial"
        canvas.render(FillStyle(color:Color(.black)))
        canvas.render(attemptsLeftText)
                
        if attemptsLeft == 0{
            wordguess.isGameOver = true
            wordguess.isGameLost = true
            let gameLostText = Text(location:Point(x:1100, y:200), text:"You couldn't find the word!")
            gameLostText.font = "20pt Arial"
            canvas.render(FillStyle(color:Color(.red)))
            canvas.render(gameLostText)
        }
    }
}
