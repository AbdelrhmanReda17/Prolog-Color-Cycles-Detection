# Color Cycles Detection using Prolog
This Prolog program aims to solve the color cycle puzzle. Given a board consisting of cells with colors (Red, Yellow, or Blue), the program searches for cycles of at least 4 cells with the same color that are adjacent to each other.

### Requirements
Prolog interpreter (e.g., SWI-Prolog)

### Usage
1. Clone the repository to your local machine:
  ```git clone https://github.com/AbdelrhmanReda17/color-cycle-solver.git```
2. Navigate to the project directory:
```cd prolog-color-cycles-detection```
3. Run the Prolog program:
```swipl color-detection.pl```
4. The program will output either a color cycle found or a message indicating that no cycles exist.


### More Detailed : 
![image](https://github.com/AbdelrhmanReda17/Prolog-Color-Cycles-Detection/assets/90706154/8a8ad706-4f3a-418d-a921-c400a4d9e816)
-  For example, as shown in the picture, cells 2,1 -> 2,2 -> 3,2 -> 3,1 form a blue cycle  
  NOTE : Another cycle could be cells 2,0 -> 2,1 -> 3,1 -> 3,0

- Example Input: ``?- detect_cycles([[yellow, yellow , yellow ,red], [blue, yellow, blue , yellow], [blue, blue , blue, yellow] ,[blue, blue , blue, yellow] ]). ``
- Example Output:
```
  blue cycle found: [[2,0],[3,0],[3,1],[3,2],[2,2],[2,1]]
  blue cycle found: [[2,0],[3,0],[3,1],[2,1]]
  blue cycle found: [[2,0],[2,1],[3,1],[3,0]]
  blue cycle found: [[2,0],[2,1],[2,2],[3,2],[3,1],[3,0]]
  blue cycle found: [[2,1],[3,1],[3,2],[2,2]]
  blue cycle found: [[2,1],[3,1],[3,0],[2,0]]
  blue cycle found: [[2,1],[2,2],[3,2],[3,1]]
```
