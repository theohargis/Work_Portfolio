/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  File name     :  CircularList.java
 *  Purpose       :  Creates a Circular List 
 *  Author        :  Theo Hargis, Yolanda Nosakhare
 *  Date          :  2020-10-22
 *  Description   :  This program demonstrates several things:
 *                   1. insert method for circular list
                     2. delete method for circular list
                     3. search method for circular list
                     4. step method for circular list
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  Revision History
 *  ----------------
 *            Rev      Date     Modified by:  Reason for change/modification
 *           -----  ----------  ------------  -----------------------------------------------------------
 *  @version 1.0.0  2020-10-24  Theo & Yolanda  Initial writing and release
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
public class CircularList {
    public Link current; 


    public CircularList() {
        this.current = null;
    }

    /**
     * This method displays our list or prints an empty message if our list is empty.
     */
    public void display() {
        if (this.current == null) {
            System.out.println("Yo, this List is empty bruh!");
            return;
        }

        Link check = this.current;
        boolean flag = true;
        while (this.current != check || flag){
            current.displayLink();
            flag = false;
            step();
        }
    }

    /**
     * @param key for current list
     * @param val value
     */
    public void insert(int key, int val) {
        // if list is empty
        if (this.current == null) {
            this.current = new Link(key, val);
            this.current.next = this.current;
            return;
        }

        // if list is not empty
        Link newLink = new Link(key, val, this.current.next);
        this.current.next = newLink;
    }

    /**
     * This method handles searching for the link.
     * @param key to be search
     * @return link if found, otherwise return null
     */
    public Link search(int key) {
        if (this.current == null) {
            return null;
        }

        Link check = this.current;
        boolean flag = true;
        while (this.current != check || flag){
            if (this.current.key == key) {
                return this.current;
            }
            flag = false;
            step();
        }
        return null;
    }

    /**
     * This method handles deletion
     * @param key
     * @return
     */
    public Link delete(int key) {
        // if list is empty return null
        if (this.current == null)
            return null;
        // if list is not empty and has only single node
        if (this.current.next == this.current) {
            Link deleted = this.current;
            this.current = null;
            return deleted;
        }

        Link check = this.current;
        boolean flag = true;
        while (this.current != check || flag){
            if (this.current.next.key == key) {
                Link deleted = this.current.next;
                this.current.next = this.current.next.next;
                return deleted;
            }
            flag = false;
            step();
        }
        return null;
    }

    /**
     * This method sets our current link to our next link
     */
    public void step() {
        this.current = this.current.next;
    }
}