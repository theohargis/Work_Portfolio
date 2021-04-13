
/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  File name     :  Stack.java
 *  Purpose       :  Creates a Stack based on a linked(circular) list 
 *  Author        :  Theo Hargis, Yolanda Nosakhare
 *  Date          :  2020-10-22
 *  Description   :  This program demonstrates several things:
 *                   1. push method that prepends Nodes to stack
                     2. pop method that removes and returns Node at top of stack
                     3. peek method that returns the data value of the top of stack
                     4. main tester method for stack class
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  Revision History
 *  ----------------
 *            Rev      Date     Modified by:  Reason for change/modification
 *           -----  ----------  ------------  -----------------------------------------------------------
 *  @version 1.0.0  2020-10-24  Theo & Yolanda  Initial writing and release
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
public class Stack {

    // Node class
    // contains "value" which holds the data of a specific node
    // as well as "link" which serves as the node object
    private class Node {
        int value;
        Node link;
    }
    // top is a Node object that always points to the top of the stack
    Node top;

    // constructor
    public Stack() {
        this.top = null;
    }

    // returns the value of the top Node of the stack
    public int peek() {
        if (top == null) {
            System.out.println("The stack is empty. ");
            System.exit(-1);
        }
        return top.value;
    }
    // prepends Node to top of the stack and pushes all other values back
    public void push(int val) {
        //list full
        Node holder = new Node();
        if (holder == null) {
            System.out.println("The stack is full. ");
        }
        holder.value = val;
        holder.link = top;
        top = holder;
    }
    // removes the Node at the top of the stack and returns its value
    public int pop() {
        // if list is empty return null
        if (top == null) {
            System.out.println("The stack is already empty");
            System.exit(-1);
        } 
        top = top.link;
        return top.value;
    }

    // main tester method
    public static void main(String[] args) {
        Stack tester = new Stack();
        tester.push(12);
        tester.push(31);
        tester.push(3);
        tester.push(85);
        tester.push(1);

        System.out.println("Peeking the top of the stack: " + tester.peek());

        System.out.println(tester.pop() + " popped. ");
        System.out.println(tester.pop() + " popped. ");
        System.out.println(tester.pop() + " popped. ");
        System.out.println(tester.pop() + " popped. ");
    }

}