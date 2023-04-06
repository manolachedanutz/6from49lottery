import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

public class Lottery {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        boolean playAgain = true;
        int totalGuesses = 0;
        int totalCorrectGuesses = 0;
        int totalWins = 0;

        while (playAgain) {
            List<Integer> userNumbers = new ArrayList<>();

            System.out.println("Enter your 6 numbers (between 1 and 49):");
            for (int i = 0; i < 6; i++) {
                System.out.print("Enter number " + (i + 1) + ": ");
                int userNumber = scanner.nextInt();
                while (userNumber < 1 || userNumber > 49 || userNumbers.contains(userNumber)) {
                    if (userNumbers.contains(userNumber)) {
                        System.out.print("Number already entered. Enter number " + (i + 1) + ": ");
                    } else {
                        System.out.print("Invalid number. Enter number " + (i + 1) + ": ");
                    }
                    userNumber = scanner.nextInt();
                }
                userNumbers.add(userNumber);
            }
            
            int[] lotteryNumbers = new int[6];
            Random random = new Random();

            for (int i = 0; i < 6; i++) {
                int randomNumber;

                // Check if the random number is already in the array
                do {
                    randomNumber = random.nextInt(49) + 1;
                } while (contains(lotteryNumbers, randomNumber));

                lotteryNumbers[i] = randomNumber;
            }

            Arrays.sort(lotteryNumbers);

            System.out.println("The lottery numbers are: " + Arrays.toString(lotteryNumbers));

            int correctGuesses = 0;
            List<Integer> guessedNumbers = new ArrayList<>();
            for (int userNumber : userNumbers) {
                if (contains(lotteryNumbers, userNumber)) {
                    correctGuesses++;
                    guessedNumbers.add(userNumber);
                }
            }

            totalGuesses++;
            totalCorrectGuesses += correctGuesses;

            if (correctGuesses == 6) {
                totalWins++;
                System.out.println("Congratulations! You won the lottery!");
            } else {
                System.out.println("Better luck next time!");
            }

            if (guessedNumbers.isEmpty()) {
                System.out.println("You didn't guess any numbers correctly.");
            } else {
                System.out.println("You guessed these numbers correctly: " + guessedNumbers);
            }

            double percentage = (double) correctGuesses / 6 * 100;
            System.out.println("You guessed " + percentage + "% of the lottery numbers.");

            double averageGuesses = (double) totalCorrectGuesses / totalGuesses;
            System.out.println("On average, you guessed " + averageGuesses + " numbers correctly per game.");

            double winPercentage = (double) totalWins / totalGuesses * 100;
            System.out.println("You won " + winPercentage + "% of the games you played.");

            System.out.print("Do you want to play again? (y/n) ");
            String playAgainResponse = scanner.next();
            while (!playAgainResponse.equals("y") && !playAgainResponse.equals("n")) {
                System.out.print("Invalid response. Do you want to play again? (y/n) ");
                playAgainResponse = scanner.next();
            }

            if (playAgainResponse.equals("n")) {
                playAgain = false;
            }
        }

        System.out.println("Thanks for playing the 6/49 lottery!");
    }

    private static boolean contains(int[] array, int value) {
        for (int element : array) {
            if (element == value) {
                return true;
            }
        }
        return false;
    }
}

