/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  File name     :  SimonGame.java
 *  Purpose       :  Creates a rendition of the Simon Game
 *  Author        :  Theo Hargis, Yolanda Nosakhare
 *  Date          :  2020-11-12
 *  Description   :  This program demonstrates several things:
 *                   1. creates a basic layout for a Simon game layout
                     2. Prints out random letters from a list consecutively
                     3. compares the user's response to the sequence of random letters
                     4. The sequence of random letters gradually grows each time the user guesses correctly
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  Revision History
 *  ----------------
 *            Rev      Date     Modified by:  Reason for change/modification
 *           -----  ----------  ------------  -----------------------------------------------------------
 *  @version 1.0.0  2020-11-12  Theo & Yolanda  Initial writing and release
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
import java.util.Random;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;
public class SimonGame {
	public Random randNum = new Random();
	public int sequenceSize;
	public String[] letters = {"R", "B", "G", "Y"};
	public String sequence;

	public SimonGame() {
		sequenceSize = 0;
		sequence = "";

		// initialize sequence with 1 letter
		sequence += letters[randNum.nextInt(4)];
	}

	public String newSequence () {
		String newSeq = "";
		for (int i = 0; i < sequenceSize; i++) {
			// System.out.println("Sequence: " + sequence);
			newSeq += letters[randNum.nextInt(4)];

		}
		return newSeq;
	}

	public static void printWithDelays(String data, TimeUnit unit, long delay) 
	throws InterruptedException {
    for (char ch : data.toCharArray()) {
        System.out.print(ch);
        System.out.print(" ");
        unit.sleep(delay);
	}
}
	public static void main(String args[]) throws Exception {
		SimonGame game = new SimonGame();
		Scanner input = new Scanner(System.in);


		System.out.println("Hello welcome, are you ready?");
		System.out.println("DO NOT USE SPACES!!!");

		game.sequenceSize = 1;
		game.sequence = game.newSequence();
		Boolean winning = true;

		while (winning) {
			System.out.println("Here's the sequence: ");
			TimeUnit.MILLISECONDS.sleep(500);
			printWithDelays(game.sequence, TimeUnit.MILLISECONDS, 1000);
			for (int i = 0; i<=game.sequenceSize*2 - 1; i++) {
				System.out.print("\b ");
				TimeUnit.MILLISECONDS.sleep(300);
				System.out.print("\b");
			}
			System.out.println("Type it like it's hot! ");
			String userSequence = input.next();
			// System.out.println("user input: " + userSequence );

			if (!userSequence.equalsIgnoreCase(game.sequence)) {
				System.out.println("You are WRONG!! \n The correct sequence was:  " + game.sequence + "\n GET BETTER. \n GAME OVER... ");
				winning = false;
			} else {
				game.sequenceSize += 1;
				game.sequence = game.newSequence();
				//System.out.println("sequence size: " + game.sequenceSize);
				//System.out.println("current sequence is: " + game.sequence);
				System.out.println("Great job! Next round... \n");
			}

		}


	}

}