
-- If we are on the simulator, show a warning that this plugin is only supported on device
local isSimulator = "simulator" == system.getInfo( "environment" )

if isSimulator then
	native.showAlert( "Build for device", "This plugin is not supported on the Corona Simulator, we need to build app to test on an iOS/Android device or Xcode simulator", { "OK" } )
end

-- Hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- Require the widget library
local widget = require( "widget" )

-- Use the iOS 7 theme for this sample
widget.setTheme( "widget_theme_ios7" )

-- This is the name of the native popup to show, in this case we are showing the "social" popup
local popupName = "social"

-- Display a background

local background = display.newImageRect( "wood.png", 520, 780 )
background.x = 160
background.y = 240

local logo = display.newImageRect( "monkey.png", 320, 240 )
logo.x = 160
logo.y = 180
 
 
--[[gradient = graphics.newGradient(
	{ 0.741, 0.796, 0.863 },
	{ 0.435, 0.532, 0.243 }, "down" )
globalImage = display.newRect( 0, 0, 520, 780 )
globalImage:setFillColor( gradient )
globalImage.x=160
globalImage.y=240--]]
-- Display some text
local achivementText = display.newText 
{
	--text = "Share messages with other apps!",
	text = " ",
	x = display.contentCenterX,
	y = 0,
	-- Keep our text field within inner 80% of the screen so that it won't roll off on some devices.
	width = (0.8) * display.contentWidth,
	height = 0,
	font = native.systemFontBold,
	fontSize = 12,
	align = "center",
}

local sendMessage = false
local sendURL = false
local sendImage = false



-- Exectuted upon touching & releasing a widget button
local function onShareButtonReleased( event )
	local serviceName = event.target.id
	local isAvailable = native.canShowPopup( popupName, serviceName )

	-- currently test popup for android
	if "Android" == system.getInfo( "platformName" ) then
		isAvailable = true
		
	end

	-- If it is possible to show the popup
	if isAvailable then
		local listener = {}
		function listener:popup( event )
			print( "name(" .. event.name .. ") type(" .. event.type .. ") action(" .. tostring(event.action) .. ") limitReached(" .. tostring(event.limitReached) .. ")" )			
		end
		
		local options = {}
		options.service = serviceName
		options.listener = listener
		if sendMessage then 
			options.message = userNameField.text
		end
		if sendURL then
			options.url = { "http://www.coronalabs.com" }
		end
		if sendImage then
			if media.hasSource( media.PhotoLibrary ) then --might want to change to if image is uploaded
				
		
				options.image = {
					{ 
				
				
 					filename = "test.jpg",  baseDir=system.TemporaryDirectory
					},
				}
			else
				options.image = {
					{ 
				
				
 					filename = "Icon.png", baseDir = system.ResourceDirectory
					},
				}
		end
			
		end
		
		native.showPopup( popupName, options )
	else
		if isSimulator then
			native.showAlert( "Build for device", "This plugin is not supported on the Corona Simulator, we need to build for an iOS/Android device or the Xcode simulator", { "OK" } )
		else
			-- Popup isn't available.. Show error message
			native.showAlert( "Cannot send " .. serviceName .. " message.", "Please setup your " .. serviceName .. " account or check your network connection (on android this means that the package/app (ie Twitter) is not installed on the device)", { "OK" } )
		end
	end
end
   --other features to consider: audio and video compression/sending
local function onComplete( event )
   local uploadPic = event.target
   

   
		if event.completed == true and uploadPic then
		
		
		 --add the compression/encoding etc algorithm and other filters here!?
		local function encodeImage( event  )


		end
		encodeImage()
		
		
		
		
		
	 print( "photo w,h = " .. uploadPic.width .. "," .. uploadPic.height )
		
			--step 1: scaleFactor to suit all aspect ratios
			local widthScaleFactor = (320/480) / (display.pixelWidth/display.pixelHeight)
			uploadPic.width = uploadPic.width * widthScaleFactor
			--step 2: resize to fit within rectangle and make sure image isn't too small
			local maxChatPicHeight = 100
			local maxChatPicWidth = 100
			local minChatPicHeight = 20
			local minChatPicWidth = 20
			if uploadPic.height > maxChatPicHeight then
				uploadPic.width = math.ceil( uploadPic.width * (maxChatPicHeight/uploadPic.height) )
				uploadPic.height = maxChatPicHeight
			end
			if uploadPic.width > maxChatPicWidth then
				uploadPic.height = math.ceil( uploadPic.height * (maxChatPicWidth/uploadPic.width) )
				uploadPic.width = maxChatPicWidth
			end
			if uploadPic.height < minChatPicHeight then uploadPic.height = minChatPicHeight end
			if uploadPic.width < minChatPicWidth then uploadPic.width = minChatPicWidth end
			
			uploadPic.x = display.contentWidth/2 
			uploadPic.y = 225
			  
 display.save( uploadPic, { filename="test.jpg", baseDir=system.TemporaryDirectory, isFullResolution=true, backgroundColor={0,0,0,0} } )
    
		end
		
		
		
		

  
end




    	    --no support on simulator? 
local function onSwitchPress( event )
 
    local switch = event.target
    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
    if switch.id == "message" then
    	sendMessage = switch.isOn
    elseif switch.id == "url" then
    	sendURL = switch.isOn
    elseif switch.id == "image" then
    
    if switch.isOn then
	local function onAlertClick( event )
	if "clicked" == event.action then
		local i = event.index
		
