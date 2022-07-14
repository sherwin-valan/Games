import Foundation
import Scenes
import Igis

class tictactoe : RenderableEntity, EntityMouseClickHandler {
    static var boxes : Array<Character> = [" "," "," "," "," "," "," "," "," "]
    var winningCombinations = [[Int]]() //to create a two-dimensional array

    static var isGameOver : Bool = false
    var isGameDraw : Bool = true
    
    static var currentMove : Int = 0
    static var boxNumber : Int = 0

    let backgroundPic : Image
    let tie : Image

    init(){
        winningCombinations  =   [[0, 1, 2], [3, 4, 5], [6, 7, 8],
                                  [0, 3, 6], [1, 4, 7], [2, 5, 8],
                                  [0, 4, 8], [2, 4, 6]]
        guard let backgroundPicURL = URL(string:"https://wallpaperaccess.com/full/1151553.jpg") else {
            fatalError("Failed to create URL for Background")
        }
        backgroundPic = Image(sourceURL:backgroundPicURL)

        guard let tieURL = URL(string:"https://www.collinsdictionary.com/images/full/tie_171498722_1000.jpg") else {
            fatalError("Failed to create URL for Tie")
        }
        tie = Image(sourceURL:tieURL)
        
        super.init(name: "tictactoe")
    }
    
    override func setup(canvasSize:Size, canvas:Canvas) {
        dispatcher.registerEntityMouseClickHandler(handler:self)
        canvas.setup(backgroundPic)
        canvas.setup(tie)
    }

    override func teardown() {
        dispatcher.unregisterEntityMouseClickHandler(handler:self)
    }
    
    func onEntityMouseClick(globalLocation: Point) {
        if (globalLocation.x >= 100 && globalLocation.x <= 400) && (globalLocation.y >= 100 && globalLocation.y <= 400){
            tictactoe.boxNumber = ((globalLocation.x-99)/100) + ((globalLocation.y-99)/100)*3
            if tictactoe.boxes[tictactoe.boxNumber] == " "{
                tictactoe.currentMove += 1
            }
        }
    }

    override func render(canvas:Canvas) {
        if tictactoe.isGameOver == true{
            return 
        }

        if tictactoe.currentMove == 0{
            if backgroundPic.isReady {
                backgroundPic.renderMode = .destinationRect(Rect(topLeft:Point(x:0, y:0), size:Size(width:1500, height:800)))
                canvas.render(backgroundPic)
            }
        }
        
        for i in 0...3{
            let horizontalLines = Lines(from:Point(x:100, y:100 + (i * 100)), to:Point(x:400, y:100 + (i * 100)))
            let verticalLines = Lines(from:Point(x:100 + (i * 100), y:100), to:Point(x:100 + (i * 100), y:400 ))
            let strokeStyleForOutline = StrokeStyle(color:Color(.red))
            let lineWidthForOutline = LineWidth(width:8) 
            canvas.render(strokeStyleForOutline, lineWidthForOutline, horizontalLines, verticalLines)
        }
        
        
        let xPos : Int = 110 + ((tictactoe.boxNumber % 3) * 100)
        let yPos : Int = 110 + ((tictactoe.boxNumber / 3) * 100)
        
        if tictactoe.currentMove > 0{
            if tictactoe.currentMove % 2 == 1{
                let lines1 = Lines(from:Point(x:xPos, y:yPos), to:Point(x:xPos + 80, y:yPos + 80))
                let lines2 = Lines(from:Point(x:xPos, y:yPos + 80), to:Point(x:xPos + 80, y:yPos))
                let strokeStyleForX = StrokeStyle(color:Color(.red))
                let lineWidthForX = LineWidth(width:8) 
                canvas.render(strokeStyleForX, lineWidthForX, lines1, lines2)
                tictactoe.boxes[tictactoe.boxNumber] = "X"
            }
            else {
                let circle = Ellipse(center:Point(x:xPos + 40, y:yPos + 40), radiusX:42, radiusY:42)
                let strokeStyleForO = StrokeStyle(color:Color(.white))
                let lineWidthForO = LineWidth(width:8) 
                canvas.render(strokeStyleForO, lineWidthForO, circle)
                tictactoe.boxes[tictactoe.boxNumber] = "O"
            }
            
            for i in 0 ... 7{
                var xWon : Bool = true
                var oWon : Bool = true
                
                for j in 0 ... 2{
                    print("\(winningCombinations[i][j])")
                    if xWon == true && tictactoe.boxes[winningCombinations[i][j]] != "X"{
                        xWon = false
                    }
                    if oWon == true && tictactoe.boxes[winningCombinations[i][j]] != "O"{
                        oWon = false
                    }        
                }
                
                if xWon == true{
                    isGameDraw = false
                    tictactoe.isGameOver = true
                    print("X is Winner")
                    print(" xwon - \(tictactoe.currentMove)")   
                    let text = Text(location:Point(x:500, y:500), text:"X won the game!")
                    text.font = "60pt Arial"
                    canvas.render(FillStyle(color:Color(.red)))
                    canvas.render(text)                    
                    break
                }
                else if oWon == true{
                    isGameDraw = false    
                    tictactoe.isGameOver = true
                    print("O is Winner")
                    print(" owon - \(tictactoe.currentMove)") 
                    let text = Text(location:Point(x:500, y:500), text:"O won the game!")
                    text.font = "60pt Arial"
                    canvas.render(FillStyle(color:Color(.red)))
                    canvas.render(text)
                    break
                }
            }
            if tictactoe.currentMove == 9 && isGameDraw == true{
                if tie.isReady {
                    tie.renderMode = .destinationRect(Rect(topLeft:Point(x:900, y:200), size:Size(width:200, height:250)))
                    canvas.render(tie)
                }
                tictactoe.isGameOver = true 
                print(" draw - \(tictactoe.currentMove)") 
                print(tictactoe.currentMove)   
                let text = Text(location:Point(x:500, y:500), text:"Neither won the game. It was a tie!")
                text.font = "40pt Arial"
                canvas.render(FillStyle(color:Color(.red)))
                canvas.render(text)
            }
        } 
    }
    override func boundingRect() -> Rect {
        return Rect(size: Size(width: Int.max, height: Int.max))
    }
}

