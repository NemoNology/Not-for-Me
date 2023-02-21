program Arithmetic_Operations;

{$APPTYPE CONSOLE}

  

// ����������
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


// �������:
// 
// � ��� ������� ������� �������� 360 / 12 = 30 ��������
// �.�. � ���� 60 �����, �� �� ������ ������� ������� �������� 30 / 60 = 0.5 �������
// � ������ �������� ������� �������� 360 / 60 = 6 ��������
// �.�. � ���� (30 ��������) 60 �����, �� 1 ������ ������� ������� = 2 ������
// ������ ������� ����� = 0 (12) ����� = 0 (360) ��������
//
//
// ������� ������� �������� ���� � �����:
// ���� ����� ������� �������� (Fi) / 30
//
// ����:
// ������������� ��������� ������� = ��� (�� 0 �� 12)
// ������� �� ������� = ������ / 2
//
// 
// ������� ������� ���� �������� �������:
// ������ * 2 * �������, ������� � ������ �������� �������� �������
// (������ * 12)



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
// �Remainder of the division = current minutes / 2
//
// 
// Formula for calculating the angle between minute arrow and start angle:
// Current minutes * 2 * degree that minetes arrow passes in minute
// (Current minutes * 12)
