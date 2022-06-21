package Data is

   -----------------------
   -- Types & Constants --
   -----------------------

   Register_Length : constant Integer := 10;

   subtype Result_Digit_Index is Natural range 1 .. Register_Length;
   subtype Result_Type is Long_Integer   range 01234_56789 .. 98765_43210;

end Data;
