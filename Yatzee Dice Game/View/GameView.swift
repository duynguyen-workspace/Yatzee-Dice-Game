/*
  GameView.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created date: 22/08/2023
  Last modified: 07/09/2023
  Acknowledgement:
  - Observable Object, State Object, Environment Object, MVVM Model: Lecturer's Example, Week 10 Lecture Slides & Lab Tutorial
  - Calculate small straight function: https://codegolf.stackexchange.com/questions/74997/yahtzee-small-straight-detection
*/

import SwiftUI

struct GameView: View {
    // MARK: ***** PROPERTIES *****
    
    // MARK: - INPUT PROPERTIES -
    let userName: String // Player username
    @EnvironmentObject var leaderboardModel : LeaderBoardViewModel // Leaderboard View Model Data
    @EnvironmentObject var gameModel: GameViewModel // Game View Model Data
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    // MARK: - GLOBAL PROPERTIES -
    let diceFaces: [String] = ["", "dice-face-1","dice-face-2","dice-face-3","dice-face-4","dice-face-5","dice-face-6"] // Array store a list of dice images for reels
    let diceOptionFaces: [String] = ["dice-face-1","dice-face-2","dice-face-3","dice-face-4","dice-face-5","dice-face-6","dice-face-3x","dice-face-pairs","dice-face-fullhouse","dice-face-small","dice-face-large","dice-face-5x","dice-face-?"] // Array store a list of dice images for all the dice options
    let dicesValue = ["ones": 1, "twos": 2, "threes": 3,"fours": 4,"fives": 5,"sixs": 6] // Array store a list of values for the fair dice
    
    // MARK: - REELS PROPERTIES -
    @StateObject var rollModel = RollViewModel() // Roll View Model
    
    // MARK: - DICE PLAYING OPTION PROPERTIES -
    @StateObject var diceOptionModel = DiceOptionViewModel() // Dice View Model
    
    @State private var optionsSelected = ["ones": false, "twos": false, "threes": false,"fours": false,"fives": false,"sixs": false,"3x": false,"twoPairs": false,"fullHouse": false,"small": false,"large": false,"5x": false,"all": false] // Array store a list of selected status of the dice options
    @State private var optionsHasPlayed = ["ones": false, "twos": false, "threes": false,"fours": false,"fives": false,"sixs": false,"3x": false,"twoPairs": false,"fullHouse": false,"small": false,"large": false,"5x": false,"all": false] // Array store a list of hasPlayed status of the dice options

    // MARK: - GAME PROPERTIES -
    @State private var isAnyOptionSelected = false // Boolean value to indicate whether if any dice option is selected
    @State private var canRoll = true // Boolean value to check if the roll button is active
    @State private var canPlay = false // Boolean value to check if the play button is active
    
    @State private var showGameOverMessage = false // Boolean value to display game over (losing) message
    @State private var showGameWinMessage = false // Boolean value to display game winning message
    @State private var showGameSaveMessage = false // Boolean value to display saving game message
    @State private var showBonus = false // Boolean value to display bonus
    @State private var isInstructionSheetPresented = false // Boolean value to toggle the showing of the instruction sheet
    
    // MARK: TIMER PROPERTIES
    @State private var realTimeTimer = 0 // timer value
    @State private var isTimerEnabled = false // Boolean value to check if the timer can be enabled
    @State private var timerRunning = false // Boolean value to check if the timer is currently running
    let countDownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Initiate the timer countdown for every 1 second
    
    // MARK: POINTS PROPERTIES
    @State private var currentScore = 0 // Player current score
    @State private var bonus = 0 // Bonus score
    @AppStorage("highScore") var highScore = 250 // High Score value
    @State private var newHighScoreFound = false // Boolean value to check if the high score has been found
    
    // MARK: OTHER PROPERTIES
    let columns = 5 // Number of columns for the grid layout
    @State private var firstAppear = true // Boolean value to check
    @State private var animatingIcon = true // Animation Status
    
