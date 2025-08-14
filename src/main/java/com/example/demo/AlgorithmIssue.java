package com.example.demo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class AlgorithmIssue {
    public static void main(String[] args) {
        int[] numbers = {3, 7, 9, 2, 5,8};
        int target = 10;

        System.out.println("Target: " + target);
        System.out.print("Numbers:");
        for (int num : numbers) {
            System.out.print(" " + num);
        }
        System.out.println();

        findAllPairsOptimized(numbers, target);
    }

     public static List<int[]> findAllPairsOptimized(int[] numbers, int target) {
    List<int[]> result = new ArrayList<>();
    
    if (numbers == null || numbers.length < 2) {
        return result;
    }
    
    Set<Integer> seen = new HashSet<>();
    Set<String> uniquePairs = new HashSet<>();
    
    for (int current : numbers) {
        int complement = target - current;
        
        if (seen.contains(complement)) {
            // Create a normalized key to avoid duplicate pairs
            String pairKey = Math.min(current, complement) + "," + Math.max(current, complement);
            
            if (uniquePairs.add(pairKey)) {
                result.add(new int[]{Math.min(current, complement), Math.max(current, complement)});
            }
        }
        seen.add(current);
    }
    
    return result;
}
}
