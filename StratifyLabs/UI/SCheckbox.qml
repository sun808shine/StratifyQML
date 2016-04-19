/*
Copyright 2016 Tyler Gilbert

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import QtQuick 2.6
import "SCustomize.js" as Theme
import "Fa-4.5.0.js" as Fa

SBaseRectangleText {
    id: check;
    property bool checked;

    iconObject.width: font_size;
    icon: checked ? Fa.Icon.check_square_o : (Fa.Icon.square_o);
    text: "Checkbox";
    hideTextOnSkinny: false;

    bg_color: Theme.body_bg;
    text_color: Theme.text_color;
    border_color: Theme.body_bg;

    signal clicked();

    MouseArea {
        anchors.fill: parent;
        hoverEnabled: true;
        onClicked: {
            check.checked = !check.checked;
            check.clicked();
        }
        onEntered: startHover();
        onExited: stopHover();
    }

}
