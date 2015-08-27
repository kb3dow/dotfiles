--[[ by mrpeachy - 
combines background bar and calendar functions
]]
require 'cairo'
require 'imlib2'

--[[
function conky_colprc2n(prc)
local prc=tonumber(conky_parse(prc))
if prc>=(100) then prc=99 end
prc=prc/10
return string.format("${color%d}",prc)
end

function conky_colprc_g2r(prc)
local r=255
local g=255
local b=0
local prc=tonumber(conky_parse(prc))
if prc<=(50) then r=((prc*2)*255/100) end
if prc>=(50) then g=(255-(prc*2-100)*255/100) end
return string.format("%02X%02X%02X",r,g,b)
end
]]

function rgb_to_r_g_b(col_a)
return ((col_a[1] / 0x10000) % 0x100) / 255., ((col_a[1] / 0x100) % 0x100) / 255., (col_a[1] % 0x100) / 255., col_a[2]
end

function conky_gradbar(bar_startx,bar_starty,number,number_max,divisions,div_width,div_height,div_gap,bg_col,bg_alpha,st_col,st_alpha,mid_col,mid_alpha,end_col,end_alpha)
if conky_window == nil then return end
local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
local cr = cairo_create(cs)
local updates=tonumber(conky_parse('${updates}'))
if updates>5 then
--#########################################################################################################
local number=conky_parse(number)
--set colors
--color conversion
local br,bg,bb,ba=rgb_to_r_g_b({bg_col,bg_alpha})
local sr,sg,sb,sa=rgb_to_r_g_b({st_col,st_alpha})
local mr,mg,mb,ma=rgb_to_r_g_b({mid_col,mid_alpha})
local er,eg,eb,ea=rgb_to_r_g_b({end_col,end_alpha})
if number==nil then number=0 end
local number_divs=(number/number_max)*divisions
cairo_set_line_width (cr,div_width)
--gradient calculations
for i=1,divisions do
if i<(divisions/2) and i<=number_divs then
colr=((mr-sr)*(i/(divisions/2)))+sr
colg=((mg-sg)*(i/(divisions/2)))+sg
colb=((mb-sb)*(i/(divisions/2)))+sb
cola=((ma-sa)*(i/(divisions/2)))+sa
elseif i>=(divisions/2) and i<=number_divs then
colr=((er-mr)*((i-(divisions/2))/(divisions/2)))+mr
colg=((eg-mg)*((i-(divisions/2))/(divisions/2)))+mg
colb=((eb-mb)*((i-(divisions/2))/(divisions/2)))+mb
cola=((ea-ma)*((i-(divisions/2))/(divisions/2)))+ma
else
colr=br
colg=bg
colb=bb
cola=ba
end
cairo_set_source_rgba (cr,colr,colg,colb,cola)
cairo_move_to (cr,bar_startx+((div_width+div_gap)*i-1),bar_starty)
cairo_rel_line_to (cr,0,div_height)
cairo_stroke (cr)
end
colr=nil
colg=nil
colb=nil
cola=nil
--#########################################################################################################
end-- if updates>5
cairo_destroy(cr)
cairo_surface_destroy(cs)
cr=nil
return ""
end-- end main function

function conky_draw_bg(r,x,y,w,h,color,alpha)
if conky_window == nil then return end
local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
local cr = cairo_create(cs)
local updates=tonumber(conky_parse('${updates}'))
if updates>5 then
--#########################################################################################################
if w=="0" then w=tonumber(conky_window.width) end
if h=="0" then h=tonumber(conky_window.height) end
cairo_set_source_rgba (cr,rgb_to_r_g_b({color,alpha}))
--top left mid circle
local xtl=x+r
local ytl=y+r
--top right mid circle
local xtr=(x+r)+((w)-(2*r))
local ytr=y+r
--bottom right mid circle
local xbr=(x+r)+((w)-(2*r))
local ybr=(y+r)+((h)-(2*r))
--bottom right mid circle
local xbl=(x+r)
local ybl=(y+r)+((h)-(2*r))
--the drawing part---------------------------
cairo_move_to (cr,xtl,ytl-r)
cairo_line_to (cr,xtr,ytr-r)
cairo_arc(cr,xtr,ytr,r,((2*math.pi/4)*3),((2*math.pi/4)*4))
cairo_line_to (cr,xbr+r,ybr)
cairo_arc(cr,xbr,ybr,r,((2*math.pi/4)*4),((2*math.pi/4)*1))
cairo_line_to (cr,xbl,ybl+r)
cairo_arc(cr,xbl,ybl,r,((2*math.pi/4)*1),((2*math.pi/4)*2))
cairo_line_to (cr,xtl-r,ytl)
cairo_arc(cr,xtl,ytl,r,((2*math.pi/4)*2),((2*math.pi/4)*3))
cairo_close_path(cr)
cairo_fill (cr)
--#########################################################################################################
end-- if updates>5
cairo_destroy(cr)
cairo_surface_destroy(cs)
cr=nil
return ""
end-- end main function

