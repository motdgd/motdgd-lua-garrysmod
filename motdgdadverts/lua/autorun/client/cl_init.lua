motdgdbutton = NULL
motdgdhtml = NULL
motdgdwindow = NULL
motdgdseconds = 0

function showMotdGD( userid, forced, ip, port, steamid, version, seconds )
        motdgdseconds = seconds
        
        motdgdwindow = vgui.Create( "DFrame" )
        motdgdwindow:SetSize( ScrW()*0.9, ScrH()*0.9 )
        motdgdwindow:Center()
        motdgdwindow:SetTitle( "MOTDgd.com Advertisement" )
        motdgdwindow:ShowCloseButton( false )
        motdgdwindow:SetDraggable( false )
        motdgdwindow:SetVisible( true )
        motdgdwindow:MakePopup()
        
        local motdgdhtml = vgui.Create( "HTML", motdgdwindow )
        
        motdgdbutton = vgui.Create( "DButton", motdgdwindow )
        motdgdbutton:SetSize( 100, 40 )
        motdgdbutton:SetPos( (motdgdwindow:GetWide() - motdgdbutton:GetWide()) / 2, motdgdwindow:GetTall() - motdgdbutton:GetTall() - 10 )
        motdgdhtml:SetSize( motdgdwindow:GetWide() - 20, motdgdwindow:GetTall() - motdgdbutton:GetTall() - 50 )
        motdgdhtml:SetPos( 10, 30 )
        motdgdhtml:OpenURL( "http://motdgd.com/motd/?user="..userid.."&fv="..forced.."&ip="..ip.."&port="..port.."&st="..steamid.."&v="..version.."&sec="..seconds )
        
        if (forced < 1) then
                enableMotdGDClose()
        else
                motdgdbutton:SetDisabled( true )
                timer.Create( "motdgdtimer", 1, 1, motdGDCountDown )
        end
end

function enableMotdGDClose()
        motdgdbutton:SetDisabled( false )
        motdgdbutton:SetText( "Close" )
        motdgdbutton.DoClick = function() motdgdwindow:SetVisible( false ) end
end

function motdGDCountDown()
        motdgdseconds = motdgdseconds - 1
        
        if (motdgdseconds <= 0) then
                enableMotdGDClose()
        else
                motdgdbutton:SetText( motdgdseconds.." second(s)" )
                timer.Create( "motdgdtimer", 1, 1, motdGDCountDown )
        end
end
