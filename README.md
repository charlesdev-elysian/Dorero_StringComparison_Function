# String Comparison Program (Emu8086)

## Overview
This assembly language program compares two user-inputted strings using the **Emu8086** assembler. The comparison can be performed with or without case sensitivity based on user preference.

## Features
- Accepts two strings from the user.
- Allows user to choose **case-sensitive** or **case-insensitive** comparison.
- Displays whether the strings are **equal** or **not equal**.
- Uses **interrupts** for input/output operations.

## Requirements
- **Emu8086 Assembler**
- DOS-based environment or an emulator like **DOSBox**

## How It Works
1. The program prompts the user to **enter the first string**.
2. It then asks for the **second string**.
3. The user is asked if the comparison should be **case-sensitive** (`1` for Yes, `0` for No).
4. The program compares both strings and displays the **result**:
   - **Equal:** "Strings are equal. Result: 1"
   - **Not Equal:** "Strings are not equal. Result: 0"

## Code Breakdown
### Data Section
```assembly
msg1 db 'Enter first string: $'
msg2 db 'Enter second string: $'
msg3 db 'Case sensitive? (1=Yes, 0=No): $'
result_eq db 'Strings are equal. Result: 1$'
result_neq db 'Strings are not equal. Result: 0$'
buffer1 db 50, ?, 50 dup('$') ; Buffer for first string
buffer2 db 50, ?, 50 dup('$') ; Buffer for second string
case_flag db 0 ; 0 = Case Insensitive, 1 = Case Sensitive
```

### Main Execution Steps
1. **Print prompts** and **accept user input**.
2. **Read user choice** for case sensitivity.
3. **Check if the lengths of the two strings match**.
4. **Compare each character**:
   - If case-sensitive, perform a **direct comparison**.
   - If case-insensitive, **convert both characters to uppercase** before comparing.
5. **Display result message** based on comparison.
6. **Exit the program**.

### Key Functions
#### `newline` (Helper function to print a newline)
```assembly
newline proc
    mov ah, 2
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    ret
newline endp
```

## Running the Program
1. **Open Emu8086**.
2. **Load the assembly file** (`.asm`).
3. **Assemble and run the program**.
4. **Follow the on-screen instructions** to enter two strings and choose case sensitivity.
5. **View the result** displayed on the screen.

## Example Usage
```
Enter first string: hello
Enter second string: Hello
Case sensitive? (1=Yes, 0=No): 0
Strings are equal. Result: 1
```

```
Enter first string: test
Enter second string: TEST
Case sensitive? (1=Yes, 0=No): 1
Strings are not equal. Result: 0
```

## Notes
- The program only supports **strings up to 50 characters**.
- Case-insensitive comparison converts lowercase letters to uppercase before comparison.
- Press **any key** to exit after displaying the result.

## Author
**Charles Jazon Y. Dorero**

---

