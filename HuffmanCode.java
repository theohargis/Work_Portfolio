/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  File name     :  HuffmanCode.java
 *  Purpose       :  Creates a rendition of a Huffman Tree for coding and decoding a text message
 *  Author        :  Theo Hargis, Yolanda Nosakhare
 *  Date          :  2020-11-12
 *  Description   :  This program demonstrates several things:
 *                   1. takes in a String from the command line and parses it into an array of characters, 
 						while noting their frequencies in a separate array
                     2. creates a node for each unique char along with it's frequency
                     	and places it in a priority Queue, sorted using Comparable implementation
                     3. Gradually creates a single binary tree full of nodes
                     4. printCodes() method takes in a node and a String for the binaryCode, 
                     	constructing a binary code String for each character based on its position in the tree
                     5. decode() method takes in a node and the full coded String and decodes it
                     	based on following the edges of the tree, returning String result which is the original
                     	String passed in.
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  Revision History
 *  ----------------
 *            Rev      Date     Modified by:  Reason for change/modification
 *           -----  ----------  ------------  -----------------------------------------------------------
 *  @version 1.0.0  2020-11-12  Theo & Yolanda  Initial writing and release
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
import java.util.Scanner;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.PriorityQueue;

public class HuffmanCode {
	public static String[] asciiTable = new String[126];
	public static BinaryTreeNode root;
	public static String codedMessage;	
	public static String inputString;

	public static void printCode (BinaryTreeNode node, String prefix ) {
		if (node.isLeaf()) {
			asciiTable[(int) node.data] = prefix;
			return;
		}
		printCode(node.getChild("L"), prefix + "0");
		printCode(node.getChild("R"), prefix + "1");
	}

	public static String decode (BinaryTreeNode current, String code, String result) {
			if (code.length() == 0) {
				return result + current.data;
			} else if (current.isLeaf()) {
				result = result + current.data;			
				result = decode(root, code, result);
				return result;
			} else if (code.charAt(0) == '0') {
				return decode(current.getChild("L"), code.substring(1), result); //result.substring(1)
			} else if (code.charAt(0) == '1') {
				return decode(current.getChild("R"), code.substring(1), result); // result.substring(1)
			}
		return result;					
	}

	public static void main (String args[]) {
		// for every char, count frequency 
		Scanner in = new Scanner(System.in);
    	inputString = in.nextLine();
    	System.out.println("\n \n");
    	int[] freq = new int[inputString.length()];
    	char[] charList = inputString.toCharArray();
    	ArrayList<Character> charAdded = new ArrayList<Character>();

    	// setting frequency list and charList

    	for (int i = 0; i < inputString.length(); i++) {
     		freq[i] = 1;
     		for (int j = i + 1; j < inputString.length(); j++) {
       			if (charList[i] == charList[j] ) {
          			freq[i]++;
        		}
      		}
    	}

    	PriorityQueue<BinaryTreeNode> queue = new PriorityQueue<BinaryTreeNode> (charList.length, new nodeSort());

    	for (int i = 0; i < charList.length; i++) {
    		BinaryTreeNode node = new BinaryTreeNode();
    		node.data = charList[i];
    		node.frequency = freq[i];
    		if (charAdded.contains(node.data) ) {
    			continue;
    		} else {
    			charAdded.add(node.data);
    		}    		
	   		queue.add(node);
    	}

    	// create trees from Priority Queue

    	while (queue.size() > 1) {
    		BinaryTreeNode n1 = queue.poll();
    		BinaryTreeNode n2 = queue.poll();
    		BinaryTreeNode holder = new BinaryTreeNode();
    		holder.frequency = n1.frequency + n2.frequency;
    		holder.left = n1;
    		holder.right = n2;
    		root = holder;
    		queue.add(root);
    	}

    	printCode(root, "");
    	String codedMessage = "";
    	for (int i = 0; i < inputString.length(); i++) {
    		if (asciiTable[(int) inputString.charAt(i)] != null) {
    			codedMessage += asciiTable[(int) inputString.charAt(i)];
    		}
    	}
    	System.out.println("Encoded message: \n" + codedMessage + "\n \n");
    	System.out.println("Decoded message: \n" + decode(root, codedMessage, ""));
	}
}

class nodeSort implements Comparator<BinaryTreeNode> {
  @Override
    public int compare(BinaryTreeNode node1, BinaryTreeNode node2 ) {
    	if (node1.frequency != node2.frequency) {
      		return node1.frequency - node2.frequency;
      	} else {
      		return node1.data - node2.data;
      	}
    }
}