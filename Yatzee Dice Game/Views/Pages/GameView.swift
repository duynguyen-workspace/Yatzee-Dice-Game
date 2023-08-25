//
//  GameView.swift
//  Yatzee Dice Game
//
//  Created by Nguyễn Anh Duy on 21/08/2023.
//

import SwiftUI

struct GameView: View {
    // MARK: PROPERTIES
    let dices = ["dice-face-1","dice-face-2","dice-face-3","dice-face-4","dice-face-5","dice-face-6", ""] // Array stores a list of dice faces
    
    @State private var reels = [6, 6, 6, 6, 6] // Array stores a list of playing reels
    
    @State private var locks: [Bool] = [false,false,false,false,false] // Array stores the lock status of each dice reel
    
    // ALL STATE VARIABLES FOR EACH DICE VALUES
    @State private var dicesValue = ["ones": 1, "twos": 2, "threes": 3,"fours": 4,"fives": 5,"sixs": 6]
    
    // ALL STATE VARIABLES FOR EACH OPTION VALUES
    @State private var optionsSavedValue = ["ones": 0, "twos": 0, "threes": 0,"fours": 0,"fives": 0,"sixs": 0,"3x": 0,"twoPairs": 0,"fullHouse": 0,"small": 0,"large": 0,"5x": 0,"all": 0]
    
    // ALL STATE VARIABLES FOR EACH OPTION VALUES
    @State private var optionsValue = ["ones": 0, "twos": 0, "threes": 0,"fours": 0,"fives": 0,"sixs": 0,"3x": 0,"twoPairs": 0,"fullHouse": 0,"small": 0,"large": 0,"5x": 0,"all": 0]
    
    // ALL STATE VARIABLES FOR EACH OPTION SELECTED STATUS
    @State private var optionsSelected = ["ones": false, "twos": false, "threes": false,"fours": false,"fives": false,"sixs": false,"3x": false,"twoPairs": false,"fullHouse": false,"small": false,"large": false,"5x": false,"all": false]
    
    // ALL STATE VARIABLES FOR EACH OPTION PLAYED STATUS
    @State private var optionsHasPlayed = ["ones": false, "twos": false, "threes": false,"fours": false,"fives": false,"sixs": false,"3x": false,"twoPairs": false,"fullHouse": false,"small": false,"large": false,"5x": false,"all": false]
    
    @State private var showGameOverMessage = false
    @State private var showGameWinMessage = false
    @State private var showBonus = false
    @State private var newHighScoreFound = false
    
    @State private var isAnyOptionSelected = false
    @State private var canRoll = true
    @State private var canPlay = false
    @State private var round = 1
    @State private var scoreToBeat = 250
    @State private var currentScore = 0
    @State private var bonus = 0
    @State private var timer = 10
    @State private var reroll = 5
    @AppStorage("highScore") var highScore = 250
    
    let columns = 5 // Number of columns for the grid layout
    @State private var animatingIcon = true // Animation Status
    
    // MARK: - GAME LOGIC
    func play() {
        var optionName = ""
        var addedScore = 0
        for option in optionsSelected {
            if option.value == true {
                optionName = option.key
                break
            }
        }
        print(optionName)
        addedScore = optionsValue[optionName]!
        optionsSavedValue[optionName] = addedScore
        currentScore += addedScore
        optionsHasPlayed[optionName] = true
        optionsSelected[optionName] = false
        isAnyOptionSelected = false
        
        resetLocks()
        resetValues()
        resetReels()
        if showBonus == false {
            calcBonus()
            checkBonus()
        }
    }
    
    // MARK: - RESET ALL
    func resetAll() {
        currentScore = 0
        resetReels()
        resetLocks()
        resetValues()
        resetTurn()
        resetOptionsButton()
        resetHasPlayed()
        resetSavedValues()
        
    }
    
    func resetSavedValues() {
        for k in optionsSavedValue.keys {
            optionsSavedValue[k] = 0
        }
    }
    
    func resetHasPlayed() {
        for k in optionsHasPlayed.keys {
            optionsHasPlayed[k] = false
        }
    }
    
