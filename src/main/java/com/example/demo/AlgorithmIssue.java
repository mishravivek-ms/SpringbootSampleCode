package com.example.demo;

import java.util.HashSet;
import java.util.Set;

public class AlgorithmIssue {public static void main(String[] args) {
        int[] numbers = {3, 7, 9, 2, 5,1,8};
        int target = 10;

        System.out.println("Target: " + target);
        System.out.print("Numbers:");
        for (int num : numbers) {
            System.out.print(" " + num);
        }
        System.out.println();

        findPair(numbers, target);
    }

    public static void findPair(int[] numbers, int target) {
    Set<Integer> seen = new HashSet<>();
    boolean pairFound = false;

    for (int number : numbers) {
        int complement = target - number;
        if (seen.contains(complement)) {
            System.out.println("Pair found: " + complement + " + " + number + " = " + target);
            pairFound = true;
            // If you want only one pair, you can return here.
        }
        seen.add(number);
    }

    if (!pairFound) {
        System.out.println("No pair found with the given target.");
    }
}

}
