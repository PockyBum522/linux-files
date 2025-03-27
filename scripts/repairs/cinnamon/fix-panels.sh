gsettings set org.cinnamon panel-zone-icon-sizes '[{"panelId":1,"left":0,"center":0,"right":24},{"left":0,"center":0,"right":0,"panelId":2},{"left":0,"center":0,"right":0,"panelId":3},{"left":0,"center":0,"right":0,"panelId":4},{"left":0,"center":0,"right":0,"panelId":5},{"left":0,"center":0,"right":0,"panelId":6}]'

gsettings set org.cinnamon panel-zone-symbolic-icon-sizes '[{"panelId":1,"left":28,"center":28,"right":16},{"left":28,"center":28,"right":28,"panelId":2},{"left":28,"center":28,"right":28,"panelId":3},{"left":28,"center":28,"right":28,"panelId":4},{"left":28,"center":28,"right":28,"panelId":5},{"left":28,"center":28,"right":28,"panelId":6}]'

gsettings set org.cinnamon panel-zone-text-sizes '[{"panelId":1,"left":0,"center":0,"right":0},{"left":0,"center":0,"right":0,"panelId":2},{"left":0,"center":0,"right":0,"panelId":3},{"left":0,"center":0,"right":0,"panelId":4},{"left":0,"center":0,"right":0,"panelId":5},{"left":0,"center":0,"right":0,"panelId":6}]'

gsettings set org.cinnamon panels-enabled "['1:0:bottom', '2:5:bottom', '3:4:bottom', '4:1:bottom', '5:3:bottom', '6:2:bottom']"

gsettings set org.cinnamon panels-height "['1:40', '2:40', '3:40', '4:40', '5:40', '6:40']"

gsettings set org.cinnamon panels-hide-delay "['1:0', '2:0', '3:0', '4:0', '5:0', '6:0']"

gsettings set org.cinnamon panels-show-delay "['1:0', '2:0', '3:0', '4:0', '5:0', '6:0']"

# Set autohide false on all panels

# gsettings set org.cinnamon panelss-autohide  ['1:false', '2:false', '3:false', '4:false', '5:intel', '6:false']    
gsettings set org.cinnamon panels-autohide "['1:false', '2:false', '3:false', '4:false', '5:false', '6:false']"


echo "### Configuring all panels ###" ######################################################################

gsettings set org.cinnamon enabled-applets   "['panel1:left:0:menu@cinnamon.org:0', 'panel1:left:2:separator@cinnamon.org:1', 'panel1:right:3:systray@cinnamon.org:3', 'panel1:right:4:xapp-status@cinnamon.org:4', 'panel1:right:5:notifications@cinnamon.org:5', 'panel1:right:6:printers@cinnamon.org:6', 'panel1:right:7:removable-drives@cinnamon.org:7', 'panel1:right:8:keyboard@cinnamon.org:8', 'panel1:right:9:favorites@cinnamon.org:9', 'panel1:right:10:network@cinnamon.org:10', 'panel1:right:11:sound@cinnamon.org:11', 'panel1:right:12:power@cinnamon.org:12', 'panel1:right:13:calendar@cinnamon.org:13', 'panel1:right:14:cornerbar@cinnamon.org:14', 'panel2:left:0:window-list@cinnamon.org:17', 'panel4:left:0:window-list@cinnamon.org:18', 'panel5:left:0:window-list@cinnamon.org:19', 'panel6:left:0:window-list@cinnamon.org:20', 'panel3:left:0:window-list@cinnamon.org:21', 'panel1:left:1:sessionManager@scollins:16']"


