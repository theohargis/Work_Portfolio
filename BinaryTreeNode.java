/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  File name     :  BinaryTreeNode.java
 *  Purpose       :  Creates a base class for a Node to be used in a Binary Tree
 *  Author        :  Theo Hargis, Yolanda Nosakhare
 *  Date          :  2020-11-12
 *  Description   :  This program demonstrates several things:
 *                   1. Constructor for a Binary Tree node, including a data, frequency, left, and right value
                     2. returns children of node
                     3. isLeaf() method checks if the node is null
                     4. toString() method prints the node data value
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  Revision History
 *  ----------------
 *            Rev      Date     Modified by:  Reason for change/modification
 *           -----  ----------  ------------  -----------------------------------------------------------
 *  @version 1.0.0  2020-11-12  Theo & Yolanda  Initial writing and release
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
import java.util.Scanner;
import java.util.Collections;
import java.util.PriorityQueue;
import java.util.Comparator;

public class BinaryTreeNode {

  public char data;
  public int frequency;
  public BinaryTreeNode left;
  public BinaryTreeNode right;

  public BinaryTreeNode () {
    this.data = data;
    this.left = null;
    this.right = null;
    this.frequency = 0;
  }

  public BinaryTreeNode getChild( String child ) {
    child = child.toUpperCase();
    if( child.equals("L") || child.equals("R") ) {
      return (child.equals("L") ? left : right);
    } else {
      throw new IllegalArgumentException();
    }
  }

  public int getString() {
    return data;
  }

  public boolean isLeaf() {
    return (this.getChild("L") == null) && (this.getChild("R") == null);   
  }
}