-- REMOVE OLD IMAGES THAT ARE DISPLAYED		
		if i == 1 then
			if media.hasSource( media.Camera ) then
    		media.capturePhoto( 
    		{listener=onComplete, 
    		--destination = {baseDir=system.TemporaryDirectory,  filename="test.jpg", type="image"}    
    		})
			else
   	  			native.showAlert( "Corona", "This device does not have a camera.", { "OK" } )
			
			end
			 
-- REMOVE OLD IMAGES THAT ARE DISPLAYED
		elseif i == 2 then
					
		media.selectPhoto(
    	{
        	mediaSource = media.PhotoLibrary ,
        	listener = onComplete,  
        	permittedArrowDirections = { "right" }
        	--destination = { baseDir=system.TemporaryDirectory, filename="test.jpg", type="image" } 
    	})
      
 
		else

			switch:setState( { isOn=false  } )
		end
		end
	end			


local alert = native.showAlert( "Type of photo", "Take photo from camera or device?" , { "Camera", "Device", "Cancel" }, onAlertClick )
	

    
    --THIS HAD WRONG FORMAT!!! is it in log/terminal?? or silent
 --    media.selectPhoto( {mediaSource = media.PhotoLibrary,listener = onComplete, 
   --		{ destination = 
   	--	{baseDir=system.TemporaryDirectory,  filename="sc.jpg", type="image"}    } })
     
	
	--testImage:scale(.25,.25) 
    end

	 
    	sendImage = switch.isOn
    end
end

   





-- Create the checkbox for sending a message
local messageCheckbox = widget.newSwitch
{
    left = 50,
    top = 20,
    style = "checkbox",
    id = "message",
    onPress = onSwitchPress
}
local messageLabel = display.newText("Send text", messageCheckbox.x + 35, messageCheckbox.y, native.systemFont, 20)
messageLabel:setFillColor(1)
messageLabel.anchorX = 0

-- text field for sending messages
	function userNameFieldHandler(event)
		 
	end
userNameField = native.newTextField( messageCheckbox.x + 85, messageCheckbox.y+35,  200, 30)
userNameField:addEventListener( "userInput", userNameFieldHandler )
userNameField.font = native.newFont( "HelveticaNeue-Light", 18 )
userNameField.text = "enter custom message here"


--local myGroup = display.newGroup()
--myGroup:insert( rect )



-- Create the checkbox for sending a URL
local urlCheckbox = widget.newSwitch
{
    left = 50,
    top = 95,
    style = "checkbox",
    id = "url",
    onPress = onSwitchPress
}
local urlLabel = display.newText("Send URL", urlCheckbox.x + 35, urlCheckbox.y, native.systemFont, 20)
urlLabel:setFillColor(1)
urlLabel.anchorX = 0

-- Create the checkbox for sending an image
local imageCheckbox = widget.newSwitch
{
    left = 50,
    top = 145,
    style = "checkbox",
    id = "image",
    onPress = onSwitchPress
}
local imageLabel = display.newText("Send Image", imageCheckbox.x + 35, imageCheckbox.y, native.systemFont, 20)
imageLabel:setFillColor(1)
imageLabel.anchorX = 0


-- Use the share intent on Android to get any platform we could want
if "Android" == system.getInfo( "platformName" ) then
	-- Create a background to go behind our widget buttons
	local buttonBackground = display.newRect( display.contentCenterX, display.contentHeight - 25, 220, 50 )
	buttonBackground:setFillColor( 5 )

	-- Create a share button
	local shareButton = widget.newButton
	{
		id = "share",
		left = 0,
		top = 430,
		width = 240,
		label = "Show Message",
		onRelease = onShareButtonReleased,
	}
	shareButton.x = display.contentCenterX
else -- We're on iOS and need a button for each social service we want to support
	-- Create a background to go behind our widget buttons
	local buttonBackground = display.newRect( display.contentCenterX, 380, 220, 200 )
	buttonBackground:setFillColor( 255 )

	-- Create a facebook button
	local facebookButton = widget.newButton
	{
		id = "facebook",
		left = 0,
		top = 280,
		width = 240,
		label = "Share On Facebook",
		onRelease = onShareButtonReleased,
	}
	facebookButton.x = display.contentCenterX

	-- Create a twitter button
	local twitterButton = widget.newButton
	{
		id = "twitter",
		left = 0,
		top = facebookButton.y + facebookButton.contentHeight * 0.5,
		width = 240,
		label = "Share On Twitter",
		onRelease = onShareButtonReleased,
	}
	twitterButton.x = display.contentCenterX

	-- Create a sinaWeibo button
	local sinaWeiboButton = widget.newButton
	{
		id = "sinaWeibo",
		left = 0,
		top = twitterButton.y + twitterButton.contentHeight * 0.5,
		width = 240,
		label = "Share On SinaWeibo",
		onRelease = onShareButtonReleased,
	}
	sinaWeiboButton.x = display.contentCenterX

	-- Create a tencentWeibo button
	local tencentWeiboButton = widget.newButton
	{
		id = "tencentWeibo",
		left = 0,
		top = sinaWeiboButton.y + sinaWeiboButton.contentHeight * 0.5,
		width = 240,
		label = "Share On TencentWeibo",
		onRelease = onShareButtonReleased,
	}
	tencentWeiboButton.x = display.contentCenterX
end
