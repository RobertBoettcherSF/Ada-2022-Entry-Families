pragma Ada_2022;

with Ada.Assertions; use Ada.Assertions;
with Ada.Text_IO; use Ada.Text_IO;
with Spots;

procedure Tests is
   B : Spots.Board;

   task type Grabber is
      entry Start (Id : Spots.Slot_Id);
      entry Done;
   end Grabber;

   task body Grabber is
      Slot : Spots.Slot_Id;
   begin
      accept Start (Id : Spots.Slot_Id) do
         Slot := Id;
      end Start;
      if not Slot'Valid then
         raise Program_Error;
      end if;
      B.Claim (Slot);
      accept Done;
   end Grabber;

begin
   B.Claim (1);
   Assert (B.Is_Taken (1));
   Assert (not B.Is_Taken (2));
   B.Release (1);
   Assert (not B.Is_Taken (1));
   Put_Line ("PASS Claim/Release family index 1");

   declare
      G2 : Grabber;
      G3 : Grabber;
   begin
      G2.Start (2);
      G3.Start (3);
      G2.Done;
      G3.Done;
      Assert (B.Is_Taken (2) and then B.Is_Taken (3));
      B.Release (2);
      B.Release (3);
   end;
   Put_Line ("PASS concurrent Claim on distinct family entries");

   declare
      task Waiter is
         entry Go;
         entry Done;
      end Waiter;
      task body Waiter is
      begin
         accept Go;
         B.Claim (1);
         accept Done;
      end Waiter;
   begin
      B.Claim (1);
      Waiter.Go;
      delay 0.05;
      Assert (B.Is_Taken (1));
      B.Release (1);
      Waiter.Done;
      Assert (B.Is_Taken (1));
      B.Release (1);
   end;
   Put_Line ("PASS family barrier wakes waiter");

   Put_Line ("All Entry Families topic tests passed.");
end Tests;