function conky_luacal(cal_x,cal_y,font,tfontsize,tc,ta,mfontsize,bc,ba,hfontsize,hc,ha,gaph,gapt,gapl,sday)
if conky_window == nil then return end
local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
local cr = cairo_create(cs)
local updates=tonumber(conky_parse('${updates}'))
if updates>5 then
--#########################################################################################################
--####################################################################################################
--title text color
local font=string.gsub(font,"_"," ")
local tred,tgreen,tblue,talpha=rgb_to_r_g_b({tc,ta})
--title text font
local tfont=font
--###################################################
--main body text color
local bred,bgreen,bblue,balpha=rgb_to_r_g_b({bc,ba})
--main body text font
local mfont=font
--###################################################
--highlight text color
local hred,hgreen,hblue,halpha=rgb_to_r_g_b({hc,ha})
--highlight font
local hfont=font
--###################################################
--spacer -- this can help with alignment enter 0, 1 space or 2 spaces between the ""
local spacer=" "
--###################################################
--calendar calcs
local year=os.date("%G")
local today=tonumber(os.date("%d"))
local t1 = os.time( {    year=year,month=03,day=01,hour=00,min=0,sec=0} );
local t2 = os.time( {    year=year,month=02,day=01,hour=00,min=0,sec=0} );
local feb=(os.difftime(t1,t2))/(24*60*60)
local monthdays={ 31, feb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
local day=tonumber(os.date("%w"))+1-sday
local day_num = today
local remainder=day_num % 7
local start_day=day-(day_num % 7)
if start_day<0 then start_day=7+start_day end     
local month=os.date("%m")
local mdays=monthdays[tonumber(month)]
local x=mdays+start_day
local dnum={}
local dnumh={}
if mdays+start_day<36 then 
dlen=35
plen=29 
else 
dlen=42 
plen=36
end
for i=1,dlen do
	if i<=start_day then 
	dnum[i]="  " 
	else 
	dn=i-start_day
		if dn=="nil" then dn=0 end
		if dn<=9 then dn=(spacer .. dn) end
		if i>x then dn="" end
		dnum[i]=dn
		dnumh[i]=dn
		if dn==(spacer .. today) or dn==today then
		dnum[i]=""
		end 
		if dn==(spacer .. today) or dn==today then
		dnumh[i]=dn
		place=i 
		else dnumh[i]="  " 
		end 
	end
end--for
cairo_select_font_face (cr, tfont, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
cairo_set_font_size (cr, tfontsize);
cairo_set_source_rgba (cr,tred,tgreen,tblue,talpha)
if tonumber(sday)==0 then
dys={"SU","MO","TU","WE","TH","FR","SA"}
else
dys={"MO","TU","WE","TH","FR","SA","SU"}
end
--draw calendar titles
for i=1,7 do
cairo_move_to (cr, cal_x+(gaph*(i-1)), cal_y)
cairo_show_text (cr, dys[i])
cairo_stroke (cr)
end
--draw calendar body
cairo_select_font_face (cr, mfont, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
cairo_set_font_size (cr, mfontsize);
cairo_set_source_rgba (cr,bred,bgreen,bblue,balpha)
for i=1,plen,7 do
local fn=i
	for i=fn,fn+6 do
	cairo_move_to (cr, cal_x+(gaph*(i-fn)),cal_y+gapt+(gapl*((fn-1)/7)))
	cairo_show_text (cr, dnum[i])
	cairo_stroke (cr)
	end
end
--highlight
cairo_select_font_face (cr, hfont, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
cairo_set_font_size (cr, hfontsize);
cairo_set_source_rgba (cr,hred,hgreen,hblue,halpha)
for i=1,plen,7 do
local fn=i
	for i=fn,fn+6 do
	cairo_move_to (cr, cal_x+(gaph*(i-fn)),cal_y+gapt+(gapl*((fn-1)/7)))
	cairo_show_text (cr, dnumh[i])
	cairo_stroke (cr)
	end
end
--#########################################################################################################
end-- if updates>5
cairo_destroy(cr)
cairo_surface_destroy(cs)
cr=nil
return ""
end-- end main function

function conky_luaimage(im_x,im_y,im_w,im_h,file)
if conky_window == nil then return end
local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
local cr = cairo_create(cs)
local updates=tonumber(conky_parse('${updates}'))
if updates>5 then
--#########################################################################################################
if file==nil then print("set image file") end
---------------------------------------------
local show = imlib_load_image(file)
if show == nil then return end
imlib_context_set_image(show)
if tonumber(im_w)==0 then 
width=imlib_image_get_width() 
else
width=tonumber(im_w)
end
if tonumber(im_h)==0 then 
height=imlib_image_get_height() 
else
height=tonumber(im_h)
end
imlib_context_set_image(show)
local scaled=imlib_create_cropped_scaled_image(0, 0, imlib_image_get_width(), imlib_image_get_height(), width, height)
imlib_free_image()
imlib_context_set_image(scaled)
imlib_render_image_on_drawable(im_x, im_y)
imlib_free_image()
show=nil
end-- if updates>5
cairo_destroy(cr)
cairo_surface_destroy(cs)
cr=nil
return ""
end-- end main function
