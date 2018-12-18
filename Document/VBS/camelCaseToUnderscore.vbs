Option Explicit
ValidationMode = True
InteractiveMode = im_Abort

Function camelCaseToUnderscore(str)
   Dim result, l, i, c, p
   '  ���⴦��
   IF "TB" = LEFT(str, 2) THEN
      result = "TB_"
      str = RIGHT(str, LEN(str) - 1)
   ELSE
      result = UCase(LEFT(str, 1))
   END IF
   
   l = LEN(str)
   
   For i = 2 to l
      p = RIGHT(LEFT(str, i - 1), 1)
      c = RIGHT(LEFT(str, i), 1)
      IF c = UCase(c) THEN
         IF p = LCase(p) AND i < l THEN
            result = result & "_"
         END IF
         result = result & UCase(c)
      ELSE
         result = result & UCase(c)
      END IF
   Next
   camelCaseToUnderscore = result
End Function


Dim mdl ' ���嵱ǰ��ģ��

'ͨ��ȫ�ֲ�����õ�ǰ��ģ��
Set mdl = ActiveModel
If (mdl Is Nothing) Then
   MsgBox "û��ѡ��ģ�ͣ���ѡ��һ��ģ�Ͳ���."
ElseIf Not mdl.IsKindOf(PdPDM.cls_Model) Then
   MsgBox "��ǰѡ��Ĳ���һ������ģ�ͣ�PDM��."
Else
   ProcessFolder mdl
End If


'--------------------------------------------------------------------------------
'���ܺ���
'--------------------------------------------------------------------------------
Private Sub ProcessFolder(folder)
   Dim Tab '�������ݱ����
   for each Tab in folder.tables
      if not tab.isShortcut then
         'if tab.comment = "" then tab.comment = tab.name '�����жϲ���ֵ
         tab.code = camelCaseToUnderscore(tab.code)
         Dim col '�����ж���
         for each col in tab.columns
            'if col.comment = "" then col.comment = col.name '�����жϲ���ֵ
            col.code = camelCaseToUnderscore(col.code)
            'col.dataType = camelCaseToUnderscore(col.dataType)
         next
      end if
   next
   
   '���Ӱ����еݹ飬�����ʹ�õݹ�ֻ��ȡ����һ��ģ��ͼ�ڵı�
   dim subfolder
   for each subfolder in folder.Packages
      ProcessFolder subfolder
   next

   'msgbox "��ɰ�commentΪ�յ�������name����"
End Sub