    // MARK: - BONUS LOGIC
    func calcBonus() {
        let bonusScore = optionsSavedValue["ones"]! + optionsSavedValue["twos"]! + optionsSavedValue["threes"]! + optionsSavedValue["fours"]! + optionsSavedValue["fives"]! + optionsSavedValue["sixs"]!
        bonus = bonusScore
        
    }
    
    func checkBonus() {
        if bonus >= 63 {
            showBonus = true
            currentScore += 45
            playSound(sound: "bonus", type: "mp3")
        }
    }
    
    
    // MARK: - GAME OVER LOGIC
    func isGameOver() {
        if checkGameFinished() {
            if checkWinning() {
                showGameWinMessage = true
                playSound(sound: "winning", type: "mp3")
            } else {
                showGameOverMessage = true
                playSound(sound: "gameover", type: "mp3")
            }
            if currentScore > highScore {
                setNewHighScore()
                playSound(sound: "highscore", type: "mp3")
                newHighScoreFound = true
            }
            

        }
    }
    
    // MARK: - CHECKING IF GAME IS FINISHED
    func checkGameFinished() -> Bool {
        for hasPlayed in optionsHasPlayed {
            if hasPlayed.value == false {
                return false
            }
        }
        return true
    }
    
    // MARK: - CHECKING WINNING LOGIC
    func checkWinning() -> Bool {
        if currentScore >= scoreToBeat {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - CHECKING IF AN OPTION IS SELECTED
    func checkOptionSelected() {
        for option in optionsSelected {
            if option.value == true {
                // Check if that option is played
                if optionsHasPlayed[option.key] == false {
                    isAnyOptionSelected = true
                }
            }
        }
        isAnyOptionSelected = false
    }
    
    // MARK: - RESET REELS
    func resetReels() {
        reels = reels.map ({ $0 * 0 + 6 })
    }
    
    // MARK: - RESET VALUES
    func resetValues() {
        for k in optionsValue.keys {
            optionsValue[k] = 0
        }
    }
    
    // MARK: - RESET LOCKS
    func resetLocks() {
        for i in 0...locks.count-1 {
            locks[i] = false
        }
    }
    
    // MARK: - RESET BUTTON DISABLED
    func resetOptionsButton() {
        for k in optionsSelected.keys {
            optionsSelected[k] = optionsHasPlayed[k]
        }
    }
    
    // MARK: - RESET ROLL TURN
    func resetTurn() {
        reroll = 5
        canRoll = true
        canPlay = false
    }
    
    // MARK: - REROLL LOGIC
    func rerollDices() {
        if reroll > 0 {
            rollDicesWithLocks()
            reroll -= 1
        } else {
            canRoll = false
        }
    }
    
    // MARK: - ROLL DICE LOGIC (WITH LOCKS)
    func rollDicesWithLocks() {
        for i in 0...reels.count-1 {
            if !locks[i] {
                reels[i] = Int.random(in: 0...dices.count-2)
            }
        }
        if !(optionsHasPlayed["ones"]!) {
            optionsValue["ones"] = calcSameDices(option: "ones")
        }
        if !(optionsHasPlayed["twos"]!) {
            optionsValue["twos"] = calcSameDices(option: "twos")
        }
        if !(optionsHasPlayed["threes"]!) {
            optionsValue["threes"] = calcSameDices(option: "threes")
        }
        if !(optionsHasPlayed["fours"]!) {
            optionsValue["fours"] = calcSameDices(option: "fours")
        }
        if !(optionsHasPlayed["fives"]!) {
            optionsValue["fives"] = calcSameDices(option: "fives")
        }
        if !(optionsHasPlayed["sixs"]!) {
            optionsValue["sixs"] = calcSameDices(option: "sixs")
        }
        if !(optionsHasPlayed["3x"]!) {
            optionsValue["3x"] = calc3x()
        }
        if !(optionsHasPlayed["twoPairs"]!) {
            optionsValue["twoPairs"] = calcTwoPairs()
        }
        if !(optionsHasPlayed["fullHouse"]!) {
            optionsValue["fullHouse"] = calcFullHouse()
        }
        if !(optionsHasPlayed["small"]!) {
            optionsValue["small"] = calcSmall()
        }
        if !(optionsHasPlayed["large"]!) {
            optionsValue["large"] = calcLarge()
        }
        if !(optionsHasPlayed["5x"]!) {
            optionsValue["5x"] = calc5x()
        }
        if !(optionsHasPlayed["all"]!) {
            optionsValue["all"] = calcAll()
        }
    }
    
    // MARK: - NEW HIGH SCORE LOGIC
    func setNewHighScore() {
        highScore = currentScore
    }
    
    
    // MARK: - CALCULATING THE RESULTS FOR EACH DICE OPTION
    func calcSameDices(option: String) -> Int {
        var result = 0
        for reel in reels {
            if reel == dicesValue[option]! - 1 {
                result += dicesValue[option]!
            }
        }
        return result
    }
    
    func calc3x() -> Int {
        var result = 0
        var counts = ["0": 0,"1": 0,"2": 0,"3": 0,"4": 0,"5": 0]
        
        for reel in reels {
            counts[String(reel)]! += 1
        }
        
        for k in counts.keys {
            if counts[k]! > 2 {
                result = (Int(k)! + 1) * 3
            }
        }
        
        return result
    }
    
    func calc5x() -> Int {
        var result = 0
        for i in 0...5 {
            if reels.allSatisfy({$0 == i}) {
                result = 50
                break
            }
        }
        return result
        
    }
    
    func calcTwoPairs() -> Int {
        var result = 0
        var pairsResultTemp = 0
        var pairCount = 0
        
        var counts = ["0": 0,"1": 0,"2": 0,"3": 0,"4": 0,"5": 0]
        
        for reel in reels {
            counts[String(reel)]! += 1
        }
        
        for k in counts.keys {
            if counts[k]! >= 2 {
                pairsResultTemp += (Int(k)! + 1) * 2
                pairCount += 1
            }
        }
        
        if pairCount == 2 {
            result = pairsResultTemp
        }
        
        return result
    }
    
    func calcFullHouse() -> Int {
        var result = 0
        var houseResultTemp = 0
        var pairCount = 0
        var tripleCount = 0
        
        var counts = ["0": 0,"1": 0,"2": 0,"3": 0,"4": 0,"5": 0]
        
        for reel in reels {
            counts[String(reel)]! += 1
        }
        
        for k in counts.keys {
            if counts[k]! == 2 {
                houseResultTemp += (Int(k)! + 1) * 2
                pairCount += 1
            }
            if counts[k]! == 3 {
                houseResultTemp += (Int(k)! + 1) * 3
                tripleCount += 1
            }
        }
        
        if pairCount == 1 && tripleCount == 1 {
            result = houseResultTemp
        }
        
        return result
    }
    
    func calcSmall() -> Int {
        var result = 0
        if checkConsecutiveNumbers(arr: reels, n: 4) {
            result = 30
        }
        return result
        
    }
    
    func calcLarge() -> Int {
        var result = 0
        if checkConsecutiveNumbers(arr: reels, n: 5) {
            result = 40
        }
        return result
    }
    
    func calcAll() -> Int {
        var result = 0
        for reel in reels {
            result += reel + 1
        }
        return result
    }
    
    
    // MARK: - VIEW BODY
    var body: some View {
        ZStack {
//            Color(.yellow)
//                .edgesIgnoringSafeArea(.all)
            VStack {
                
                // MARK: - HEADER
                ZStack(alignment: .top) {
                    Color("primary-color")
                    VStack {
                        // MARK: - SCORE BANNER
                        ScoreBannerView(currentScore: currentScore, highScore: highScore)
                        HStack {
                            // MARK: - TIMER
                            HStack {
                                Image(systemName: "clock.badge")
                                    .modifier(IconModifier())
                                Text("10:30")
                                    .foregroundColor(.white)
                                    .font(.custom("Play-Regular", size: 15))
                                    .bold()
                            }
                            Spacer()
                            Button {
                                print("toggle instruction sheet")
                            } label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .foregroundColor(.white)
                            }
                            .offset(x: 18)
                            Spacer()
                            // MARK: - ROUND CALL
                            HStack {
                                Text("Your Goal:")
                                    .font(.custom("Play-Regular", size: 15))
                                    .foregroundColor(.white)
                                Text("\(scoreToBeat)")
                                    .font(.custom("Play-Regular", size: 15))
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            
                        }
                        .padding(.horizontal)
                    }
                    .padding([.top], 10)
                    
                } // ZStack
                .frame(height: 120)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("border-color"), lineWidth: 5)
                )
                Spacer()
                
                // MARK: - GAME BODY VIEW
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        PointsOptionView(id: "ones", diceImage: Image("dice-face-1"), points: optionsHasPlayed["ones"]! ? optionsSavedValue["ones"]! : optionsValue["ones"]!, selected: $optionsSelected, isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay, hasPlayed: $optionsHasPlayed)
                        PointsOptionView(id: "twos", diceImage: Image("dice-face-2"), points: optionsHasPlayed["twos"]! ? optionsSavedValue["twos"]! : optionsValue["twos"]!, selected: $optionsSelected,isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay, hasPlayed: $optionsHasPlayed)
                        PointsOptionView(id: "threes", diceImage: Image("dice-face-3"), points: optionsHasPlayed["threes"]! ? optionsSavedValue["threes"]! : optionsValue["threes"]!, selected: $optionsSelected,isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay, hasPlayed: $optionsHasPlayed)
                        PointsOptionView(id: "fours", diceImage: Image("dice-face-4"), points: optionsHasPlayed["fours"]! ? optionsSavedValue["fours"]! : optionsValue["fours"]!, selected: $optionsSelected,isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay, hasPlayed: $optionsHasPlayed)
                        PointsOptionView(id: "fives", diceImage: Image("dice-face-5"), points: optionsHasPlayed["fives"]! ? optionsSavedValue["fives"]! : optionsValue["fives"]!, selected: $optionsSelected,isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay, hasPlayed: $optionsHasPlayed)
                        PointsOptionView(id: "sixs", diceImage: Image("dice-face-6"), points: optionsHasPlayed["sixs"]! ? optionsSavedValue["sixs"]! : optionsValue["sixs"]!, selected: $optionsSelected,isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay, hasPlayed: $optionsHasPlayed)
                        HStack {
                            Image("section-bonus")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 60)
                            Circle()
                                .foregroundColor(.white)
                                .modifier(ShadowModifier())
                                .frame(height: 50)
                                .overlay(
                                    Text("\(bonus)/63")
                                        .font(.custom("Play-Regular", size: 15))
                                        .bold()
                                )
                            if showBonus {
                                Image("bonus-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70)
                            }
                        }
                    }
                    Spacer()
                    VStack(spacing: 5) {
                        PointsOptionView(id: "3x", diceImage: Image("dice-face-3x"), points: optionsHasPlayed["3x"]! ? optionsSavedValue["3x"]! : optionsValue["3x"]!, selected: $optionsSelected,isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay, hasPlayed: $optionsHasPlayed)
                        PointsOptionView(id: "twoPairs", diceImage: Image("dice-face-pairs"), points: optionsHasPlayed["twoPairs"]! ? optionsSavedValue["twoPairs"]! : optionsValue["twoPairs"]!, selected: $optionsSelected, isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay, hasPlayed: $optionsHasPlayed)
                        PointsOptionView(id: "fullHouse", diceImage: Image("dice-face-fullhouse"), points: optionsHasPlayed["fullHouse"]! ? optionsSavedValue["fullHouse"]! : optionsValue["fullHouse"]!, selected: $optionsSelected ,isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay, hasPlayed: $optionsHasPlayed)
                        PointsOptionView(id: "small", diceImage: Image("dice-face-small"), points: optionsHasPlayed["small"]! ? optionsSavedValue["small"]! : optionsValue["small"]!, selected: $optionsSelected ,isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay, hasPlayed: $optionsHasPlayed)
                        PointsOptionView(id: "large", diceImage: Image("dice-face-large"), points: optionsHasPlayed["large"]! ? optionsSavedValue["large"]! : optionsValue["large"]!, selected: $optionsSelected ,isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay, hasPlayed: $optionsHasPlayed)
                        PointsOptionView(id: "5x", diceImage: Image("dice-face-5x"), points: optionsHasPlayed["5x"]! ? optionsSavedValue["5x"]! : optionsValue["5x"]!, selected: $optionsSelected,isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay, hasPlayed: $optionsHasPlayed)
                        PointsOptionView(id: "all", diceImage: Image("dice-face-?"), points: optionsHasPlayed["all"]! ? optionsSavedValue["all"]! : optionsValue["all"]!, selected: $optionsSelected,isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay, hasPlayed: $optionsHasPlayed)
                    }
                }
                .padding(.horizontal)
                
                
                Spacer()
                
                // MARK: - ROLL VIEW
                ZStack {
                    Color("primary-color")
                    VStack {
                        
                        // MARK: - NUMBER OF REROLL & REEL VIEW
                        RollView(columns: 5, dices: dices, rerollCount: reroll, reels: $reels, locks: $locks, animatingIcon: $animatingIcon)
                        
                        HStack {
                            // MARK: ROLL BUTTON
                            Button {
                                withAnimation {
                                    animatingIcon = false
                                }
                                    
                                rerollDices()
                                playSound(sound: "dice-roll", type: "mp3")
                                
                                withAnimation {
                                    animatingIcon = true
                                }
                                
                            } label: {
                                Image("roll-button")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150)
                                    .opacity(isAnyOptionSelected ? 0.5 : (canRoll && reroll > 0 ? 1 : 0.5))
                            }
                            .disabled(isAnyOptionSelected ? true : (reroll == 0 ? true : !canRoll))
                            
                            Spacer()
                            
                            // MARK: PLAY BUTTON
                            Button {
                                playSound(sound: "play", type: "mp3")
                                play()
                                resetTurn()
                                isGameOver()
                                
                            } label: {
                                Image("play-button")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150)
                                    .opacity(canPlay ? 1 : 0.5)
                            }
                            .disabled(!canPlay)
                        }
                        .padding(.horizontal)
                    } // VStack
                    .padding(.top, 5)
                } // ZStack
                .frame(height: 170)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("border-color"), lineWidth: 5)
                )
            
            } // VStack
            
            // MARK: - GAME OVER MESSAGE
            if showGameOverMessage {
                ZStack {
                    Color("primary-color")
                    VStack {
                        Text("Game Over!!!")
                            .font(.custom("Play-Bold", size: 35))
                            .fontWeight(.heavy)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 280)
                            .background(Color("secondary-color"))
                        Spacer()
                        
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        Text("Try again next time")
                            .font(.system(size: 27))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Button {
                            showGameOverMessage = false
                            resetAll()
                        } label: {
                            Capsule()
                                .frame(height: 50)
                                .overlay(
                                Text("New Game".uppercased())
                                    .font(.custom("Play-Regular", size: 30))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                )
                                
                        }
                    }
                }
                .frame(width: 280, height: 450)
                .cornerRadius(20)
            }
            
            // MARK: - GAME WIN MESSAGE
            if showGameWinMessage {
                ZStack {
                    Color("primary-color")
                    VStack {
                        Text("You Won!!!")
                            .font(.custom("Play-Bold", size: 35))
                            .fontWeight(.heavy)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 280)
                            .background(Color("secondary-color"))
                        Spacer()
                        
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        Text("Congratulations, proceed to next round?")
                            .font(.system(size: 27))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Button {
                            showGameWinMessage = false
                            resetAll()
                        } label: {
                            Capsule()
                                .frame(height: 50)
                                .overlay(
                                Text("New Game".uppercased())
                                    .font(.custom("Play-Regular", size: 30))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                )
                                
                        }
                    }
                }
                .frame(width: 280, height: 450)
                .cornerRadius(20)
            }
            
        } // ZStack
        .alert("You have reached new high score!!!", isPresented: $newHighScoreFound) {
            Button("OK", role: .cancel) {}
        }
            
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
