--  Ada 2022 topic: protected entry families.
pragma Ada_2022;

package Spots is

   subtype Slot_Id is Integer range 1 .. 3;

   type Taken_Array is array (Slot_Id) of Boolean;

   protected type Board is
      entry Claim (Slot_Id);
      procedure Release (Id : Slot_Id);
      function Is_Taken (Id : Slot_Id) return Boolean;
   private
      Taken : Taken_Array := [others => False];
   end Board;

end Spots;