    // MARK: ***** ALL LOGIC *****
    
    // MARK: ----- RESET LOGIC -----
    /* Reset all properties and values for one turn */
    func resetAll() {
        currentScore = 0
        rollModel.resetReels()
        diceOptionModel.resetOptions()
        resetHasPlayed()
        resetOptionsButton()
        
        resetTurn()
        resetBonus()
        
        resetTimer()
        
        newHighScoreFound = false
        firstAppear = true
    }
        
    // MARK: - RESET BUTTON DISABLED
    func resetOptionsButton() {
        for k in optionsSelected.keys {
            optionsSelected[k] = optionsHasPlayed[k]
        }
    }
    
    // MARK: - RESET DICE OPTION HASPLAYED STATUS
    func resetHasPlayed() {
        for k in optionsHasPlayed.keys {
            optionsHasPlayed[k] = false
        }
        isAnyOptionSelected = false
    }
    
    // MARK: - RESET TIMER
    func resetTimer() {
        if isTimerEnabled {
            realTimeTimer = gameModel.timer
            timerRunning = true
        }
    }

    // MARK: - RESET TURN AFTER ONE OPTION IS PLAYED
    func resetTurn() {
        gameModel.resetRollCount()
        canRoll = true
        canPlay = false
    }
    
    // MARK: ----- BONUS LOGIC -----
    
    // MARK: BONUS VALUE CALCULATION
    func calcBonus() {
        var bonusScore = 0
        
        for i in 0...5 {
            bonusScore += diceOptionModel.diceOptions[i].savedValue
        }
        
        bonus = bonusScore
    }
    
    // MARK: CHECK IF THE BONUS HAS BEEN ACHIEVED
    func checkBonus() {
        if bonus >= 63 {
            showBonus = true
            currentScore += 45
            playSound(sound: "bonus", type: "mp3")
        }
    }
    
    // MARK: - RESET BONUS VALUE
    func resetBonus() {
        bonus = 0
        showBonus = false
    }
    
    // MARK: ----- GAME LOGIC -----
    
    // MARK: - GAME OVER LOGIC
    func isGameOver() {
        if checkGameFinished() {
            if checkWinning() {
                showGameWinMessage = true
            
                if currentScore > highScore {
                    setNewHighScore()
                    newHighScoreFound = true
                    playSound(sound: "highscore", type: "mp3")
                } else {
                    playSound(sound: "winning", type: "mp3")
                }
                
                // Add the player info to the leaderboard
                var badgeList : [String] = []
                
                if currentScore > 100 {
                    badgeList.append("badge-100")
                } else if currentScore > 200 {
                    badgeList.append("badge-200")
                } else if currentScore > 300 {
                    badgeList.append("badge-300")
                }
                
                if gameModel.isEasySelected {
                    badgeList.append("badge-easy")
                }
                if gameModel.isMediumSelected {
                    badgeList.append("badge-medium")
                }
                if gameModel.isHardSelected {
                    badgeList.append("badge-hard")
                }
                
                if diceOptionModel.diceOptions[12].savedValue != 0 {
                    badgeList.append("badge-5x")
                }
                
                leaderboardModel.addPlayer(name: userName, score: currentScore, badges: badgeList)
                
            } else {
                showGameOverMessage = true
                playSound(sound: "gameover", type: "mp3")
            }
            
        }
    }
    
    // MARK: - CHECK IF GAME IS FINISHED
    func checkGameFinished() -> Bool {
        if isTimerEnabled {
            return checkAllOptionsPlayed() || !timerRunning
        }
        return checkAllOptionsPlayed()
    }
    
    // MARK: - CHECK IF ALL THE OPTIONS HAS BEEN PLAYED
    func checkAllOptionsPlayed() -> Bool {
        for option in optionsHasPlayed {
            if option.value == false {
                return false
            }
        }
        return true
    }
    
