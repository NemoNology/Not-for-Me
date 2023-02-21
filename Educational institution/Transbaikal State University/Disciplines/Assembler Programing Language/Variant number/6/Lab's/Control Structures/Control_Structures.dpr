program Control_Structures;

{$APPTYPE CONSOLE}

var

  // Smallint chosen, because double multiplication can be big
  x, y : Smallint;

begin

  Writeln('Input short integer (-128..128) x:');
  Read(x);
  Writeln('Input short integer y (y != x):');
  Read(y);

  asm

    mov AX, x
    cmp AX, y

    jl @XisLess  // Jl: O1 < O2
    jg @YisLess  // JG: O1 > O2
    je @Exit     // JE: O1 = O2

    // x = (x + y) / 2
    // y = (x * y) * 2
    @XisLess:

      mov CX, x       // Saving x
      add AX, y       // X is in reg AX, so we just add y to AX
      mov BX, 2       // Mov 2 ib BX, because we are going to div AX by 2
      div BX          // Div AX (x + y) by 2
      mov x, AX       // Saving result (Half sum) in x

      mov AX, CX      // Restore x in AX
      imul y          // Getting multiplication - (x * y)
      mov y, 2        // Because we can mul only by register or var, so we just mov 2 in y
      imul y          // Getting double multiplication - (x * y) * 2
      mov y, AX       // Saving result in x

      jmp @Exit

    // y = (x + y) / 2
    // x = (x * y) * 2
    @YisLess:

      mov CX, y       // (See @XisLess)
      add AX, y
      mov BX, 2
      div BX
      mov y, AX

      mov AX, CX
      imul x
      mov x, 2
      imul x
      mov x, AX

    @Exit:

      // Label for jmp from @XisLess or when x = y

  end;


  Writeln('Result x = ', x);
  Writeln('Result y = ', y);

  // 2 ReadLn's, because one is not enougth
  Writeln('Program is ended. Press Enter to close');
  Readln; Readln;

end.
