'��pd����ôname���Զ���ӵ�comment����
'���commentΪ��,������name;�����Ϊ��,��������,�������Ա������е�ע�Ͷ�ʧ.
 
Option Explicit
ValidationMode = True
InteractiveMode = im_Batch

Dim mdl ' the current model
Dim i
Dim wsh

' get the current active model
Set mdl = ActiveModel
If (mdl Is Nothing) Then
   MsgBox "There is no current Model"
ElseIf Not mdl.IsKindOf(PdPDM.cls_Model) Then
   MsgBox "The current model is not an Physical Data model."
Else
   ProcessFolder mdl
End If

' This routine copies the name into code for each table, column and view
' of the current folder
Private sub ProcessFolder(folder)
   Dim Tab 'running  table

   for each Tab in folder.tables
      if not tab.isShortcut then
         if trim(tab.comment)="" then 
            tab.comment=tab.name
         end if
         Dim col ' running column
         for each col in tab.columns
            if trim(col.comment)="" then
               col.comment=col.name
            end if
         next
      end if
   next

   Dim view 'running view
   for each view in folder.Views
      if not view.isShortcut and trim(view.comment)="" then
         view.comment = view.name
      end if
   next

   ' go into the sub-packages
   Dim f ' running folder
   For Each f In folder.Packages
      if not f.IsShortcut then
         ProcessFolder f
      end if
   Next
end sub
output "over"
