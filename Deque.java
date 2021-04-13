/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  File name     :  Deque.java
 *  Purpose       :  Creates a deque using an array
 *  Author        :  Theo Hargis, Yolanda Nosakhare
 *  Date          :  2020-10-22
 *  Description   :  This program demonstrates several things:
 *                   1. insertRight function for deque
 					 2. insertLeft function for deque
 					 3. removeLeft function for deque
 					 4. removeRight function for deque
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  Revision History
 *  ----------------
 *            Rev      Date     Modified by:  Reason for change/modification
 *           -----  ----------  ------------  -----------------------------------------------------------
 *  @version 1.0.0  2020-10-24  Theo & Yolanda  Initial writing and release
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
public class Deque {
	private int maxSize; 
	private long[] queArray; 
	private int front; 
	private int rear; 
	private int nItems;
//-------------------------------------------------------------- 
	public Deque(int s) {// constructor
	
		maxSize = s;
		queArray = new long[maxSize]; 
		front = 0;
		rear = -1;
		nItems = 0;
	}
//--------------------------------------------------------------
	public void insertRight(long j) {	// insert item at the rear of queue
		if(rear == maxSize-1) {  	// deal with wraparound
			rear = -1;
		}
		queArray[++rear] = j; 	// increment rear and insert
		nItems++;				// one more item
	}

	 // insert a value at an index in the list
     //  if there's not enough room, add more slots
    
	public void insertLeft(long j) {	// insert item at the front of deque (prepend)
		if (!isFull()) {
			if (front == 0) {        
            	front = maxSize;
        	}
        	queArray[--front] = j;         
        	nItems++;                     
		} else {
			System.out.println("The Deque is full. ");
		}
	}

 
//-------------------------------------------------------------- 
	public long removeLeft() {		// take item from front of queue
		long temp = queArray[front++]; 	// get value and incr front 
		if(front == maxSize) {		// deal with wraparound
			front = 0;
		}
		nItems--; 	// one less item 
		return temp;
	}

	public long removeRight() {
		if (isEmpty()) {
			throw new RuntimeException("The Deque is empty. ");
		} 

		long holder = queArray[rear];
        rear--;
        if (rear < 0)
            rear = maxSize - 1;
        nItems--;   
        return holder;
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

	public static void main(String[] args) {
		Deque theDeque = new Deque(5);	// queue holds 5 items
		theDeque.insertRight(10); 	 // insert 4 items
		theDeque.insertRight(20); 
		theDeque.insertRight(30); 
		theDeque.insertRight(40);
		System.out.println("Inserting on 91 on left ");
		theDeque.insertLeft(91);
		System.out.println("Removing from rear of Deque ");
		theDeque.removeRight();

		while( !theDeque.isEmpty() ) {		// remove and display all items
			long n = theDeque.removeLeft(); // (40, 50, 60, 70, 80) 
			System.out.print(n);
			System.out.println(" ");
		}
	}
}

	
