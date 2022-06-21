with Ada.Text_IO;   use Ada.Text_IO;
with Data;          use Data;
with Solver;

with Ada.Characters.Latin_1;

package body Worker is
   
   -- Private Functions definition
   -- ============================
   procedure Get_First_And_Last (Count     : in  Long_Integer;
                                 Chunk     : in  Result_Type;
                                 N_Workers : in  Positive;
                                 First,
                                 Last      : out Result_Type);
   
   -- Protected Objects (PO)
   -- ======================
   
   protected Workers_Barrier is
      entry     Wait;
      procedure Start_Workers;
   private
      Has_Signaled : Boolean := False;
   end Workers_Barrier;   
   
   -- Body of POs
   -- ===========
   
   protected body Workers_Barrier is      
      ----------
      -- Wait --
      ----------
      entry Wait when Has_Signaled is
      begin
         null;
      end Wait;
      
      -------------------
      -- Start Workers --
      -------------------
      procedure Start_Workers is
      begin
         Has_Signaled := True;           
      end Start_Workers;   
      
   end Workers_Barrier;
   
   
   -- Tasks bodys
   -- ===========
   
   ----------------------
   -- Worker_Task Body --
   ----------------------
   task body Worker_Task is
      Result : Result_Type;
   begin
      
      Workers_Barrier.Wait;
          
      Put_Line("From " & First'Image &
               Ada.Characters.Latin_1.HT & " up to " & Last'Image &
               Ada.Characters.Latin_1.HT & ". Chunk size: " & Long_Integer'Image(Last - First));
      
      begin
         Result := Solver.Solve_Barnes (First, Last);
      exception
         when Solver.Result_Not_Found =>
            Put_Line ("Did not find the result");
         when others =>
            Put_Line ("Unknown error");
      end;
      
      Put_Line("The Result is: " & Result'Image);
            
   end Worker_Task;
   
   -- Provided Interfaces implementation
   -- ==================================
       
   -------------------
   -- Start_Workers --
   -------------------
   procedure Start_Workers (Number_Of_Workers : in Positive) is
      type Ptr_Worker is access Worker_Task;      
      
      Workers : array (1 .. Number_Of_Workers) of Ptr_Worker;
      
      Count   : Long_Integer := 1;
      
      Chunk   : Result_Type  := (Result_Type'Last - Result_Type'First + 1) /
                                (Long_Integer(Number_Of_Workers));
   begin
      
      Ada.Text_IO.Put_Line ("[Worker] Creating workers");
      for W of Workers loop         
         declare
            First, Last : Result_Type;
         begin            
            Get_First_And_Last (Count, Chunk, Number_Of_Workers, First, Last);                                    
            W := new Worker_Task (First, Last);        
         end;
         
         Count := Count + 1;
      end loop;
         
      Workers_Barrier.Start_Workers;
      Ada.Text_IO.Put_Line ("[Worker] After Start_Workers barrier");
      
   end Start_Workers;
      
   procedure Get_First_And_Last (Count     : in  Long_Integer;
                                 Chunk     : in  Result_Type;
                                 N_Workers : in  Positive;
                                 First,
                                 Last      : out Result_Type) is
   begin
      First := Result_Type'First + ((Count - 1) * Chunk);
      
      if Count >= Long_Integer(N_Workers) then
         Last := Result_Type'Last;
      else
         Last := First + Chunk - 1;
      end if;
   end Get_First_And_Last;
   
   
-- Initialization for worker package
-- =================================
begin     
   
   Ada.Text_IO.Put_Line ("[Worker] Started!");
   
end Worker;
