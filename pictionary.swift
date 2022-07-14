import Scenes
import Igis

class pictionary : RenderableEntity, EntityMouseClickHandler, MouseMoveHandler{

    let pen = Ellipse(center:Point(x:0, y:0), radiusX:5, radiusY:5, fillMode:.stroke)
    var penLineWidth = LineWidth(width:10)

    let colors : [Color] = [(Color(.black)), (Color(.white)), (Color(.blue)), (Color(.red)), (Color(.green)), (Color(.yellow))]
    var currentColor : Int = 0
    
    var isMouseClick : Bool = true
    var isErase : Bool = false

    init(){
        super.init(name: "pictionary")
    }
    
    override func setup(canvasSize:Size, canvas:Canvas) {
        // ... other code is here ...
        dispatcher.registerEntityMouseClickHandler(handler:self)
        dispatcher.registerMouseMoveHandler(handler:self)        
    }

    override func teardown() {
        dispatcher.unregisterEntityMouseClickHandler(handler:self)
        dispatcher.unregisterMouseMoveHandler(handler:self)
    }
    
    func onMouseMove(globalLocation: Point, movement:Point) {
        pen.center = globalLocation
    }

    func onEntityMouseClick(globalLocation: Point) {
        if isMouseClick == true{
            isMouseClick = false
        } else if isMouseClick == false{
            isMouseClick = true
        }
        pen.center = globalLocation
    }

    override func render(canvas:Canvas) {
        //Borders
        let topClearRect = Rect(topLeft:Point(x:0, y:0), size:Size(width:Int.max, height:100))
        let topClearRectangle = Rectangle(rect:topClearRect, fillMode:.fill)
        let fillStyleForBorder = FillStyle(color:Color(.blue))
        canvas.render(fillStyleForBorder, topClearRectangle)

        let bottomClearRect = Rect(topLeft:Point(x:100, y:600), size:Size(width:Int.max, height:1000))
        let bottomClearRectangle = Rectangle(rect:bottomClearRect, fillMode:.fill)
        canvas.render(fillStyleForBorder, bottomClearRectangle)
        
        let rightClearRect = Rect(topLeft:Point(x:800, y:100), size:Size(width:100, height:Int.max))
        let rightClearRectangle = Rectangle(rect:rightClearRect, fillMode:.fill)
        canvas.render(fillStyleForBorder, rightClearRectangle)

        let farRightClearRect = Rect(topLeft:Point(x:1300, y:100), size:Size(width:Int.max, height:Int.max))
        let farRightClearRectangle = Rectangle(rect:farRightClearRect, fillMode:.fill)
        canvas.render(fillStyleForBorder, farRightClearRectangle)
        
        let leftClearRect = Rect(topLeft:Point(x:0, y:100), size:Size(width:100, height:Int.max))
        let leftClearRectangle = Rectangle(rect:leftClearRect, fillMode:.fill)
        canvas.render(fillStyleForBorder, leftClearRectangle)
        
        let borderLine = Rect(topLeft:Point(x:100, y:100), size:Size(width:700, height:500))
        let rectangleForBorderLine = Rectangle(rect:borderLine, fillMode:.stroke)
        let strokeStyleForBorderLine = StrokeStyle(color:Color(.black))
        canvas.render(strokeStyleForBorderLine, rectangleForBorderLine)

        if wordguess.isGameOver == false{
            if isMouseClick == false{
                let penStrokeStyle = StrokeStyle(color:colors[currentColor])
                let penFillStyle = FillStyle(color:colors[currentColor])
                if currentColor == 1{
                    penLineWidth = LineWidth(width:20) 
                } else {
                    penLineWidth = LineWidth(width:10) 
                }
                canvas.render(penStrokeStyle, penFillStyle, penLineWidth, pen)
            }
        }
    }
    
    public func eraseDrawings(){
        currentColor = 1
    }
    
    public func changePenColorToBlue(){
        currentColor = 2
    }
    
    public func changePenColorToRed(){
        currentColor = 3
    }
    
    public func changePenColorToGreen(){
        currentColor = 4
    }
    
    public func changePenColorToYellow(){
        currentColor = 5
    }
    
    public func changePenColorToBlack(){
        currentColor = 0
    }

    override func boundingRect() -> Rect {
        return Rect(size: Size(width: Int.max, height: Int.max))
    }
}
