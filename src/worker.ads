with Data; use Data;

package Worker is
   
   procedure Start_Workers (Number_Of_Workers : in Positive);

private
   
   task type Worker_Task ( First : Result_Type;
                           Last  : Result_Type );
end Worker;
