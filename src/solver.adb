package body Solver is

   ------------------
   -- Is_Divisible --
   ------------------
   function Is_Divisible (X : in Long_Integer;
                          Y : in Positive)
   return Boolean is ((X mod Long_Integer(Y)) = Long_Integer(0));

   -------------------
   -- Is_The_Result --
   -------------------
   function Is_The_Result (Test : Result_Type) return Boolean is
      Used     : array (Integer range 0 .. 9) of Boolean := (others => False);
      Digit    : Integer := 0;
      Part     : Long_Integer := Test;
   begin

      for Up_To in reverse Result_Digit_Index'Range loop
         Digit := Integer (Part mod Long_Integer(10));
         -- obtain last digit

         if Used (Digit) or else
           not Is_Divisible(Part, Up_To)
         then
            return false;
         end if;

         Used (Digit) := True;
         -- update lut

         Part := Part / Long_Integer(10);
         -- remove last digit.
      end loop;

      return True;
   end Is_The_Result;

   ------------------
   -- Solve_Barnes --
   ------------------
   -- \brief Solve Barnes' puzzle from AEiC 2022.
   function Solve_Barnes (First, Last : Result_Type) return Result_Type is
      Result : Result_Type := First;
   begin

      while Result <= Last loop
         exit when Is_The_Result (Result);
         
         -- At this point we did not find the result and are retrying:
         if (Result = Last) then
            raise Result_Not_Found;
         end if;
         
         Result := Result + 1;
      end loop;

      return Result;

   end Solve_Barnes;

end Solver;
