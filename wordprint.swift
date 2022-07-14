import Igis
import Scenes

class wordprint: RenderableEntity {

    let wordBank : Array<String> = ["car","hand","flower","fries","donut","ice cream","nose","bird","dolphin","star","crayon","jail","tie","wheel","train","plane","face","soccer","music","phone","sun","shoes","banana","orange","stove","plant"]
    static var chosenWord : String =  ""
   
    init(){
        wordprint.chosenWord = wordBank[Int.random(in: 0 ... wordBank.count-1)]
        super.init(name:"wordprint")
    }
    
    override func render(canvas:Canvas) {
        let randomWord = Text(location:Point(x:1100, y:300), text:"\(wordprint.chosenWord)")
        randomWord.font = "40pt Arial"
        canvas.render(FillStyle(color:Color(.black)))
        canvas.render(randomWord)

        if wordguess.isGameOver == true{
            if wordguess.isGameLost == false{
                let drawerGameOverText = Text(location:Point(x:1100, y:550), text:"Opponent found the word")
                drawerGameOverText.font = "25pt Arial"
                canvas.render(FillStyle(color:Color(.black)))
                canvas.render(drawerGameOverText)
            } else if wordguess.isGameLost == true{
                let drawerGameWonText = Text(location:Point(x:1100, y:550), text:"Opponent couldn't found the word")
                drawerGameWonText.font = "18pt Arial"
                canvas.render(FillStyle(color:Color(.black)))
                canvas.render(drawerGameWonText)
            }
        }
    }
}
