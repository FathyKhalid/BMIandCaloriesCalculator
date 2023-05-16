import java.util.Scanner;

public class BMICalculator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Print the Welcome Message
        System.out.println("=================================");
        System.out.println("    Welcome To BMI Calculator    ");
        System.out.print("=================================");

        while (true) {
            // Print the Menu
            System.out.println("\n\n 1.New BMI Calculation \n 2.Calculate Calories\n 3.End The Program\n");

            // Prompt user for Choice
            System.out.print(" Enter your Choice (1 - 3): ");
            int choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    // Calculate BMI
                    System.out.print("\n Enter your height (in cm): ");
                    float height = scanner.nextFloat();

                    System.out.print(" Enter your weight (in kg): ");
                    float weight = scanner.nextFloat();

                    // Calculate BMI
                    float bmi = weight / ((height / 100) * (height / 100));

                    // Display result
                    System.out.println("\n -> Your BMI is: " + bmi);

                    // Check BMI status
                    if (bmi < 18) {
                        System.out.println(" -> You're Underweight");
                    } else if (bmi < 25) {
                        System.out.println(" -> You're in Shape (Normal Weight)");
                    } else if (bmi < 30) {
                        System.out.println(" -> You're OverWeight");
                    } else {
                        System.out.println(" -> You're Obese");
                    }
                    break;

                case 2:
                    // Calculate Calories
                    System.out.print("\n Enter your height (in cm): ");
                    float heightCal = scanner.nextFloat();

                    System.out.print(" Enter your weight (in kg): ");
                    float weightCal = scanner.nextFloat();

                    System.out.print(" Enter your age: ");
                    float age = scanner.nextFloat();

                    // Calculate Calories
                    float maintainCal = (float) ((10.0 * weightCal) + (7.45 * heightCal) + (5 * age) + 5);
                    float loseWeightCal = maintainCal - 450;
                    float gainWeightCal = maintainCal + 450;

                    // Print the number of calories needed per day (Maintain)
                    System.out.println("\n -> Your Maintain Calories is " + (int) maintainCal);

                    // Print the number of calories needed per day (Lose Weight)
                    System.out.println(" -> Your Weight Loss Calories is " + (int) loseWeightCal);

                    // Print the number of calories needed per day (Gain Weight)
                    System.out.println(" -> Your Weight Gain Calories is " + (int) gainWeightCal);
                    break;

                case 3:
                    // Exit program
                    System.out.println("\n Stay Healthy and Happy Goodbye! :)");
                    scanner.close();
                    return;

                default:
                    System.out.println("\n Invalid Choice! :( ");
                    break;
            }
        }
    }
}