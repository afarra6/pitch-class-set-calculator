GDPC                p                                                                         T   res://.godot/exported/133200997/export-551f1c4f0f029b63325153e9af066444-pc_calc.scn p-      {       ��C�u� �(� �#bt    ,   res://.godot/global_script_class_cache.cfg   �             ��Р�8���8~$}P�    X   res://.godot/imported/PSCalc 432 Background.png-4bbef8db5aae212ff2f5242b360495d8.ctex   �Q      H	      @B���n�g��]8    X   res://.godot/imported/PSCalc 432 Foreground.png-98930a163f199eabbd35e54c0a70b4d4.ctex   �[      �      qPw�[d�����]i�H�    L   res://.godot/imported/PSCalc Icon.png-9b8561b851d13f1279acb43fb4de143c.ctex Pj      �      ������l:%H��*    L   res://.godot/imported/PSCalc192.png-6167103ffccaa0ed3e5cd9567eb0f60b.ctex   �B      �      ���?�꿰���k7�    X   res://.godot/imported/The-pitch-class-clock.png-7cac231f8576c564f10654916516ccb4.ctex   �x      �1      k�"9�
E��ݝ9y#�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�      �      �̛�*$q�*�́        res://.godot/uid_cache.bin  ��      �       Λ��ρ *倯=s8<       res://Calculator.gd         �      ��o#�~���[��}�-       res://Comparison.gd �      �      �S��\�-�Z�9b��    (   res://PSCalc 432 Background.png.import  �Z      �       /�Z�I:Hd�_A�    (   res://PSCalc 432 Foreground.png.import  pi      �       �T���rW����E�T       res://PSCalc Icon.png   �      �      ���?c��H}�e���~       res://PSCalc Icon.png.import x      �       �h�)���8��c�
       res://PSCalc192.png.import  �P      �       ��N����{��}3-
��    (   res://The-pitch-class-clock.png.import  ��      �       Z$uKڙDBS��       res://icon.svg   �      �      C��=U���^Qu��U3       res://icon.svg.import   �,      �       �m�2H�h4�g�-       res://pc_calc.tscn.remap��      d       ���j$?qC:�9����       res://project.binary��            8�TZ]���D�#NF
U�    extends Control

var curr_set := [0, 4, 7]
var curr_int : Array
var comp_set : Array
var comp_int : Array
var set_count := 3






# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	
	
	pass


#Transpose and Invert sets


func _transpose(set, index):
	var loc_set = set.duplicate()
	for i in len(set):
		var temp
		temp = fmod(loc_set[i] + index, 12)
		loc_set.remove_at(i)
		loc_set.insert(i, temp)
		
	
	
	
	return loc_set
	


func _invert(set, index):
	var loc_set = []
	for i in len(set):
		
		loc_set.append(fmod(12-set[i] + index, 12))
		
	
	_normal_form(loc_set, 2)
	
	return loc_set
	
	


func _on_transpose_pressed():
	
	_normal_form(curr_set, 0)
	
	
	_display(_transpose(curr_set, int($Transpose/TransIndex.text)))
	pass # Replace with function body.



func _on_invert_pressed():
	_normal_form(curr_set, 0)
	
	_display(_invert(curr_set, int($Invert/InvIndex.text)))
	pass # Replace with function body.




#Display text

func _display(text):
	var new_text = ""
	$Output.text = ""
	
	if text is Array:
		for i in len(text):
			if i == 0:
				new_text += "[" + str(text[i]) + "," + " "
			elif i < len(text) - 1:
				new_text += str(text[i]) + "," + " "
			else:
				new_text += str(text[i]) + "]"
			
	elif text is String:
		
		new_text = text
		
		
	
	
	
	$Output.text = new_text
	
	


func _display_prime(text):
	var new_text = ""
	$Output.text = ""
	
	if text is Array:
		for i in len(text):
			if i == 0:
				new_text += "(" + str(text[i]) + " "
			elif i < len(text) - 1:
				new_text += str(text[i]) + " "
			else:
				new_text += str(text[i]) + ")"
			
	elif text is String:
		
		new_text = text
		
		
	
	
	
	$Output.text = new_text
	
	


#Find the normal form


func _normal_form(set, mag):
	var loc_set = []
	var index = 0
	
	set.sort()
	
	
	for i in len(set):
		
		if set[i] < set[fmod(i+1, len(set))]:
			loc_set.append(abs(set[i] - set[fmod(i+1, len(set))]))
		else:
			loc_set.append(abs((set[i]) - (set[fmod(i+1, len(set))] + 12)))
	
	
	
	var dist_arr = []
	for i in len(set):
		
		if set[fmod(i-1, 12)] > set[i]:
			
			dist_arr.append(abs(set[i]-set[fmod(i-1, 12)]))
#			
		else:
			
			dist_arr.append(abs(set[i]-(set[fmod(i-1, 12)] + 12)))
#			
	
	
	
	
	index = dist_arr.find(dist_arr.min())
	
	
	
#
#
#
#	var doubool = false
#	var doubconpos = 0
#	var doubconneg = 0
#	for i in len(loc_set):
#		if i != index and loc_set[i] == loc_set.max():
#
#			index = loc_set.find(loc_set.min())-1
#			doubool = true
#
#			pass
#
#
#	if doubool:
#
#
#		for i in len(loc_set):
#
#			if loc_set[i] == loc_set.min() and loc_set[i] == loc_set[fmod(i+1, len(loc_set)-1)]:
#				doubconpos += 1
#
#			elif loc_set[i] == loc_set.min() and loc_set[i] == loc_set[fmod(0-i-1, len(loc_set)-1)]:
#
#				doubconneg += 1
#
#
#
#			pass
#
#
#
#
	
	print(index)
	var rot_ind = index
	
	if mag == 0:
		curr_int = loc_set.duplicate()
		_rotate_arr(curr_int, rot_ind)
		curr_int.remove_at(len(curr_int)-1)
		print(curr_int)
		
	elif mag == 1:
		comp_int = loc_set.duplicate()
		_rotate_arr(comp_int, rot_ind)
		comp_int.remove_at(len(comp_int)-1)
		
		
		
	
	
	
	
	
	
	_rotate_arr(set, rot_ind)
	
	pass




func _rotate_arr(set, rot):
	var length = len(set)
	
	
	
	for i in (length*2):
		
		if i < length:
			set.append(set[fmod(i+rot, length)])
		else:
			set.remove_at(0)
		
		
		
		
	
	

#Compare sets


func _on_compare_pressed():
	
	comp_set = [int($Comparison/LineEdit.text), int($Comparison/LineEdit2.text), int($Comparison/LineEdit3.text), int($Comparison/LineEdit4.text),int($Comparison/LineEdit5.text), int($Comparison/LineEdit6.text), int($Comparison/LineEdit7.text), int($Comparison/LineEdit8.text)]
	
	var inv_int = []
	
	for i in (8 - set_count):
		
		comp_set.remove_at(len(comp_set)-1)
		
		
		
	
	
	_normal_form(curr_set, 0)
	_normal_form(comp_set, 1)
	
	
	
	inv_int = curr_int.duplicate()
	inv_int.reverse()
	
	
	if curr_int == comp_int:
		
		if curr_set[0]>comp_set[0]:
			
			
			_display("T"+str(abs(curr_set[0]-12)+comp_set[0]))
			
		else:
			
			
			
			_display("T"+str(comp_set[0]-curr_set[0]))
		
		
	elif inv_int == comp_int:
		var inv = _invert(curr_set, 0)
		
		if inv[0]>comp_set[0]:
			
			
			
			_display("I" + str(abs(inv[0]-12)+comp_set[0]))
			
		else:
			
			
			
			_display("I" + str(abs(inv[0]-comp_set[0])))
		
	else:
		_display("No relation")



func _on_prime_form_pressed():
	
	_normal_form(curr_set, 0)
	
	
	_display_prime(_prime_form(curr_set,curr_int))
	
	
	
	pass # Replace with function body.




func _on_normal_form_pressed():
	
	_normal_form(curr_set, 0)
	
	_display(curr_set)
	pass # Replace with function body.





func _prime_form(set, mag):
	var temp = set.duplicate()
	var temp_mag = mag
	
	if temp_mag[0] > temp_mag[len(temp_mag)-1]:
		
		temp = _invert(temp, 0)
		
	var temp_start = temp[0]
	
	for i in len(temp):
		temp[i] += 12 - temp_start
		temp[i] = fmod(temp[i], 12)
	
	
	
	return temp
	





#THE WHEEEL


func _on_c_toggled(button_pressed):
	
	if button_pressed:
		curr_set.append(0)
		set_count += 1
	else:
		curr_set.remove_at(curr_set.find(0))
		set_count -= 1
	
	print(curr_set)


func _on_1_toggled(button_pressed):
	
	if button_pressed:
		curr_set.append(1)
		set_count += 1
	else:
		curr_set.remove_at(curr_set.find(1))
		set_count -= 1
	
	print(curr_set)
	pass # Replace with function body.


func _on_2_toggled(button_pressed):
	if button_pressed:
		curr_set.append(2)
		set_count += 1
	else:
		curr_set.remove_at(curr_set.find(2))
		set_count -= 1
	
	print(curr_set)
	pass # Replace with function body.



func _on_3_toggled(button_pressed):
	if button_pressed:
		curr_set.append(3)
		set_count += 1
	else:
		curr_set.remove_at(curr_set.find(3))
		set_count -= 1
	
	print(curr_set)
	pass # Replace with function body.




func _on_4_toggled(button_pressed):
	if button_pressed:
		curr_set.append(4)
		set_count += 1
	else:
		curr_set.remove_at(curr_set.find(4))
		set_count -= 1
	
	print(curr_set)
	pass # Replace with function body.



func _on_5_toggled(button_pressed):
	if button_pressed:
		curr_set.append(5)
		set_count += 1
	else:
		curr_set.remove_at(curr_set.find(5))
		set_count -= 1
	
	print(curr_set)
	pass # Replace with function body.





func _on_6_toggled(button_pressed):
	if button_pressed:
		curr_set.append(6)
		set_count += 1
	else:
		curr_set.remove_at(curr_set.find(6))
		set_count -= 1
	
	print(curr_set)
	pass # Replace with function body.




func _on_7_toggled(button_pressed):
	if button_pressed:
		curr_set.append(7)
		set_count += 1
	else:
		curr_set.remove_at(curr_set.find(7))
		set_count -= 1
	
	print(curr_set)
	pass # Replace with function body.




func _on_8_toggled(button_pressed):
	if button_pressed:
		curr_set.append(8)
		set_count += 1
	else:
		curr_set.remove_at(curr_set.find(8))
		set_count -= 1
	
	print(curr_set)
	pass # Replace with function body.




func _on_9_toggled(button_pressed):
	if button_pressed:
		curr_set.append(9)
		set_count += 1
	else:
		curr_set.remove_at(curr_set.find(9))
		set_count -= 1
	
	print(curr_set)
	pass # Replace with function body.


func _on_10_toggled(button_pressed):
	if button_pressed:
		curr_set.append(10)
		set_count += 1
	else:
		curr_set.remove_at(curr_set.find(10))
		set_count -= 1
	
	print(curr_set)
	pass # Replace with function body.




func _on_11_toggled(button_pressed):
	if button_pressed:
		curr_set.append(11)
		set_count += 1
	else:
		curr_set.remove_at(curr_set.find(11))
		set_count -= 1
	
	print(curr_set)
	pass # Replace with function body.










d !%O�=[|��x;�extends Control

@onready var arr := [$LineEdit, $LineEdit2, $LineEdit3, $LineEdit4, $LineEdit5, $LineEdit6, $LineEdit7, $LineEdit8]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	
	for i in len(arr):
		
		
		if i < $"..".set_count:
			arr[i].visible = true
			pass
		else:
			arr[i].visible = false
			pass
		
		pass
	
	
	
	
	
	pass
yGST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[ k�j7�f��Ϫ�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://slpvpqqqfvjc"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Calculator.gd ��������   Script    res://Comparison.gd ��������
   Texture2D     res://The-pitch-class-clock.png -lb���m      local://PackedScene_ickur p         PackedScene          	         names "   G      Control    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    metadata/_edit_lock_    Clock    offset_left    offset_top    offset_right    offset_bottom    C    button_pressed    CheckButton    C#    D    D#    E    F    F#    G    G#    A    A#    B 
   Transpose    text    Button    TransIndex 	   LineEdit    Invert 	   InvIndex    Output 	   TextEdit    Comparison    z_index    scale 
   LineEdit2 
   LineEdit3 
   LineEdit4 
   LineEdit5 
   LineEdit6 
   LineEdit7 
   LineEdit8 	   Sprite2D 	   position    texture    Prime Form    Normal Form    _on_c_toggled    toggled    _on_1_toggled    _on_2_toggled    _on_3_toggled    _on_4_toggled    _on_5_toggled    _on_6_toggled    _on_7_toggled    _on_8_toggled    _on_9_toggled    _on_10_toggled    _on_11_toggled    _on_transpose_pressed    pressed    _on_invert_pressed    _on_compare_pressed    _on_prime_form_pressed    _on_normal_form_pressed    	   variants    v                    �?                                  �A     @A    ��C     �C     C     �A     7C     8B     QC     B     }C     |B     qC     �B    ��C     �B     �C     C     �C     -C     vC     WC     �C     oC     SC    ��C     C    ��C     C    ��C     9C    ��C     �B    ��C     �B    ��C     �A     VC     nC     0A     C     \B     *C     �A     �B     �B     �B     ,B     �B     �B     �C     �B     �C     #C   
   TRANSPOSE      �B     @@   !7C     B      0     ��C     2C    ��C      INVERT      �B   !:C    ��C    �D    ��C          ��C     �B    ��C     �B              C     ��   !FC
     @?  @?     =C   �C     xC   ��C     �C   ��C     C      A   !GC     >C   ��C     yC   �C    ��C   �C     �A     ��     �B     pA      COMPARE 
     2C  6C
   ���>���>             @D     lC    � D    ��C      PRIME     ��C    �%D     �C      NORMAL       node_count              nodes     J  ��������        ����                                                                    	   ����         
               	      
                    ����         
                                               ����         
                                         ����         
                                         ����         
                                         ����         
                                               ����         
                !      "                    ����         
   #      $      %      &                    ����         
   '      (      )      *                          ����         
   +      ,      '      -                    ����         
   .      /      0      1                    ����         
   2      3      4      5                    ����         
   4      6      7      8                     ����         
   9      :      ;      <      =                     ����         
   >      ?      @      A      B                  !   ����         
   C      D      E            F                  "   ����         
   G      ?      H      A      B               $   #   ����         
   I      -      J      K                   %   ����   &   L         
   M      N      O      P      Q                      ����         
   R      S      T      ?   '   U                  (   ����         
   V      S      W      ?   '   U                  )   ����         
   X      S      Y      ?   '   U                  *   ����         
   Z      S      [      ?   '   U                  +   ����         
   \      ]      ^         '   U                  ,   ����         
   _      ]      `         '   U                  -   ����         
   a      ]      b         '   U                  .   ����         
   c      ]      d         '   U                    ����         
   e      f      g      h      i               /   /   ����   0   j   '   k   1   l                  2   ����         
   m      n      o      p      q                  3   ����         
   m      r      s      t      u             conn_count             conns     w          5   4                     5   6                     5   7                     5   8                     5   9                     5   :                     5   ;              	       5   <              
       5   =                     5   >                     5   ?                     5   @                     B   A                     B   C                     B   D                     B   E                     B   F                    node_paths              editable_instances              version             RSRC�U:�GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L  /��/ �Hۦ�{������8�I�ڶC�Tk۶m���m۶��;S�ضm;鳱�3g��t�tR��M�+_}���z�@�f�3�X���C�$�Q���, ��hY۞6��`QR|����)�j�bff�ff..w��0��,b�1׳ ˿I��"I0�0�b����T��1? �wv�m�bw����F�"�q�5�T����������f�'mH��%d���I�����0�:��9��E�[���幤���Β��o��s�8W�d�3�"�]������U?�y	l���ixq�{�:�t����u�/�����M6ڞ�<Jiv4لͨ�	q��J����'؁G-n�͒�/נ��;x�ⷩ$����'Q��Y�P��J����AJ�w�O��m>䳄�^�
