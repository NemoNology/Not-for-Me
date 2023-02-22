program Loops_and_Arrays;

{$APPTYPE CONSOLE}

var
  n, i: Byte;
  A : array of Shortint;
  // Shortint - 1 byte - because we need to don't go out of range of 2 bytes

  sum : Smallint;

  // Given: natural number n and integer numbers a1..an
  // Task:  calculate a1 - a2 + a3 - ... + (-1)^(n + 1) * an


begin

  Write('Input n (1, 255): ');
  Read(n);
  Write(Chr(10));

  SetLength(A, n);

  for i := 0 to n - 1 do begin

    Write('Input a[', i + 1, '] (-128..127): ');
    Read(A[i]);

  end;

  asm

    xor SI, SI    // SI - Counter
    xor AX, AX    // Clean AX for future
    mov AX, -1    // It's our (-1)^(n+1)
    xor CX, CX    // There is will be result sum
    mov EBX, 0    // Clear EBX, as we are going to use EBX
    mov EBX, A    // In EBX storage pointer on our array A

    @Loop:

      // Command Push - save value from REG in Special Stack
      // Command Pop load value from Special Stack in REG

      xor DX, DX                // Clean DX for future
      dec WORD (DX)             // DX = -1

      IMUL WORD (DX)            // AX = (-1)^i

      push WORD (AX)            // Saving (-1)^i
      push WORD (AX)            // First for DX, Second for AX

      xor AX, AX                // Clean AX for future
      mov AL, BYTE ([EBX])      // Save A[SI] in AL, AX = AH:AL

      // Now AX = AH:AL (00000000:A[i])
      // If A[i] < 0 AX will be calculated as number > 0
      // So we need to fill AH with AL sign bit
      // There is a command CBW, that fill AH with AL sign
      // We will use this command

      cbw

      pop WORD (DX)             // Restore (-1)^i in DX

      imul WORD (DX)            // AX = A[i] * (-1)^i
      add CX, WORD (AX)         // Sum += AX

      pop WORD (AX)             // Restore (-1)^i in AX

      inc SI                    // Increase Counter
      INC EBX                   // Going to next Array Element


      cmp SI, WORD (n)          // Check if it's end of loop
      jne @Loop                 // If not - go back...

      mov sum, CX               // Saving sum

  end;

  // You can place stop point here...
  Writeln(Chr(10), 'Calculated sum: ', sum, Chr(10), Chr(10), 'Program is ended. Press Enter to close');
  // 2 ReadLn's, because one is not enougth
  Readln; Readln;

end.