    // MARK: - CHECK WINNING LOGIC
    func checkWinning() -> Bool {
        if currentScore >= gameModel.scoreToBeat {
            // Winning
            return true
        } else {
            // Losing
            return false
        }
    }
        
    // MARK: - REROLL LOGIC
    func rerollDices() {
        if gameModel.rerollCount > 0 {
            rollDicesWithLocks()
            gameModel.rerollCount -= 1
        } else {
            canRoll = false
        }
    }
    
    // MARK: - ROLL DICE BUTTON LOGIC (WITH LOCKS)
    func rollDicesWithLocks() {
        // Roll dice function
        rollModel.roll()
        
        // Check if the dice is locked --> Only roll the reel that is not locked
        for i in 0...diceOptionModel.diceOptions.count-1 {
            if diceOptionModel.diceOptions[i].isPlayed == false {
                // Provide a score calculation according to the dice option
                switch (diceOptionModel.diceOptions[i].name) {
                case "ones":
                    diceOptionModel.diceOptions[0].currentValue = calcSameDices(option: "ones")
                case "twos":
                    diceOptionModel.diceOptions[1].currentValue = calcSameDices(option: "twos")
                case "threes":
                    diceOptionModel.diceOptions[2].currentValue = calcSameDices(option: "threes")
                case "fours":
                    diceOptionModel.diceOptions[3].currentValue = calcSameDices(option: "fours")
                case "fives":
                    diceOptionModel.diceOptions[4].currentValue = calcSameDices(option: "fives")
                case "sixs":
                    diceOptionModel.diceOptions[5].currentValue = calcSameDices(option: "sixs")
                case "3x":
                    diceOptionModel.diceOptions[6].currentValue = calc3x()
                case "twoPairs":
                    diceOptionModel.diceOptions[7].currentValue = calcTwoPairs()
                case "fullHouse":
                    diceOptionModel.diceOptions[8].currentValue = calcFullHouse()
                case "small":
                    diceOptionModel.diceOptions[9].currentValue = calcSmall()
                case "large":
                    diceOptionModel.diceOptions[10].currentValue = calcLarge()
                case "5x":
                    diceOptionModel.diceOptions[11].currentValue = calc5x()
                case "all":
                    diceOptionModel.diceOptions[12].currentValue = calcAll()
                
                default:
                    // DO NOTHING
                    print("Cannot calculate!")
                    
                }
            }
        }
        
    }
    
    // MARK: PLAY BUTTON LOGIC
    func play() {
        // Initialise variables
        var addedScore = 0
        var optionName = ""
        var optionIndex = -1
        
        // Find the dice option that has been selected
        for option in optionsSelected {
            if option.value == true {
                optionName = option.key
            }
        }
        
        // Get the index of the option in the dice option model array
        for i in 0...diceOptionModel.diceOptions.count-1 {
            if diceOptionModel.diceOptions[i].name == optionName {
                optionIndex = i
                break
            }
        }
        print(diceOptionModel.diceOptions[optionIndex])
        
        // Update the current score, option saved value
        addedScore = diceOptionModel.diceOptions[optionIndex].currentValue
        diceOptionModel.diceOptions[optionIndex].savedValue = addedScore
        currentScore += addedScore
        
        // Set the selected and isPlayed status of the dice option, reset other properties
        diceOptionModel.setOptionIsPlayed(at: optionIndex, status: true)
        optionsHasPlayed[optionName] = true
        optionsSelected[optionName] = false
        isAnyOptionSelected = false
        
        // Reset reels
        rollModel.resetReels()
        
        // Reset dice options current value
        diceOptionModel.resetOptionCurrentValues()
        
       
        // Check for bonus
        if showBonus == false {
            calcBonus()
            checkBonus()
        }
       
    }
    
    // MARK: - NEW HIGH SCORE LOGIC
    func setNewHighScore() {
        highScore = currentScore
    }
    
    
    // MARK: ----- CALCULATION LOGIC -----
    
