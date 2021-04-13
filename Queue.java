/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  File name     :  Queue.java
 *  Purpose       :  Creates a queue using an array
 *  Author        :  Theo Hargis, Yolanda Nosakhare
 *  Date          :  2020-10-22
 *  Description   :  This program demonstrates several things:
 *                   1. insert function for queue
 					 2. remove function for queue
 					 3. printQueue function that prints out all elements of a queue
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  Revision History
 *  ----------------
 *            Rev      Date     Modified by:  Reason for change/modification
 *           -----  ----------  ------------  -----------------------------------------------------------
 *  @version 1.0.0  2020-10-24  Theo & Yolanda  Initial writing and release
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
import java.io.*;

public class Queue {
	private int maxSize; 
	private long[] queArray; 
	private int front; 
	private int rear; 
	private int nItems;
//-------------------------------------------------------------- 
	public Queue(int s) {// constructor
	
		maxSize = s;
		queArray = new long[maxSize]; 
		front = 0;
		rear = -1;
		nItems = 0;
	}
//--------------------------------------------------------------
	public void insert(long j) {	// put item at rear of queue
		if(rear == maxSize-1) {  	// deal with wraparound
			rear = -1;
		}
		queArray[++rear] = j; 	// increment rear and insert
		nItems++;				// one more item
	}

 
//-------------------------------------------------------------- 
	public long remove() {		// take item from front of queue
		long temp = queArray[front++]; 	// get value and incr front 
		if(front == maxSize) {		// deal with wraparound
			front = 0;
		}
		nItems--; 	// one less item 
		return temp;
	}
//-------------------------------------------------------------- 
	public long peekFront() { // peek at front of queue
		return queArray[front];
	}
//--------------------------------------------------------------
	public boolean isEmpty() { // true if queue is empty {
		return (nItems==0);
	} 
//--------------------------------------------------------------
	public boolean isFull() { // true if queue is full {
		return (nItems==maxSize);
	} 
//--------------------------------------------------------------
	public int size() { // number of items in queue {
		return nItems;
	} 
//--------------------------------------------------------------
	
	public void printQueue() {		// display array content
		for (int i = front; i <= maxSize; i++) { 	// tracker starts at the front of queue, not always index 0
			if (nItems == 0) {
				System.out.println("The queue is empty");
				break;
			} else if (i == maxSize) {		// if index reaches last end of list
				i = 0;				// set index back to 0
				System.out.println("index: " + i + " [" + queArray[i] + "] ");
			} else if (i == rear) {		// if index reaches rear
				System.out.println("index: " + i + " [" + queArray[i] + "] ");
				break; 					// break code. whole Queue has been printed
			} else {					// else, keep displaying values
				System.out.println("index: " + i + " [" + queArray[i] + "] ");
			}
			
		}
		

	}
 // end class Queue
}
