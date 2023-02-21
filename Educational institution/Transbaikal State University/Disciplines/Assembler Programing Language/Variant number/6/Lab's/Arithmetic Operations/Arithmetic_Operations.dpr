program Arithmetic_Operations;

{$APPTYPE CONSOLE}

  

// Объявление
// Declaration
var
  Fi, MinuteArrowAngle : Word;
  EndKey : ShortString; // For ReadLn at the program end

begin

  Writeln('Input angle Fi (0 < Fi < 360):');
  Read(Fi);

  asm

    mov AX, Fi
    mov BX, 30
    div BX

    mov AX, DX
    mov bx, 12
    mov CL, DL
    mul bx

    mov MinuteArrowAngle, AX

  end;

  Writeln('Calculated minute arrow angle:');
  Writeln(MinuteArrowAngle);

  // 2 ReadLn's, because one is not enougth
  Writeln('Program is ended. Press Enter to close'); Readln; Readln;


end.


// Решение:
// 
// В час часовая стрелка проходит 360 / 12 = 30 градусов
// Т.к. в часу 60 минут, то за минуту часовая стрелка проходит 30 / 60 = 0.5 градуса
// В минуту минутная стрелка проходит 360 / 60 = 6 градусов
// Т.к. в часу (30 градусов) 60 минут, то 1 градус часовой стрелки = 2 минуты
// Начало отсчёта часов = 0 (12) часов = 0 (360) градусов
//
//
// Формула расчёта текущего часа и минут:
// Угол между часовой стрелкой (Fi) / 30
//
// Итог:
// Целочисленный результат деления = час (от 0 до 12)
// Остаток от деления = минуты / 2
//
// 
// Формула расчёта угла минутной стрелки:
// Минуты * 2 * градусы, которые в минуту проходит минутная стрелка
// (Минуты * 12)



// Eng:
//
// Solution:
//
// In hour at the clock's, hour arrow passes by 360 / 12 = 30 degrees
// In minute at the clock's, hour arrow passes by 30 / 60 = 0.5 degrees
// In minute at the clock's, minute arrow passes by 360 / 60 = 6 degrees
// 1 hour arrow degree = 2 minutes (Because hour (30 degrees) is 60 minutes)
// Start angle - 0 (12) hour at the clock's - 0 (360) degrees
//
//
// Formula for calculating the current hour and minutes:
// Fi (Angle between hour arrow and start angle) / 30
//
// Result:
// Integer result from division = current hour (from 0 to 12)
// ОRemainder of the division = current minutes / 2
//
// 
// Formula for calculating the angle between minute arrow and start angle:
// Current minutes * 2 * degree that minetes arrow passes in minute
// (Current minutes * 12)