    /**
     Calculate the score for dices with the same value (any dice in the reel)
     */
    func calcSameDices(option: String) -> Int {
        var result = 0
        for reel in rollModel.reels {
            if reel.value == dicesValue[option]! {
                result += dicesValue[option]!
            }
        }
        return result
    }
    
    
    /**
     Calculate the score for three of a Kind (total number of dice with the same value occurs >= 3 times)
     */
    func calc3x() -> Int {
        var result = 0
        var counts = ["1": 0,"2": 0,"3": 0,"4": 0,"5": 0,"6": 0]
        
        for reel in rollModel.reels {
            counts[String(reel.value)]! += 1
        }
        
        for k in counts.keys {
            if counts[k]! > 2 {
                result = Int(k)! * 3
            }
        }
        
        return result
    }
    
    /**
     Calculate the score for Yahtzee or Five of a Kind (all the rolling dices in the reels have the same value)
     */
    func calc5x() -> Int {
        var result = 0
        for i in 0...5 {
            if rollModel.reels.allSatisfy({$0.value == i+1}) {
                result = 50
                break
            }
        }
        
        return result
        
    }
    
    /**
     Calculate the score for Two Pairs (total number of dice with the same value occurs >= 3 times)
     */
    func calcTwoPairs() -> Int {
        var result = 0
        var pairsResultTemp = 0
        var pairCount = 0
        
        var counts = ["1": 0,"2": 0,"3": 0,"4": 0,"5": 0,"6": 0]
        
        for reel in rollModel.reels {
            counts[String(reel.value)]! += 1
        }
        
        for k in counts.keys {
            if counts[k]! >= 2 {
                pairsResultTemp += (Int(k)!) * 2
                pairCount += 1
            }
        }
        
        if pairCount == 2 {
            result = pairsResultTemp
        }
        
        return result
    }
    
    /**
     Calculate the score for Full House (total number of dice with the same value occurs >= 3 times)
     */
    func calcFullHouse() -> Int {
        var result = 0
        var houseResultTemp = 0
        var pairCount = 0
        var tripleCount = 0
        
        var counts = ["1": 0,"2": 0,"3": 0,"4": 0,"5": 0,"6": 0]
        
        for reel in rollModel.reels {
            counts[String(reel.value)]! += 1
        }
        
        for k in counts.keys {
            if counts[k]! == 2 {
                houseResultTemp += (Int(k)!) * 2
                pairCount += 1
            }
            if counts[k]! == 3 {
                houseResultTemp += (Int(k)!) * 3
                tripleCount += 1
            }
        }
        
        if pairCount == 1 && tripleCount == 1 {
            result = houseResultTemp
        }
        
        return result
    }
    
    /**
     Calculate the score for small straight (30 points)
     */
    func calcSmall() -> Int {
        //
        var consecutiveCount = 0
        
        // Sorted the reels array
        var sortedReels = rollModel.reels.map({$0.value}).sorted()
        // print(sortedReels)
        
        // Remove duplicated values
        for i in 1...sortedReels.count - 1 {
            if (sortedReels[i] != sortedReels[i-1]+1) {
                sortedReels.remove(at: i)
                break
            }
        }
        
        // Checking the adjacent elements
        for i in 1...sortedReels.count - 1 {
            if (sortedReels[i] == sortedReels[i-1]+1) {
                consecutiveCount += 1
            }
        }
        
        if consecutiveCount >= 3 {
            return 30
        }
        return 0
    }
    
    /**
     Calculate the score for Large Straight (total number of dice with the same value occurs >= 3 times)
     */
    func calcLarge() -> Int {
        var result = 0
        
        // Sorted the reels array
        let sortedReels = rollModel.reels.map({$0.value}).sorted()
        
        if isSequence(arr: sortedReels) {
            result = 40
        }
        return result
    }
    
