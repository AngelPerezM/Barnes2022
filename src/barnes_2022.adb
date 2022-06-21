with Ada.Text_IO;   use Ada.Text_IO;
with Data;          use Data;
with Solver;
with Worker;

-- The result must be: 3816547290 :-)
procedure Barnes_2022 is
   -- Result_Seq : Result_Type;
begin

   -- Parallel:
   Worker.Start_Workers (8);

   --Sequential:
   --Result_Seq := Solver.Solve_Barnes (Result_Type'First, Result_Type'Last);

   --Put_Line ("[Sequential] Eureka! The unique answer is:" & Result_Seq'Image);

   Put_Line ("End of program");
end Barnes_2022;
