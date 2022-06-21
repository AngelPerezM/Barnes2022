with Data; use Data;

package Solver is
   
   Result_Not_Found : Exception;
   
   function Solve_Barnes (First, Last : Result_Type) return Result_Type;

end Solver;