    func calcAll() -> Int {
        var result = 0
        for reel in rollModel.reels {
            result += reel.value
        }
        return result
    }
    
    
    // MARK: ***** BODY VIEW *****
        var body: some View {
            ZStack {
                // MARK: ----- BACKGROUND -----
                Color("bg-color")

                // MARK: MIDDLE LOGO ICON
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    Text("GO ROLL")
                        .font(.custom("Play-Regular", size: 20))
                        .foregroundColor(Color("primary-color"))
                        .bold()
                }
                .opacity(0.7)
                
                // MARK: ----- CONTENT -----
                VStack {
                    // MARK: - HEADER -
                    ZStack(alignment: .top) {
                        Color("primary-color")
                        VStack {
                            
                            // MARK: SCORE BANNER
                            ScoreBanner(userName: userName, currentScore: currentScore, highScore: highScore)
                            HStack {
                                // MARK: TIMER
                                HStack {
                                    Image(systemName: "clock.badge")
                                        .modifier(IconModifier())
                                    Text("\(realTimeTimer / 60): \((realTimeTimer % 60))s")
                                        .foregroundColor(.white)
                                        .font(.custom("Play-Regular", size: 15))
                                        .bold()
                                        .onReceive(countDownTimer) { _ in
                                            if realTimeTimer > 0 && timerRunning {
                                                realTimeTimer -= 1
                                            } else {
                                                timerRunning = false
                                            }
                                        }
                                        
                                }
                                Spacer()
                                
                                // MARK: ICONS
                                HStack(alignment: .center) {
                                    // MARK: HELP ICON
                                    Button {
                                        // Toggle instruction sheet
                                        isInstructionSheetPresented.toggle()
                                    } label: {
                                        Image(systemName: "questionmark.circle.fill")
                                            .foregroundColor(.white)
                                    }
                                    // Present the sheet on the view
                                    .sheet(isPresented: $isInstructionSheetPresented) {
                                        InstructionView()
                                            .presentationDetents([.medium, .large])
                                            .presentationDragIndicator(.visible)
                                    }
                                    
                                    // MARK: SAVE ICON
                                    Button {
                                        showGameSaveMessage.toggle()
                                    } label: {
                                        Image(systemName: "folder.fill")
                                            .foregroundColor(.white)
                                    }
                                }
                                .offset(x: 15)
                                
                                Spacer()
                                // MARK: - GAME TARGET INFO -
                                HStack {
                                    Text("Your Goal:")
                                        .font(.custom("Play-Regular", size: 15))
                                        .foregroundColor(.white)
                                    Text("\(gameModel.scoreToBeat)")
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
                    
                    // MARK: - GAME BODY VIEW -
                    HStack(alignment: .top) {
                        // MARK: DICE PLAYING OPTIONS
                        VStack(alignment: .leading, spacing: 5) {
                            // Generate the left sided icons
                            ForEach(0..<6) { i in
                                DiceOptionRow(id: i, diceImage: Image(diceOptionFaces[i]), points: diceOptionModel.diceOptions[i].isPlayed ? diceOptionModel.diceOptions[i].savedValue : diceOptionModel.diceOptions[i].currentValue, diceOptionModel: DiceOptionViewModel(), selected: $optionsSelected, hasPlayed: $optionsHasPlayed, isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay)
                            }
                            // MARK: BONUS SECTION
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
                                // Show the bonus graphic if bonus score is achieved
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
                            // Generate the right sided icons
                            ForEach(6..<13) { i in
                                DiceOptionRow(id: i, diceImage: Image(diceOptionFaces[i]), points: diceOptionModel.diceOptions[i].isPlayed ? diceOptionModel.diceOptions[i].savedValue : diceOptionModel.diceOptions[i].currentValue, diceOptionModel: DiceOptionViewModel(), selected: $optionsSelected, hasPlayed: $optionsHasPlayed, isOtherOptionSelected: $isAnyOptionSelected, canPlay: $canPlay)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    Spacer()
                    
                    // MARK: - ROLL VIEW -
                    ZStack {
                        Color("primary-color")
                        VStack {
                            // MARK: - NUMBER OF REROLL COUNT & REEL VIEW
                            RollView(columns: 5, diceFaces: diceFaces, rerollCount: gameModel.rerollCount, rollModel: rollModel, animatingIcon: $animatingIcon)
                            
                            HStack {
                                // MARK: ROLL BUTTON
                                Button {
                                    // Roll dice with flipping animation
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
                                        .opacity(isAnyOptionSelected ? 0.5 : (canRoll && gameModel.rerollCount > 0 ? 1 : 0.5))
                                }
                                // User cannot roll the dice if the player is selecting an option, or when reroll count is 0
                                .disabled(isAnyOptionSelected ? true : (gameModel.rerollCount == 0 ? true : !canRoll))
                                
                                Spacer()
                                
                                // MARK: PLAY BUTTON
                                Button {
                                    // Play the option selected and check if the game is over
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
                                // User cannot play the dice if no option is selected
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
                
                // MARK: - GAME SAVE MESSAGE -
                if showGameSaveMessage {
                    ZStack {
                        Color(.black)
                            .opacity(0.1)
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 200)
                            .foregroundColor(Color("primary-color"))
                        VStack {
                            Text("Do you want to save the game?")
                                .foregroundColor(.white)
                                .font(.custom("Play-Regular", size: 22))
                                .bold()
                            
                            HStack {
                                Button {
                                    showGameSaveMessage = false
                                } label: {
                                    GameButton(text: "NO", textColor: .white, buttonColor: Color("tertiary-color"))
                                }
                                Button {
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    GameButton(text: "YES", textColor: .white, buttonColor: .green)
                                }
                            }
                        }
                    }
                    
                }
                
                // MARK: - GAME OVER MESSAGE
                if showGameOverMessage {
                    ZStack {
                        Color(.black)
                            .opacity(0.1)
                        ZStack {
                            VStack(spacing: 0) {
                                Image("star-head")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 180)
                                    .offset(y: 30)
                                    .zIndex(1)
                                ZStack {
                                    LinearGradient(gradient: Gradient(colors: [Color("gradient-color-red"),Color.red,Color("tertiary-color")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: .bottom)
                                    VStack(spacing: 10) {
                                        Text("GAME OVER!!!")
                                            .font(.custom("Play-Bold", size: 35))
                                            .fontWeight(.heavy)
                                            .padding(.top, 30)
                                            .foregroundColor(.white)
                                            .frame(width: 280)
                                        Spacer()
                                        VStack(spacing: 0) {
                                            Image("game-avatar")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 80)
                                                .clipShape(Circle())
                                                .overlay(
                                                    Circle()
                                                        .stroke( Color("primary-color"), lineWidth: 5)
                                                )
                                        }
                                        
                                        VStack(spacing: 0) {
                                            Text("Your Score: \(currentScore)")
                                                .font(.custom("Play-Bold", size: 25))
                                            Text("Score To Beat: \(gameModel.scoreToBeat)")
                                                .font(.custom("Play-Bold", size: 25))
                                        }
                                        
                                        VStack {
                                            Text("Please try again next time!")
                                                .font(.custom("Play-Regular", size: 20))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(.horizontal)
                                        
                                        Spacer()
                                        
                                        VStack {
                                            Button {
                                                showGameOverMessage = false
                                                resetAll()
                                            } label: {
                                                GameButton(text: "NEW GAME", textColor: .white, buttonColor: .green)
                                                
                                            }
                                            
                                            Button {
                                                presentationMode.wrappedValue.dismiss()
                                            } label: {
                                                GameButton(text: "HOME", textColor: .white, buttonColor: .black)
                                                
                                            }
                                        }
                                        .padding(.bottom)
                                        
                                    }
                                }
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color("icon-color"), lineWidth: 10)
                                )
                            }
                        }
                        .offset(y: -20)
                        .frame(width: 350, height: 600)
                    }
                }
                
                // MARK: - GAME WIN MESSAGE
                if showGameWinMessage {
                    ZStack {
                        Color(.black)
                            .opacity(0.1)
                        ZStack {
                            VStack(spacing: 0) {
                                Image("star-head")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 180)
                                    .offset(y: 30)
                                    .zIndex(1)
                                ZStack {
                                    LinearGradient(gradient: Gradient(colors: [Color("gradient-color-red"),Color.red,Color("tertiary-color")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: .bottom)
                                    VStack(spacing: 10) {
                                        Text("YOU WON!!!")
                                            .font(.custom("Play-Bold", size: 40))
                                            .fontWeight(.heavy)
                                            .padding(.top, 30)
                                            .foregroundColor(.white)
                                            .frame(width: 280)
                                        VStack(spacing: 0) {
                                            Image("crown")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 70)
                                                .offset(y: 10)
                                            Image("game-avatar")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 80)
                                                .clipShape(Circle())
                                                .overlay(
                                                    Circle()
                                                        .stroke( Color("primary-color"), lineWidth: 5)
                                                )
                                        }
                                        
                                        Text("Your Score: \(currentScore)")
                                            .font(.custom("Play-Bold", size: 25))
                                        
                                        VStack {
                                            Text("You may want to try some other game modes too. Have fun!")
                                                .font(.custom("Play-Regular", size: 20))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(.horizontal)
                                        
                                        Spacer()
                                        
                                        VStack {
                                            Button {
                                                showGameWinMessage = false
                                                resetAll()
                                            } label: {
                                                GameButton(text: "NEW GAME", textColor: .white, buttonColor: .green)
                                                
                                            }
                                            
                                            Button {
                                                presentationMode.wrappedValue.dismiss()
                                            } label: {
                                                GameButton(text: "BACK", textColor: .white, buttonColor: .black)
                                                
                                            }
                                        }
                                        .padding(.bottom)
                                        
                                    }
                                }
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color("icon-color"), lineWidth: 10)
                                )
                            }
                        }
                        .offset(y: -20)
                        .frame(width: 350, height: 600)
                    }
                }
            } // ZStack
            // Show alert message if the new high score is found
            .alert("You have reached new high score!!!", isPresented: $newHighScoreFound) {
                Button("OK", role: .cancel) {
                    stopSound(sound: "highscore", type: "mp3")
                    playSound(sound: "winning", type: "mp3")
                }
            }
            // Hide the navigation back button
            .navigationBarBackButtonHidden(true)
            // MARK: GAME VIEW RENDERING EXECUTIONS
            .onAppear {
                // If the view is first time appear -> set the gamemode for the gameview
                if firstAppear {
                    // If user has not set any game mode (not visiting the setting view) -> set easy mode by default
                    if !gameModel.isEasySelected && !gameModel.isMediumSelected && !gameModel.isHardSelected {
                        gameModel.isEasySelected = true
                        gameModel.setEasyMode()
                    }
                    
                    // Set the gamemode accordingly to the gamemode selected in the game view model
                    if gameModel.isEasySelected {
                        gameModel.setEasyMode()
                    }
                    if gameModel.isMediumSelected {
                        gameModel.setMediumMode()
                    }
                    if gameModel.isHardSelected {
                        gameModel.setHardMode()
                    }
                    
                    if gameModel.timer != 0 {
                        realTimeTimer = gameModel.timer
                        timerRunning = true
                        isTimerEnabled = true
                    }
                    
                    // Toggle the value of first appear property
                    firstAppear = false
                } else {
                    // Check if the timer is run out -> check game over
                    if realTimeTimer == 0 {
                        isGameOver()
                    }
                }
                // Stop background music
                stopSound(sound: "background-music", type: "mp3")
                // Sort the players in the leaderboard and display the player with the highest score
                leaderboardModel.sortPlayers()
                highScore = leaderboardModel.players[0].score
                
            }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(userName: "Duy")
            .environmentObject(LeaderBoardViewModel())
            .environmentObject(GameViewModel())
    }
}

