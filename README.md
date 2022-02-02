# wordleBot

Algorithim to finish a game of wordle based on a list of 5757 five letter words from this repo https://github.com/charlesreid1/five-letter-words/blob/master/sgb-words.txt. 
The average amount of attempts was determined to be 4.38509 attempts/word, however some of the least common words could take more than the 6 desired for wordle. Also includes fully functional command line game of wordle. Built in OCaml using only standard libraries List, String, Char, and Random.

Enter "make play" in order to start the game. Enter a 5 letter word to let the bot guess, if the word is invalid then a random word is chosen. Enter "bot" in order to run the algorithim. Also, you can enter test at the beginning to run the test script that tests the attempts needed for every word, however this takes around 8~ hours.