v�Y6�(~O��e�қU�`	�\��|��O3uɲX��<՜���d����'\[��7-x��.�-��<�J��B��|m�H��KP�M�+x)�	o
^�k���>s�����r��LV���7����=( �m��tf~��V��JDd�\wA
�o���*�����y�M�sͣ N�/�.Y�����7s�� ����Mܥ�T��7�ڦ Z�ë��Лf(�7u�`g�	kwx�7}�]"��6X�M��C{�Ƿ�=xq}��[w ��Uܖ���T/�M��+`�/��7���,pC�3)�Û{v38.�ݬ�^�Em�K6��A}�JP��m�}48+�����M�F��NO��O���b�5�n��G���	qg�lxQ��vs`�ۺ��NPo��o��2�(�Y0׳ PS�r�r=�q̒tű�����Z�XM��խ^�n�'f��l$|�. "�!�Y��*|���(XZ��u�� � ��}A~S��A�[��[��<@�Ư��G�h�~�k�<���o��4�ɾ=]
lzBT�C�9�2 �k(�� Q�B'u�
b�C�'��ñ%[��# �P��x|�Řߗ�{@���?u��w�MDO�_n��� �*^t�	<u�`$õk�-���l�֮�g�:����A��c���qgC�ߑ�ǝm�A���w��Y*$E6r��g�C u��b&z@@�-KsypU�Vy�
�����o���D��`\	�U�|�i�TFY�NS��k}P�x+νW7a�S%q9�2"�I�R���ZQd�X��s%*;�y�
�r3���{�,�i�������׳-��/r�o:�w}��T�Qޟ���� ���)i���@p�{�
�S����,���7�Ke��ʶl<A�����ל?}k_�y���ajLq`y����=���c_	l <A���b�y�`�K[�Nx:�S��l� �YP���}[�h��wVցM\�L����/���K_���`*t��DM0W���o�zn R<	O�*@� ��{D/�>�Q ��O"���rѧ�}�u tt��w�z����yQ�] t���  �7�I�x=��� �����?��� ���+X `���?��Ű��<�� �����9��]�����O����{u� ���� ׺�� 6�b�� d.�] �A� l�<� `QӴ񥢚<;-�{{��o��j<.���  �<���X�8�5�gB"����gim��K(^�,xҎ�fNL��Tvo���u�O BNX���g ���+� ��W������bǂ��n��,�(ٰ���264���u ��H/�,>�c�8 p_�O�  ��++�!g�U����j6
d�ht���0P	  ְ�|�����ʲ 
7t�R��śD�ǅ-��"��e�լ1�A���8�疮޾e�,��F��O�n���� Tl�~��8^�\a j:
5<x7�\��w��7=	m7��H ͝ ^�s��J�񔾼|��ۅތ˻��S�����{k���� �� �OxZk.�W�ҋ[� �r�''��q2E�ؓK �b�����,�h0熖�5 {̭{�� ��%|�M_��T� �, y��'.���}.� X�t�| ��uO�#z�W@�FV��.K��hi���\�����K������z p��7�/ ,Ь�� :�����l�\Xxƽ ��#�. 8�KJf ���N�)o�+m���:S��遗�� �{����d�EW� �2��Bw��@�}A�� L���^p�V�S���~f�gz3��{ �]]_ �������S |)w��aS �m/�� �y�'\=7�� +]��lx��� ?�}��� �ް�;IC��*Ơ�
 9�Q��Ş*��O��}����l�k�ѰL9q?G&���]�4�� V=cK������/���2@.a����]��o�6�k�gy2Ňt��^\Ë^>�<�YJ����k��i�h6�� �z,���^� ���/����V��[Ĥ�'��������o������fŴ'��"¶	9<�'V�����f]zs%j:@��xn%d����x|�+`�M��.��%:�U�u��J ^�"����ws���xr�W̟&.ĤKx�����<���g��%�CP��[B��ǝ��NKR���tU��:\�BOV����_�|y|�vEo����UU_��q bǗW��h��<aә�_�����M�xvYJ�u`�c)��3��Ee�HT�p�]x��X4Kuw��Y���5�i����OJHr6y�R�] X�LN�+�˼ה���V�]�Ɲ�Q�w���&#] �u����h�s+���������#�aX4+�7+^�Gډ u�Kn+�	2������{b�i���@w�;J�� ]��m尳c����tx�˃'ע ����Ai����
�S�ˀP�7=k �o���
(p����%:$m�ly P��O;��+�Ko����$r�| �ZX�6�2~�
n|���4��A�C�-��n���|�s���YB��>@�5,���M���O�>��sK�t���/��>gAk�'�[��(V���6�l˓k,1 i	�6JSr6o|�J�m�;J�'���TB��U6`�/E�20��d�2H����rC���v^`@;�M^��G��w;=m1n!1��XReI�1�!O
���\��@�fQ���pՂ�,y#c%��ȓM��\�Df W)l�&k�"�兌��d-��d2M�S\;����@�|Q���{nH�t��((]|�@�4�,[�:�Ȟ=wԎ){�N� zs�%]��E:��չ���<���V��w�&�:W��f�Os��I�^��]���*�\�o�f����Ǔt``s��Hnʗ�5�qp��-g�y��t҂�m�y�p�{����<eo�[�4?����<�4``���?%  '��4[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cx61yud0uw583"
path="res://.godot/imported/PSCalc192.png-6167103ffccaa0ed3e5cd9567eb0f60b.ctex"
metadata={
"vram_texture": false
}
 	P"�c0GST2   �  �     ����               ��       	  RIFF	  WEBPVP8L�  /��k ?�m$�	�Vo�a����mۤ�͐{���$���5�Bw_��	h�$���� ��B7��=��{K��'��}����a6*&i��,o;�/omw���O���<3X��[�Rk��&l��� Αn���"d��]p,¦��A16{���e��ID�'��?����������Y�5nzLrN����͜���WT���U�껽��t�6����V�p֠�����ݏ��6�?�1y����iy�k��?��e�{A������ӿ9�5b>�����|v0u0���;�~r�T���0���7��m	F����N�_ E�md~;gA(pC-���hz\ٷ�lت�Áu�+���G<hf����� ]�f�ca%����2'��,�/k\�r���7���^��eّ7q�Y�+,\_f�VN���K�94s��d���a�)�n�d(X��,_o��W���������b����,��$�-���vۺ�;��~����,��d�-��B�c���˽2\cQ�Y�)�Z�����֕}��_9JS�wY��"�4��u�4MK�߰���(����I���n֤����_��]�Y�:�Z������ �|�ZN�V���f����dk���������H�*�whc�V�
]L�`�:��c{��0��g�|���"t`�d=�����Ƕ�Y�E��V'JϮbm��
o?���-�4��nɅw����fW���BĶ��~�Z
�Pfᝊ�x�ٕ���`�mf�ߐW�w�q��n��߻����ϓ��= <cE���#��p���0��Ŕ�(tKɿ�H!���d�/Q#��_@ь�M��&�xf0W��_l�D1�
� �X�� ��Es��\2�}��T�aLV�%�(x�X�0*�Keh/,x�P�1./
�?D2���D$EШ��UHcs�@΂�<�z��3ű��yD��h�����ӄ���Y,�g ��4F�jQ��-QT@�-�"<[�1Fw
b7H��$�|���	Ǌ!�QZ �}0y$�Z�x��0ԁ	'!�q���T�P�!"�HMA,T��`TΈ`?T���T�E�*<L �+s�X]&����,%8�W�K�e���x�`��/.���.'��.��+�K��¥�x����x����xw��a�Gp��\�6��7]+^"L�/Sg1^�n0`�,�Ef��f��& f�� �a8?��39x�m��x�4]^�L�/�MW��tp�A��	��]��{���S���C�����6�����xS�k<�����'��4_)X�����R%�5`9/����S !`� �b%J�Pq\���$�|��A6T�`:TV���)�E@@�j�`Pn�� e��^�L݆I�%��0�AR���b�:Q2IT�F��:�\D$H���1!�+�H�\�Ӣ�EH�(� �,2 ��d�Ӆ�(a�1xԒ4g�c�8�8�����-�g8�B���%���8E�AF�H�*0>�L��Q �,~
���(I�� 
o�X(�I�>�p���C�2IַQ��m�(!�����PJI��{�-��$��_X���PA���w��(n�-��Ii�/����@p���z�XAQ<�H����%��^�%��7��I�~���a�h�m&��V]�%1��I��js�H�j�#�)�ܒ��Xe-A$���9����O�w����DY-A$��N]�#&:��E*\�����j*��@�t�Ej�.���`R�]��O��J����'e�|�����э��G
�ڣ�lRi�G/kI�ɿ����ݭ'�ՠO:�6��:zbI�#���4���_��wcH��%EԌ"[��P@Zަ��>�祎�X���v���'e�<ާY�n�Pt�CH��b�[GJ�'��3I�V�Ȯ&��k�g)?�BX�g���|GR�g׊�1�@h���w �0���O%,ƽN������d�#D���f�2�Hz�X�KW~�8�����a]��;5��9h[�~#���oA�;�p����V�/�ֺ-��je��~�/�6��Wy���!າo;f�^7�����uE��S�6��L�E@��/��ל�~��o���+�����Eg�����u��W����ۛ�[��u%]�d��]slº5:a������'g��O�	��3\}�������s�ӿ����^t�lqi����?���UU^r�{��e�l�W�=<|���?��������?K�o�U��[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://duqudjxhwvgu7"
path="res://.godot/imported/PSCalc 432 Background.png-4bbef8db5aae212ff2f5242b360495d8.ctex"
metadata={
"vram_texture": false
}
 �Ѹ)񍢺��n���GST2   �  �     ����               ��       p  RIFFh  WEBPVP8L\  /��k �5lێ���I���Q�$�V��m�N�C���m�v�l�ڶ�83����b2�7��m$۶M;��m�m�)٨�N:������ ����������������������������8�m�������V��Wga| ��)���V���Jr\'��1�G�'�"9�4�Z�g%�l�d��i2���=�i�:��6-�40��~�c����_�/���)ݒ� �9i����W�� 2�G�<�V�J{b�Lw�/��S��$��4�C �^.A��?���Q�k!���(?��/Ԅ��d�d=�ӌݓ�@1�d�D�� ������%��_~�H�X�=2 ���_9No<��$���s @%�.��+;UY&@����k��D�e���z��4�Z������%�b�`@���cǵ��YZ�2�%Gy��o����v�e�D�"N%@�y<Ƒ@`�T�	 `�מ�ހ�#ر�R�� �>�P�I@�s��  ԡ+��Me~.�Q� �ץwڑ�(����QU�� �/��P]7��Օ�uڒS�@~����[T'�#�6���/�W�X�O;��7���A紑
�R��*��U�i}  �B(�����%�]
_�U� `'K��̭LSk��#��_�0�Z�k��Y+�V*�~u� A�V��K����	�[/� K|�_]6@�q!�<��Aͦ#j�h�p�6�������ij!����,�>�G:���A��B<���	 \\����T� d<�)���,��\��TK�ID���ցk�8 sݜ��T7�Z�Bf�ƯT��R��D8�6�gࣰ�F��'? ����nFZ@m� �+l�GPʛ  ����X��PY���-���П|)l7�^6|���I]�!7񚳦�9t��p1�,�g�B=<�i?J�/r�ڐ�@蒲ԓ�Y�;�2���a!Rԡ5P���SK�q�Cnr�Y!��&h�%9]�� �����a��$C����CG�'��Tg�oZ�Y;�;L�K:�BI���5�Ԉ�@IV+ ���YCYZ�   [i$���ہ�˷b��i�r�-u�"v���zH�%��P;\G�&�^2�>��@!���F����"W��| Q�^����8PU�V�^�#�Y�3Od��Gd �'5�h�x% ���*rKI���? y|4V:��5 m {�|@�$|}ٹ$q��&�����8�����a���@�x�1�`�E���"N�@{$z�[KD M߷ �+=��.9H��+ 	��C�K��#>Q|��@Vs�+�gf�fs�'R ��l�ꓵ��sH�m{G�@lC�x��S��A]�
wyDwn�%}s��8D��!���Rb>b.¿lH��VOL����+����M� ��ܠr�	UI���*+�6���}�.�Y
��\m�X�T�G�6�h��L�@S�J���d�M�D�d���=d��h#X���ER�QN��  �X"���J��)��2���e���Y"b;X
�m4�1��
�j����J�!��y�"�D���
bEl� ���$d�d�j���\r���a���������a e_T �>~-EmH/���'
d�������������%JH� s�6I����+E��.%�D:}���A	[ :
%A��4A-��FҎ��aҶBJ������-�85%�'��FRNjX���NA���Y"�DIi&R��Z9���P�=��.�����	)bF:�& ��'+�4{�5~�D~��(ðGY�'ɐ���(E{�"��n���dF8Q�g��*�њǰ�6�d/F��A�ftDu��Q�6\�2�s׆�p���h�#޲�`��2S^�gr��і�&k����%57�U�����|��/1��Z�ݼ��W�� )K%Qŷ#i�+r2C���FS@by7)��qtDU�b䖓�� 5����ƿ��
+���h�vxF�gc$�䠄�1fЄ�bd&-';�& � %��1���B�W �*?[u�]v2M� WP��kI	W1���q,B��x;>S�P�ip2�oH`F���J�G䥄�h�q��C�2b>*QvrHளG��Tpc풻M ��/7��_�{����FGT�f�v���+�1�ڣ��9�!��+�,�w��(��'�/i��<�8��Y&I���<�ߴG'����N|QwY'�Q���&"�����2�b|5���ީ$3�%���F�w�Uy�GQ�E{����x�1�ڈ�\�zO���YJs6�3����hu�����&r��!�_Pp� ��,G�8BI���(�=�$�E�R�k�Y�rY������M�9�W2��#T%1��\����$EC��d����e#k4�����]�P2��t$e ;�N�T�IR	q\�Ȃヵz)/= |��f�y�U�P� n�Y�H��$h׋�B�+�Ȋ�F�� ��N�	]	 �k��b�T���Do�"?<>J��'H�~e4V<�
�#�5�W����-R��[���d��-�GW��&9��vIiT���b��Jt��풲(0��Z�2\c�"�����l����2o-����|��X�3o��Y�����jp8Ǵ#��P��_]BŌq�v#�+�ɬ�b�N2����kL�����5I�C��/='���L��	�ʴ�' 2�� Q��-�� �De�1m1�	d��a8��G�3��C�[����& ���A؍'��Xğ(;����+D ��#p�� ���u$C���a�P5B T5�'���S�Z���pN�Q%���W�YǼ�#���B��܅�O��ü9T��Hd";$��/�7�?�7�Hޏxn3qh.�+*�������y�������L�����ԡgB��H|y�p�`��]��H��?	12`�Jf��se�lH�JD������6�
���b�U�
���!�22�N^Br�����7@Z���21�J�A�w�nI�&�@�	r3�`�~ㄤ�C�Nd�� �C��,��P>T�+LK3}!	r��W�ʌU��F�<r����\~u�@W��5d9�C��w�#�K���j��dh�C��=j6�G� �)��j��J�֜,��P����e�@��UTu�� ���5yU�^C��5dQ>A�#�+
0[����(� !t�?��Y�����n6��YY�Q���,��Ă|Y�a�B]�,�ωt��:#��s�>���d���3@2d�v�Jc	d����$d��E��Y�����,�E  6B��U<�,���B^�{������^�{������^�{�����#	����,��[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://djbosodc3stw2"
path="res://.godot/imported/PSCalc 432 Foreground.png-98930a163f199eabbd35e54c0a70b4d4.ctex"
metadata={
"vram_texture": false
}
 <�>��Ԟ�"�Z�GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L}  /� "�d۬�ڿCDL@'M��m3$Y5��ζm۶�}Vv���U���Q{A�7m۰�;�dg����3	a �[R����ҍ�_�{�BW,�����Ȧz��%�d���m#G]����g�@[�?C��o�c[m�6�m�ٮm�63�{�{���Cߊ�""��stm�6m[���s�/�c��Զm���o�H�6�[	!�3�#W�එ$I��3��ۓQoX$�+�D`F%&�n���hxBID�'�`n|�*`�|��D�d�)��q��-~ÅX'�A7�h�� ����6��xρC؆z:�0��3F*h���o�`g�L��h��%\�ؐ�e�\A �H�ً,8s!8�ͼL���;��;L�2cуK0Bp��h�*��F	�Q�,�#�	☇,��\x�X����.:�F^��w�W��8���X��c>���V���\���NE^���*��R4#F�h��C1�����H�уd��/-�����mEe�c�*[���x�<�4_ئ�o���䞛�\��_���Ў���в=����Q�������>'gX$tϙ>��q�J){�׵����Yrɗ���׻�Q_�AdK���"a����/���C{5��[�-���rޗ~/�+rK�W�D~nY$̘�z�n��z�i��{~����Ȏw����[^�qǏ�JG&l)�s�ɢ���
��O]�7l)��=� ������b�&�n�3��=�㎴s��1*�P'��z��	�-�ܩ��bF��̡#�b��軣HVk�t�c�M���)����3q{� �raC��B�*)Y-	 �3��TO� \O @K�u/��hi9�s���y��<�B��`
��B�S�+h���� �}
Cf!8� yW*h ������������QA*Bz[ ����ׁRՉe� ���q@�'��6��: � Q`A`�>���]�?P,���#�i� P}�#~�� џR�� P����2{T�a2 �6Ż=����'54���!3%���5ll��=T�O��x yX����� |@�^�?\������n�= ���PɄ��#e&}T�+6ؿ��9��`���Co\>�A�T @Le�45�?
 �)TrA���6Ш�@cg������*�к��VG�'�'j���!y��5���0���Z��nh�=ldT𣜮i�_A
��ҧ�I�R�~*E��u	=�*Su��wt����A%�7�j�f���.[�`_�+iB�Pj9ӓji���M�G�P9p��O���Ɂ�;�:��n7�d��L%	7��fI��m=��[��**�v�؝�ȴ�x���H���l�):S�63%��=^z�p�N��o�e+��a2%,)O��0w}�@{���B�p�=�9Q��3����K��  ����l�x�C>܉<�� %}
��P�EC��>  �`��  <�����5���
�q�	 ��@Ɠ�Sd?���  `)C������ 4�JVv  �8�aR7��v ��Ǹ>��x��^  �B5�  �A�o�*�I0�	Kւ�	�[�  ��#g�I�#�W�ބ,���栄�����%?��������`�W@$Y#)�e�ב@%�q2����B%��emÈ�����є��iSx��=w
����jxD���oAܿ���A��2�)C	���� �AI�F����`5}
�ð΅�~�?�O��;��	f<��# @C�Ƅ�P�x� u�:$�O���j�M�T�L�|�f�`έRt��r X~�E�*:�>@OmN(>��>ѽ��*T��S>@��S�:|��>}� ��z0�L*}�q���ѺR�ȅU5>��)>�7�2�T;\�B#��$k*mQv�p�}��6�<��\qE��{�����������=(q��>g�|�P
�Ɨ�-%v��ZU^}k�ܩ��t��㨻��چ����6�$z[� ���eim�q���V2�L�5&�����GeG�x�@hT�)�)�8WJ*~��j�"8�4@��Ȓz~��D�;`e<������c$<V�c�  :[��מ@�/��&��C��m˗ �5��ek*  ��`MQ�!��*~�w�����m�n?  ��2E��`��T�t_B�Z�k`�l��z��+�40#)}`_B
-�0��L����K���5�{�B;~�}�����5+o0��E��������  �c*T�� ��c�Op��&wa�]0��?�) �n#f:��kh��O�l; l*o�B�*s  ��8��i�1�3����A=`E  ��rp���e�A�T�K(/Q��;g��	 �_vLE6ރ��x���f)c]�h��ўX�Jt�kl7C��.R�x�{�)z����=N(��j�#q�"�;){^�x�3�B������P�=< �=�Yʨ�����$��Ӆڌx{S�r���Dr:Z�8 h��7��%�؃�
�C�^��w� ��rv3
�c	����
wl���1�"�� eo"U��ᐧ��C*hLytG��ע۩����i�����B�ʝ"_�Q��P�g�*�r\�mG����}�."��Kڣ�X�v �3Ҡ�P�`
drŗ�;u����Җ+������H�c��㢠��ג�IH 2~h98a�0_�RT���AUz����-Y��`d���$�ܳs����,,A
�D
HEd�Ď�$�Y����3��>���![��Z��#e�1��>S�5�oSԟph��g}��:�Ab �/[.�Н'�����������[~���!�j}�H���>O����?�%oQ�j�+�#�+A|�9������%߫3�p	�K}�iL�}y���N��K��Fz�J�'** va}�y`Ȃ� ��x�Ln*�7lY��-����ă"ć���G������AQ݉��p�[�?'kqR�՟�K{@:��:	
��I	7@�i��Sez����Ld�S>�\�4�"�j#�~nٲ��4$���α�f����@C���x��������A� >(Asl����SW
�\�V��A^�f�(�T"�FeЖA� Mu�@0����0��<����6��~���à/# TF�2(�Űp����6�lQ�8����	%jǁ����+�!Q�r�<��{�`� �9(q�/(��0���x�e ��r��v��	�������θ ?�B��̉mށ K�,!2��X0	m�0	��6���`gx�:�a��f�80b[����`�0B ��P�
'��h��ÉV��猱LV���/ܤ����V$��$3*0�U����8�)A<����]���q|^� f�  l^?L �[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bjejec1jqdlvw"
path="res://.godot/imported/PSCalc Icon.png-9b8561b851d13f1279acb43fb4de143c.ctex"
metadata={
"vram_texture": false
}
 ��
&����GST2   �       ����               �       �1  RIFFx1  WEBPVP8Lk1  /������m�>��� ēbʘ	�&�O6@Q�݁�[���E���@�"ȶ����3D���j��Wm���j rĚ��}�W�lL��}�߈�Kp�H�$��-`<�n��d�����Z�ֶ�H���Z���U��m���yY�� Ir�6� F�8����?������f Y�!�v�򄤺���+6$��<UlH�<b�cA��5���CT6���5lk�j�T��Id�� 6�i�و�ȳ��B7'&Äz�����ֆ`퓳�M�=}�,���A��!T� F[��u�6kb�$o�ߒ��5b`靂X=�M�:�I�����v����6 H\4�N�$ 	@bl��Z+f����x��34I�����!��[�j����3��칮������rI}���������|�Uܽ��ȑ)��}�Z�k|�*2�mH����m�(Ɩ�D��Wl !�9�=�tq�Ո�K�j%V��aH��6 �s0�87��j�L��v��Z�V��D�P5[NB,TnY��Z��"��)�:����]wȽ�~�)�c�������x/mߙ;0���S>zi����Qg�_w�7(m�_�G���)�%	[�w�Ag��N�tZP���\*��%~Й�|S>I9D4�tg�c,"5�
���:��i�C���arK0�HeS�R̙�4S>��;�3x��G/.wm^CL�X�5�c�'�Gӝ��u���I��(mӿ�����������kY�i��i��eY�}������$���55��O)f�7��+M%�b_��q:��a�,ˮi0E�+1�Ƙ_��������f_�i85j�}�!�5���}��sS�㹬��g]�qi��9����Ɣ���My@��Kn�<&�*�̪HL��STf�b�5OCf�.ˮi�Ȫ���?���ߘ��r]�L%�c�3j�{��$�;kk����뮀6��:h~�6�_i�w,�ȩ�`�r͓��e�O�w ���0��.i5(�~y�4�_e�w�^a�2�v��k��=�y�N�V�!��{�Ifʌ�y��L�_�� �H��
�,������˶CkН�Y~/*�萼o�7 �k�F9��U�i���u��Su�&��{,��y01�L�� R�4m��d�&�4��~b�c��e5� �l?�
J���H����Ƽ�h�p�o���Y�6��[!�v9���� ��=W%0
d�K�
�Y�����T#�^FDYP�6�J:��e�ѽ��I�^�Σ�{��y��x��"Ul�*���s���c	,�e�z皣����Ą �FQ�|1�D�{�ϒKf}�5�1N�=�AD���jAM����D��˗6��.�̓��g��Q�	��VW=^���U@D���"�S�8Z�A��F���m��A�X�U<K`��#�8,�9w֑^��ܾ��:	W֞蔗+��y����fa����A�B���F��`z�x_�zl��K�r���A���JY%�	�Z���^��5z�q,A�,�%�#������
A��6��*�[�ͺF�7��ˬb�0C�\�'N��{殂����½Q�&����oތ�d�¬	j�d,i�gl�0F���pe]8}eW��]Q���� �]���s�����[^�Fy����_�Vb�g�=�Q_<� q�1�2��}�|� �B�ksx�YH}��fQ� "�V��ȧ�;�l)���d-�f\5��/H�dJ�����(b�)��턟2M�Dl����(���)$r�;)�s�S�q���Ce-#�����ɒ�\�Z�l���¹vM�a��Ƃs�)2%V��o.�oCd��DD��������B�˸s`)3�@5�W�0ٶr�͂�#A�t)�D�%6S&S0�sp�z�L�@���p�e
d�C,�0�����]�o�������[��m����ݢ�0FN�w���&Q�	BT>�$Ú��ܬ^}B�Z���ߤ`��G�r���V�b�S�	���Ue��݋�L�m��T�L�6cP�o�r�^�g괥$����=��
���3���~�S'L��?D/� @���[���Ew꥿� ��#Ơ4�S�A{�m�4%�M�d��M�������e¾�R���]�=饲��!�A��o�C�Ch��e�y�#������u(��h/�^|�0�N{J{?0���kn��:����˄��N�ݍpMJRٔz�ֺd��כ����b,s�Ql�LA�"���v�%�N�]%�݂f�LL�����/��0FwKSƊ�w��0#6u}�����`�ox�^�,Z݁f��!KK���N;D�j�����݀V!5|Ժz�!��3*j����@���Rl�2�9G��WR�������g��I�����w��D[))A���N��_�8�)V�``�8굋s[�B[Cj���;.�m�∭ql쟭�D#ظuM��h\�h��]�0�wW�8�F�#�@�b��qM;v��S��Ź�����uo�mDW�G��Dm�5��#�
.�!~�Ol��%a���}�.�ʬ�ߵ1�z�$Щ���=��*�ɔ�~y�F��Q�"���߻ްq�J�	S O����Bk��,��id�na�(� ���-@�iL�B@��
��W�$rȭ�O��B5�~�K��s���4!��AJT
�\x�Ϝ���U�.곍xs�}�5��È��0���t�(��v�R��lB��8�e0�m�LR�W/�a�>:����눗�07�3ߊxis�"�xÉa�i"��Uo��0�(o���1TqR�k��ED������xAœt��zB�k��X1' ��`)� ������}��<�N���ᜁ�r�*i�V�����G>���dǵ.�(ܴf�m��L�q�6Ǌf8(f�gF8�U;v��%��[�0����m��[ڬP�/��e�� �K�D��pp06�. �e�Ar�7�3[�2̐�(���t��&�|M403����t�t�P�G�L/��tƫf��p������ ���D-�Hg�R��h fz��rn�ޘh kz�����N4����^��D*�4�Ϛ^0�D� ��Ι^��D�4�׏�gL/Xq�aV\�����V�h�ޟƔ�7���f�hX<h�|S)_0܁�Jd�7�<^��/�Q�Bp6-���	=�R8����#&��k����{�QJ���5]���QJδ'��":jd[�r~^��7�n��������&��F��(.��O��\���6��"�PF��i��Гyʯ�<�:���F5x�hA�Y�<���I9�������ؤ��!����?��/
O��D�q�{;H�w	�F%O�m���i�	��J�.�!����$�#&=��>��	�m��zx�^�KaP�3x�Qi�D"�d��(<V�36��:sI��x�5f�zb>����pV��z9���ט�'�=&f �Ĝ��%�mdy�w�"$��D{)ؖ�ųڑgk!�nNL�	'���}���=
��"Ɗ�G����c�/�ʦx��h�|�B����9x&�f�Hҍ�I��o� F�A1�1��r��l��u�D�{oS�{t}�97��Q��q*���J,�c��O��(����?[��uN`�	�c�	!�{��6f��:ӝ�%���o�."�kLM8b���[���PlG�VcvO����}������1&�Xz���S���;ч?�,k��K�g��s"�V�g@��d��ĸ4��1j�	ϧZl��ݙ> f�D��Ik���Q�8�uM��q.��g�@z�����p�w�v�Ϻ}��v��.�<�:{�C5�٤S}����i���s�4I�K4�+�Q̢?���)�4��+<�U �%�����.ْ~�/��ü����� 8~
'·�I��@��\�o'A�b��� �2��һ�f�g�%��K� q��ɻZ$��|��kQ�JM#.���y����}�n��[dN��4��.���N����"6�$-�9��,]'m�">��W��SI(3�� �ćcUܘ��F#Vx2I[D�:iP
��GأS���R֚�'�\�6s��N\�O���u�8�<��亘�K��4#.�X/M}/���q3��.^kknW��	Gb.���e ��4zw�5Hl��D�nL8&�J��\����������e�9N���[�\8<�M��{�L1�I�ȼ�!�S�.�Q�1F�$Ae�'29���cʂ��K���$6��*P%�.[��=��٘� 	�8Ή-��N_�D}*,q@V� R�w�G�fb�#��ZbV+���R�U���]��)q����0��g`{�ɳj���W���^eDr���{a �9��� ��L]�� � �WD29k�Zk=�Ʃ>|+}�KmayN�� Ȕ ��2��N�W�U- N�K9'!�$�3}����B�6����_����* ylOP��PX��z �Y�:�@�3� j�:�y�����!n�DTj�$�y�!,q2Tx�{ĥ� ����m$�U�P=�d��LqQT�q/7�y��Ye���ü��e����1�TO��ﭵ�5�dR>[[M �2���B���PS��l����ijLV��T����|:�[�s�W(�\)򙅩, �B�Ȣ�@�����Q�a�CS`�!rTq2_H\&�5������\Q[,�Fμ���8���R���5e��`¥|��� ��Ƹ�R((�8zA�a�cB%��Q�=�Zm ���� ��Pk@\�l��E$u�uƐ���ݤ��ff�J�^��-���N˳�+ �[;�1� U#�p8��Y�H��3���]WyЮ���ޒ�*~��L�V|��?���Y�}Ձ��84»X��
�q+!q��H�bJ� ��eO��t�A�0T􊼀lq��v\&c��1�'��T���<��*�����R4N�0ԠXkm(��L�15(��+����/zw�S)�E�0T!,K�2��A�ڶeC%B=�[ɰw.����J�0����eڈ�`Y�P���������� �Hd��^�2P�~@�X���xy�����*����� }VbeB�J"��{�3	��d�8�L(R��4T%�˕P���x��"�P���V��b��A����UM�,EZ��D��z�4gj*x���mǌ{�^U�������o��(��JAI;Wx�TS� b�
�(RM�)���,5�L
Y1ۤR�dͳ�+�bl[�y��D�p�5����W��T�4�T)\�KU#���}����IOYs?��9]V��润�l䲢O6�ݚ����qP��or"��ru��j���*�Vŋ	��蘹�U��0��U��	�d�D�m;FE�MUM�B�̷" ��*r��`R	�-۶fنT�8����.��˓��j#��C6i�G�� �c���]:���0��C��ELl�Z7��\O˱a��t���ᐭ`y�*ٵ�1>µ�l@E��m��F]�C^�v�}��Zլc�5��M���&QM�V/Vx!f7��E�$J��E�U�(��_�D�4C�:F��O*F�ZE�TAzV�H5�.>i�D�ձK=�$*E�ZM�����r�R��j�(D�ZU����j%X�����QT�H��v���2D�U��C�D��Z������ !�,2thIu�&i�����G!��e�?i�c�Jǵ7.TϰIs|���o��7=����ȃ��i�HQ�I�|��z���U�8���F����B�CB�2���Bc��&�h�A �۩hP|tI����?��]�L�'T���u�i�d�X��;i�<��������S#N/����)j��H�V?�ҞQkx���;86ĬVI�Sh��� /���-~��s�Y��6T8�z/�=� �X -�俅K�E�>�����D(VN"�`�g��������Z��DeC�0d�{P;��"���c\��+�89�f�h�1��YW� U��cF"+ī�>YJ���}�w蓞�-�Г�v�
�	Gd�c�B�$�&鋻�D�[�Y�B�� �/d��|B��~K� ��9&�DG@̓�9�,鍭��&DSF��WD(�h��n�UƶuεmH��Qu ���_!��\�#�	�"� �}�e]�|��+��Gl����"�i
���F_�{}j��D2��R/������W' c�dOu��p�j�0��˦j	4*Pm�D�+��Z�UKB0/���.�M6� ��8����[�Al_�D�&��= ��N�b��߂�0�e����1TG�.p��L1��� �"$"c<d�"�#�Y+N������e�sE�L�TBl��ȝo�/�d�3%\EĨ� (DI���_CNK��[cT���r`4�d�8蛐8ֵ�֚�)WMed�,��!7�ߣ��s��Ig �x�_��!,�;?���'֑����MRm��*���ts
KD/�D��U� �aha�?{�c�x�34��Z�|˼߆��a���HM��1�����2�k�I�jG��A��[eax�-�0��3#6�� ����-�ܫ�A'32y������ދ��k�L	�	i�鵌3�w��J(��)HH�� �At��I�}��z���Aۤ��������ѩ�˸�Z�Ǟsʍ���w�D�����G�T�����}j�����e��CT��m��g��.�����
C�u p緷e�9D��^ϡ��6HA7��?&v��\�T1|��}ҥ!�s��t��~ej��.I��ꓮ���L5s�_�!�l�zv-��K�%��l���A��I�5EU�Z��X�j=�@���pG-�^�^s�=Hꓞ�[�j�f�=���a��B.D,�fz1#V�"�:��!R��]� ��;}��td�Y���w�)۱�E���t��E�ձH����2D�U��و�:�֕�i%�T�F��7@F�ծ��s=�V͢�
O�/��+���j������j!�,��j��j�rq�V�����o{QN �AG��b�躚��gZ�+W��G��bMW�*��m;ʚ���Y�LMgn��b%�fkJq�*6i�5� ������Ȋ�&�
^@�bl[��.�+(I��VȚ�KJ�b��ʜs\���%A���������1/���R ���U�1����[!+\���/q�����d��[5�Y��{Q��lMY�^ҥ3z��2����`ęR�|U�	�$���+WE�2��5�
��thF�D�Du
�(k�+z#�f�ݳR%�UMy���񵪦4Ȋ�j�X5 ^VL�x_������\�
��*!��Z)]��k]�'B;�-$����:W���(.ʣ][��^9_J$DlfM�	oP��*��ض��P�X�w��C[�pΘI�T�`��9�By|A��\�C��^�j�+>��9łƸ�""��X�����/�kq�%Y*��Q�l��ʅ�eԡ3�f(\d;��T�b�|�����3.��2ޜ��c�|�_+&��D���$q�U��rI�X��1��aYqh���]���i��ϵOImCbl6�����!�#��ѻy#�	c���;8��Ѳ�G�a�k۶�db*����\��b���T
51�
�����5>�Tx����0ƭ�@ݣ�gG	ą_6�ڰ���	�Rc[i���t�W)���Ƭ�-�C�"X��dVh�sQ9�UXe�˺(�:Ԛ���������w�X]@�?����VT�S�-�Y���P��'*/��+`3�] E%��P��\R`9s��꒗�ה���?�k�5Ɨs�*	*_�/7k[_M�I���E�m*[��Z�����Y�ש~/�>�JB�Y�}���Q^r�Vf�_=�y�U(� Ή��UA��$�~ZP~�8��%���Y�ߐ���).��g��a�( (�E�BX1���k甅��ADΣNE7��J��V����+��A�W
�1�|�|	YӾq�,��;�_'��ֈ��;���u���.X�&Nk!���[{KW �9�y�3u�Չ>!l1���g0���"\����чN�9�.�����E�S�NνD"ru��i�qf�q�,�-1�E$�S8�#.HL���MG9!v���W�����.}Bt�Ő�u���>$���s(��`�D�4�D�9>:�P��3��;�$�����x�D!�514�a�_�d�&��(�qA���	��ϋ��1�Ϝ�8�.�+���	�O�=^�>����QJ�&]R�|�)Ζ�)+Al(�٥V`k����$M���� U��	?����J���܇�y��	l�n��.n�}HIΘ-2T	����r��@�
�x�/&-Q�kyk��M:�䎨�:�4+�=a;{��l�-���v����͉�&���R/���kA��i�<�,Ƞ�"o��=c��D\Ⱦ�gM��S%@^����rӶp}��c|n���S�|�\s�A�$�q�w�[H��9^��n�֣IzH)�ń��G0
�V�����2�b5c�ꚦm�;�.2�Ԅ�O���9��6r�ݡ����+sk���4"p
������>��ݗs\�36$-W����S�L`��'����h��P]tl��`�>��n �yr+N��:5��Z�hop�f��8q�˃r�UY�n�C!�#Z�RR]8�E���$�ӈO���.ưz/L��]G�&��l=co;@��.�ӈS�� Y��4M#~�I%�1F�7#׋r�v���	��{�u��s��J��<=��*�� -qhD��"�V?b�.����'=?��mo6�u�H�$�Mb��}�w�#A�"3d���9M���Pڗ�㒄IWC�#K*���{��;�#R�M��i����A�7A��^��\������M)V7-1*�$�ۅ���# �\�~0�6"�`t��<+�'�~��Ҷ"��Ŭc�be���ϵ	L2��1k��ܹ�%	`�y��l#�X�-�BJ��[J��ά�����4���\����4�)�p���u�S2�M��6"�`q�ξd��y�x�A�'�,	=&7����̕CD�2`�����u�C,�._icrSw��\�/�1��ox�9K�o�o����B�{m�m���bc�����f=���t�%R���!R)_�GĬ����#;&�ʿ4]z��j�&��~�W�+��г�r6���t�h=�ʢ�;���t��g��������]k��������%E�z1J�@9o@�W0e�ܵ��t %�'�`G挼�B��:��q�ټ#�σ4������Z�f�#�Al��:%1�u
%&�/�g�Ϣ�ED�~�RW���������CP��r6���9و�Q����6$!o�`#j^��D��4K�R����4J�@l$�pz��*&�>Xqz�]�2�`��Z&�:����DC9kz����`�������h�V�9�3���DC�1X�f�	��L4�o'	�����L4��{�Q����g��L4�����B�@Mr��ΏF9H�H��a����?*'����y ���oT��#��]��s���o�>Q"�|m��ů��,��q�	�Lě�c�ʗ�$�⅂���.u� �#�(��Z7T��6mk�:�
5M�z��&�]C@��!*��q�k�0��L�P��r~��%̍�+T~��%�E��t ��x��"�c�oD�6	s��N�"�h�v>-��/�q�B���0���������0���W�#�6�)a.��}�%
}|��2�~(FE���p;!̥0�]k}4J#���+�a.�o[�7���-�)a����H��ܺ����<#��D^�����$vW��\��r���M��p�#�Żm<x�|��1�:�z����k�����K�_Ϯ�hln�b|a������d��u��o���
���f�rg[?}+������+�f����?~+��3���=e3a-h���Pb~�^*�5��[-�J�����3��f�|+�m�qa~�NV�b��s�~�V<��g�Ö���	O�T��q�N4��[��~�N�8��x�nC���T"jݩ���y1I���q�߬hv1�7b�OI��pKSĎ�cVcP��2a�o��S��6�ۋ���{��|��Ϯ�]b��;�_���R��O���r.�S괧$�?׊�0��zuJ3pG�˄��N��^�LPߜ_S��q��'�=Q!pR�^�e�jfV_ݔz���Wv��t2�N�]��QQ}���ѝ�R@��BB6�m\fR��nN'��I%���x���d�{',�]ݝN��+O!���$����ډ|�dd"��Q�L�𛔴�^(MD��$ψ+7|�h��xWb�f�d &J��^	er��S�qVH���(z��� ��%��2� �)
��)5��Z�I��g
~��+��ȕd �-�e�R�Y"%�?��k��g���X��5�4�oW���@9�0�´s.���^��)�ޣ�� ��� �?�@,E���?�-@a�ՅM�O�e�SiZۃo��0����T��-e����9���'�����J�����r�)d���_�(SdJD�)��8�%��N�OH�����x�f�ғK��$����%}���HOw�
�?/J%�a�z�p.a�r�{���1:�le�A�?m��(1�钵�ۧܙ���Ww�!����P��*�yKt��±�y����(&"�G�c{?@��!.��}0�]��͙^�����,�Q�NF������7c����� |N��?���l!Ħ@�%�9�YD���Ͻ����� ��b &�N�G^�9�m����5[��Y�>��{���og��S�]6��x3�ן0�O���Y�1�!������o�y=b��j�(��/	Q��!��N��k"ʷ߈�>���cb�8f��cZ���_"m�%�;��y�C�-��N�J�?؎r�Ot���ε��-DBm!J����Z$6�X$�%i�q2���_�\���z����T����J&ZI/��Z�{st(���/9B2�1D�q'�ЏO3$v"���B���V����BEn�0,�;y?��zo��x�rb��qKn�hdU��4]j��Al�v���bXv �&fhR���`]����~�f��4,Թ/�4�@zv����U-��B0��k����}{�-����&^���%h5��r�^a����i��,|��?O��C�� b4����x9'����XkC�a�Q5��V����u
#�e]�hMn���o��.IB4�gk���	���Ϊ$������ST��*�4��C@Ӡ����r�� ������#��6�m�O�K��D�
<�\��Z6A���\T�x4�F���;cP��[{�����vB��o!����'q�$g����5�1�H��&G+��|��/���Q�	����Wy�«r�U����(����Tr@���Z뽨��V�9P|??�l20<��w���b`��Dw	��&by�@�Σ�\����B�uYv���~�&}��3�W���)DU���e��]��˗��r4����L��M����Ʉ�Rgk��`�/����!�5^�W��Ȫy�R㴼vM{�8*��H�ݿM�&DcLp (�myNQI�9���y�LI{a���{3��������D�L�@���4=�mW�Y�ㄌ1�I��3@��,4���[=�q�w�D�����h=�_bW�	�|�l�<��$����}]�����?@lX'�<����ML��t�����"�t��DiHZ��˔�eݏ�w�c�e��(5L�tb�"	����&d�{9�	�������Es-�k� ����}��!f4MӼ,˶��'����,�4�);��;4�"��$��?���yl�|՝�� Bk���Oh�iz��EM%�HB�p��X��do��Za�c���G
�p 1jsk i��uY��4M�}��4-I��CRk���B7Y&�}�$�j�c��1�%����A~��=�^G?�1��5��ݕ��6���8�����;��dv���:���U$����2����y�-�$���Đ���ݠ$�{�>�	����M�Jv�2������q,�4�����]:AW��g躦f'k���5�*{M1ix�2u�Z#�5D��L�Z'as�j�T��2͐4ˢ�ܬ1�a��Zb�k�&0͐h�,K��M���|A��Q�Z!��{�8 �y�e�f�T�	�y�
CDcl�fK��oM��T���%A��!�٘�)������a�ɘ��*7�.u՚8u�u�&i�5��DB�Z1�c��׾/��c�ʍ[�;"l�(ݢ�Un]'@\�c���tI�īz��{�
�y�IU�.����8y��LR�>�� 2�^"W�8���P�j�Ȅ݋0d�F"Wk�X7���@���n��pOe�P�L�z�����H�˖U�ٔ��>�m��jm]'"���6�S/_��i��գ��@�F���r,]����ɘ�)@d�׀L�� ;@��Ҡ^K$��ʠf+%�X
��-�p�Tw��?���������/  ss�z\�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dk4hq7yu16fpd"
path="res://.godot/imported/The-pitch-class-clock.png-7cac231f8576c564f10654916516ccb4.ctex"
metadata={
"vram_texture": false
}
 ��,�\d*�2���[remap]

path="res://.godot/exported/133200997/export-551f1c4f0f029b63325153e9af066444-pc_calc.scn"
�N| L������(list=Array[Dictionary]([])
�����<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
#���ե�J��PNG

   IHDR   �   �   $�  �iCCPsRGB IEC61966-2.1  (�u��KBQ�?jaeQPAC��5U�B�Ҡ�ՠ�Z���@����
QK���j���(�h�����u^
J乜{>�{�9�{.أ%k�x!����P�=;7�v>SO����C���E�jwجx�gժ~�_s%TC[�����y�q��ռf�p���%�O�{u���ǋ�bq��_��p�-��T�+XI�Yay9�lfE)��zI����H��� L� n&%� �<H>�eE�|�o�4˒�Ȭ���)���uE�����22�Y���W#���7���4ߺ�����<4��#p<�E���| C�ʚg�7�첬�w�|:������d^O�iZ��a�س�>��]�����=��͋?}/g�/��   	pHYs     ��  �IDATx��yxSe��I�B7
eoK�Z���W�� �"�*��(u�{�{����̝��e�uTDD��&�P(���J7J��Bi���IӤI��,)��<y�'��MΛoy�wQq`0�^@o˫'��t�
*�2'�"�����u��r~%P)-����(�n�^ A)�H�d&��� ��u�R	ۓ�&�$�)���jE���-�4�N[��<~�$��`4� �s��@��5J��
X��io*,��4%1M*`80xaN��(�_��:m���xD�+��h� ~<$(,���>>���J��$��5��"�Vaq�� X|��i����$��=�b� �RX9)> �u�|���%`��`4����`��S� ����i+�DIF�4� tWZ� ����?)-��Jb0���()G��
��^���� �(��h� �^B����Q	��M��V�ݸ�Jb0�b�o�1r�}�x\��f�٨��k��48L����=�!��(��$����U9ڻCx��Ï�Jb0�:���n�d;0K���Jو�Jb0��@)۹�9L���j@�9��h�Ѭ R��i0�HՀ$Jb0��[�Rܿ: �FӽR�\t%1M3�u����G$�������s���žo3^Q�0�]!�E{��!f��%v�PL��[ĸ�(Jb�4m�y�	$ʀ{�:�Ao䷒X��i4OR�<`���c���b(�i����ű�G��ˡ�f��k4�۶�]���w�sL,*U��z�GP�n>J��}^XRkkkٷw7�6�%'G�=*щ�ڍ	���@SP���X_M�A��:y��?Oxz~Mu5�|�%kZEyy���%%�ؿ�K/����&Xi��+�Y�f�f_.��'`م\���UU7���8�qҗ��ظ.<��������"�x~��B��i�)X��5+�s�*@֕L>��#jk:�F,���x�WJb��,�yzM^n�;wx+W�����lݲIi1��Xjy����.�^9�����BCø����ةs��h�W\'7;�C��SV�<|��Ռ=���2K�� ����<~6��x���_������ģ�Z�lZ.�UUU,[�%���;}μ�6Bf�����s�7��{��\p�y�����49		�ɹ�е�s�P�.i�֊�
.]���l��6aQ���pc���)졼�y�k��F����!�j70��T*ZEE�کD�V3a�����9�AiI	���$�mߞ]�X��^|��^���Ճ�i�^�]��D�Jb��񾯒���k4Λμ|��k��cTW�=`G��(���IS	�����K!22��2G����IN�/�Lf��i6׈q��F�fw���7��Đ�[7o������#�W�Ғ6m\ϟ��{���ؽD���N�+�v��6
��ݷ_SR"K�xw<pNoTI,�ۿK��ؿo?���߱V��
������84�yȲ���ϰ'}'۷ma�O�|�����`45j�pד��v7o��o����(+-�Ǖ?H�N��l������]�RIl�H������I���EUU��X��"��vJcW��\���ݡ_�~���������8����Jf&=z�N	� �9?���M�JbIA�h�	��e8=��o�p�B����c�r��Q�ㅅ��� �d0�;�K�j������?�R���D)EhWm+��g���'OPS]��sg),�}5eC[���X�>'F�͈ϑÇ شq=������3�W~/�ퟳ<;��$ù���6d^���sg��ْD���a:�����f|�֭* �f3Ǐ!m�6N?&G�s ��K;%�dZ~TI�qNI�`i=z�K����'OPR\$�����m3W7n��43-�ܺu���w��-�w�y� ���|$�bw�'��5���b�r���vee���������xum��=x`�#b�4���?�Jb��,vk��]G�rn�[�p!���Ӯ^������##ŷ/�J��������P�>��~ɩ��L1Mau�5l{�Q(�ߍ��w9}�/��Y���/�=}��8�~�=	l�9�X�Zt�]�V+Y��3��&!k��4�Ǟ��n�K$��@Ll��M[�A���DE�f��i�[�Z)���0��Y��9n�$��� A6���N�8�A�V}P��$�`ɛm����1p�P%EpIPP�^@��^���LτD�Ϙi� 23�`4�����n�-I�Z�f���ի���(�m�%	��y��G�����_T��<4s6]⻱|�r��h�N�$Az��NI$ɵ��X�R1r���M֕L���p��)Ds#D�nC||7�DGK�ްᣬ�ONI%';K�6=d,6J"�4����j5]��%��LAA�/�H��!�/��f䧦Zp�����}�7��RXYʺ��H���4���ذ~}���G=����)L�Py[|��N�8NqQ�����`���z������s��*����k��n����v��AQ����&8����� ���!������q��> �$�T�4�Ps�������j��Q����Y��߮����gs:��{��u�i����aݚՍ�i���E��1,z�"#��Cr�t?oX+w�����\//���Q�\f����la�/[�/_��Q!��?>����}-?��kt+cnN6�ܸ��ybPe�'��~���b��������j���)w��س{'�n�`P�<���Ʀ�8ZP��� Ҷoe̿���R: @Dp0�D���Ҫ*�=x�܊
2/_"��%�vsh�NyfΜ�^�'8�>�UFF��ϧ����]i<0����E�ܿ��/PXX��_m�	�G��hYY�a����1���Z`�ŋ\,-%''�ٌZ�&77�:�����C��������ݖv2����-`���$%%ٽ���@RRǎ���u��o,�^�իy�_�#���+����or���4���:��hTd�c�:ЦE.6rad��צeK�es51m�B��4����}�u�kJ�]$�K�3�I@�"JҌ=W�r�V����,xN� �H5*��1*�11q9��xϽ���tsOȨT*��&s�}��ݧ/ aa�l޴��^�~�Jbv��:��urRXp���B��Hh�ѪUT�/z�!#T�6���Gj�����__�<I\d$�	�k�8^(Xa��í�_��.]�da!���VU���ҕLȻc�V�#�����Ì� ����hѲ%#G����#\�˥W�>nS��D��zu�4���<d�6o��p���s�aU�N�c���B֕LN�w��<��$��N$5�������9�f�?b�hF�����p����y��@��P#�E�gK�ظ.�����F�m�}��k'�T*�9�����3g���17o޴�m��Yj��G.�N�׷L��$���`֣O2h�P�w�QTd��BJ�]:��f�ث���-v������Rk��JE\�xF�C���}̆_8=�;�J"	��U*	��IH�~;�u�6L��SQYh�$Aew���L��FW�@C��W��ԓ(�$w A=�oJ����d���i��pK��Q5���8�2�.���ڭ�byB���ƽw�����:�����i�!$���s#�/555d^�d��QG�6�.���¡'�q�	�{Y�;�j�9[ץ1���d���]���q����k s�^���e�f6nX�2�r���̜�q]ď��u��eW�M�e��<��d�Q@I�QRR��%�p�'��lkP|���}�X���T��ϝ�C�;�4 a�fkҸpI7~x�/̘9[.�ܑ�N+-��]i���qq,LM�3�-(��t!K�δ_�&m�m[�i��ظ8R��g��6�Y}��ee\�^����9ګ�N��R��;�M\۴�> �Nk�:�u�є�a��$�,�W�����������{��S�8S\̵�|�gZmm-Ο 6"��3fXW u�߽;�V	��ϟ;���YMd	|Y��V�ͦbȩ#�ů,���ٮeK����<��8���T���&bLˀ��#

r�T�$M�'9
�J�E�&ȏ#���4\�(��^I�2��w�Y�m%J�F{A�^J��iK�}JJdK���: &y���M ���b�^�-��5>ձ�����V�;t�#׮q����Zv�4�,�,Z���[!չ�).&�AM�Z`sf���-}Cm�(��s����XK��T*�*��M�v=I�7V}�48�;1[���,?l�(6Z�\��:ŒS��6��eU�Jŀ��IߕFEu5=���h���Z
mB#�p���}ر}+ �-bŊv���3g���˭ϛs6J�z�J�T!C�Ng�:tdҔ������ua�	v��?�ÇPYYI����J��)�$�%!�1�Bj��kߞk������f��*�����j�9ɍ��>u���,�#"�ڵ;q]��T�v��a�T��V��u�X�W�L{�A���{�
l���� ��S����:󯯾ζ��9z��5����m�0|�h��Ԑ���-?���C�SS�XN�sL,&M%%�.�?�Z]�vqq�]�a6�I۱��?��z�ʝ:����g�Re`m]�_pL�%2(��l������ة�g����m۵硙�y��=����{�YfUV:d6��&���A�A������QVZʦ�׹�����板��cOΓ:��!_���PI� ������Z��X]]MNv�	k�&44ԡP�+��Xu�R%Mp��]XX���|����w˖��Ћ���{$��vIP��mK��eb��V�]*B�D�)�h�0�+ۈJ�b��<�p&Mu�XPUu�#��e�eL�yQ�� Ѫ#���ŕ���Ӷoc�1��w�Kyy���HCڶu^�P�q�{ꗜʌ���С# �)�I�՛�؝w:��n�r:"��l�����#G;�kkk�����z5��U�MiI	�/��Ӏx�J�2t�v�0p0�{�� u�����f��.�K"� �t�I�:m��h�����iMrJ�9��^ii	o��!&6���r��A���+�/�wO��s�$�uY�>ئ'�k� �=��%n���\�˵;v5/Wj�֏�:��滲�|��He_��� '�u��4���ۻ�:(p����\�Ql�$'Ok��l�ݶ���Q���p*�^�-��zLl�?��X�XbM�o���-1�����p44^t��T,	����3ĺ]�1`�`���t��ۉ���F.�1t����0&�����t�$z��AQDc��)L�4U�[�'N���r�lOcӓTVV�<����˗.��<u�_2��}��v��]�����(*�R��6}��SY�v5'O㶊�V�限���S��ϣkl�$���U?�m-t��Cʔ��Z4�$z�6�`4����Ru�ѓ�/�Daa�/]$�j�EE�cM�RFll���yc;'��p:���y��];l�	�ْ䍯�m�N�h.PO���� D_{EG�%:Z�T��]Or�F%_��ݏ��9OIY���'w'�݇�봕�^��t��$z���>��#;�ٸ	�$mɹE���(9+�uڟ�U~�t��'1��|���d�:a=6x�p��!)�Y��i];����{ԯ�	H"����ŵ�Г\//糿��3��O�'Nf��$�_�0Y}�ӓ=v�\�fu���k�q�HՌ�RW,����k���^�=YY��Z���O0~�)�5O{�'a?g2�L�d�vNr�F%�vn��҂��?KrJ��؆��r^9P�u�j�1 ߛ�p�* �k�+�{M��봎�h�ൗ�^���x{]3�dC���o��?��I�̐������>�b�u�x��n�۞$$�s����'��v����i��B�?^G�@=ڏ{�Q�Y\;w���ة��+Dc;�{_/�k
m0�:!�����>w
f���������E�p��isݞ���Y��'B ����qF����<���0� �h�h���UAI �:�A���*w�6#U����7���u�-�Ł���S�`-1����z�v0��E)��G�:��b�T���t/®q��n��)CbDOm&�.��h ��y�#y�TQ� �t��`4% h��H�y`��WH�!E�ӞFaI�֌�lG;�;$O�c��E�mFj�7���XR=E�\��i"BԺ,�6nS�vs}ڬ�����`)�tg3ن`�z��d��f�����zj7>���ɭ �pjf���!z�A%�pV/�u�KJ	��F�T�}$ k�\@����aY*������7B�z'S��=�� �Il1M�b|�GNJz���bs�&������xx	�2.(������P��U�:FS�,����8br���U��@!����Ѥ�!�s<�H	�e�!O��gI��&�$����`��_Yb|�
!��W9ە�9�MRIl1Ma�H������]�� ��ly��M��i�J����
!h,���L;}���Q��^Wq�v�Sg��p�Ioo�+h��9���`�(s�*FȖ���4�^��m.4��]E�    IEND�B`�H\0���ԮEia�   0e/����   res://icon.svg���xx�<   res://pc_calc.tscnƞ^�,��Y   res://PSCalc192.png�{���Ow   res://PSCalc 432 Background.png#�7��)l   res://PSCalc 432 Foreground.png�b�=0�*   res://PSCalc Icon.png-lb���m   res://The-pitch-class-clock.pngqq�ECFG      application/config/name         Pitch Set Calculator   application/run/main_scene         res://pc_calc.tscn     application/config/features$   "         4.1    Forward Plus        application/boot_splash/bg_color       ? ?  ?  �?   application/boot_splash/image          res://PSCalc Icon.png      application/config/icon         res://icon.svg  "   display/window/size/viewport_width      �  #   display/window/size/viewport_height      k     display/window/size/resizable             display/window/stretch/mode         canvas_items#   rendering/renderer/rendering_method         gl_compatibility4   rendering/textures/vram_compression/import_etc2_astc         2   rendering/environment/defaults/default_clear_color      ��?��?���>  �?�~