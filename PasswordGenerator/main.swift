// Getting a correct integer input
func getInteger() -> Int {
  while true {
    if let input = readLine(), 
    let unwrappedInteger = Int(input),
    (0...100).contains(unwrappedInteger) {
      return unwrappedInteger
    } else {
      print("Incorrect input!")
      print("You should enter a whole positive number 1-100.")
      continue
    }
  }
}

// Getting "yes" or "no" from the user
func getYesOrNo() -> String {
  while true {
    let entered = readLine()!.lowercased()
    if "yes" == entered || "no" == entered {
      return entered
    }
    print("You should enter \"yes\" or \"no\".")
  }
}

// Gathering what the user has picked
func getChoices() -> (Int, Int, Bool, Bool, Bool) {
  var choices = (amount: 0, length: 0, 
  upperCase: true, numbers: true, specialSymbols: true)
  
  print("\nHow many passwords should be generated?")
  choices.amount = getInteger()

  print("\nEnter the length of the passwords (12-16 recommended):")
  choices.length = getInteger()

  print("\nAdd uppercase letters? (Recommended)\nYes / No")
  choices.upperCase = getDecision("Uppercase letter")

  print("\nAdd digits? (Recommended)\nYes / No")
  choices.numbers = getDecision("Digit")

  print("\nAdd symbols (&, ?, @, /, =, $, and so on)? (Recommended)\nYes / No")
  choices.specialSymbols = getDecision("Special symbol")

  return choices
}

// Generating a random character for the password
// according to the user's defined preferences
func getRandomCharacter(_ chosenSymbolTypes: (upperCase: Bool, numbers: Bool, 
specialSymbols: Bool)) -> Character {
  let addUppercase = chosenSymbolTypes.upperCase
  let addDigits = chosenSymbolTypes.numbers
  let addSymbols = chosenSymbolTypes.specialSymbols

  while true {
    let randomNumber = Int.random(in: 0..<100)
    switch randomNumber {
      case 75..<100:
        let lowercase = Array("abcdefghijklmnopqrstuvwxy")
        return lowercase[Int.random(in: 0..<lowercase.count)]
      case 50..<75 where addUppercase:
        let uppercase = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        return uppercase[Int.random(in: 0..<uppercase.count)]
      case 25..<50 where addDigits:
        let digits = Array("0123456789")
        return digits[Int.random(in: 0..<digits.count)]
      case 0..<25 where addSymbols:
        let symbols  = Array("!#$()*+,-./:;<=>?@[]^_{|}~")
        return symbols[Int.random(in: 0..<symbols.count)]
      default:
        break
    }
  }
}

// Generating a given amount of passwords of a given length
while true {
  let allChoices = getChoices()
  let (amount, maxLength, _, _, _) = allChoices
  let chosenSymbolTypes = (allChoices.2, allChoices.3, allChoices.4)

  print("\nYour passwords:")
  for _ in 1...amount {
    var password = String()
    for _ in 1...maxLength {
      password.append(getRandomCharacter(chosenSymbolTypes))
    }
    print(password)
  }

  // Asking if the user wants to generate more passwords
  print("\nGenerate more passwords?")
  if (getYesOrNo() == "no") {
    break
  }
}