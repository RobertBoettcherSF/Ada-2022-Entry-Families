pragma Ada_2022;

package body Spots is

   protected body Board is

      entry Claim (for Id in Slot_Id)
        when not Taken (Id)
      is
      begin
         Taken (Id) := True;
      end Claim;

      procedure Release (Id : Slot_Id) is
      begin
         Taken (Id) := False;
      end Release;

      function Is_Taken (Id : Slot_Id) return Boolean is
      begin
         return Taken (Id);
      end Is_Taken;

   end Board;

end Spots;
