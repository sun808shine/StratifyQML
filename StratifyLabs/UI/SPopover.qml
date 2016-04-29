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
import QtQuick.Window 2.2
import "SCustomize.js" as Theme
import "Fa-4.5.0.js" as Fa

SItem {

    id: base;
    property alias title: textTitle.text;
    property alias content: textContent.text;
    property real pixelRatio: Screen.devicePixelRatio;

    // TODO: to add Dismissive popover functionality
    property string trigger: ""

    type: "popover";
    visible: false;
    opacity: 0
    z: parent.z + 1

    property string currentStyle;

    implicitWidth: Math.max(textTitle.width, textContent.width) + 2*Theme.popover_arrow_width;
    implicitHeight: rectanglTitle.height + rectangleContent.height + 2*Theme.popover_arrow_width;

    property string position: "left";

    font_size: Theme.font_size_small;
    padding_vertical: Theme.padding_small_vertical;
    padding_horizontal: Theme.padding_small_horizontal;

    property bool popoverVisible: false
    onPopoverVisibleChanged: {
        if( currentStyle != style ){
            updateStyle();
            currentStyle = style;
            canvas.requestPaint();
        }
    }
    states: [
        State { when: popoverVisible;
            PropertyChanges {
                target: base;
                opacity: 1.0;
                visible: true
            }
        },
        State { when: !popoverVisible;
            PropertyChanges {
                target: base;
                opacity: 0.0;
                visible: false;
            }
        }
    ]

    transitions: Transition {
        NumberAnimation { property: "opacity"; duration: 250 }
    }

    function updateStyle(){
        var items = parseStyle();
        var i;
        for(i=0; i < items.length; i++){
            if( items[i] === "left" ){
                position = items[i];
                anchors.verticalCenter = parent.verticalCenter;
                anchors.horizontalCenter = undefined;
                x = -1*width;
                y = 0;
            } else if( items[i] === "right" ){
                position = items[i];
                anchors.verticalCenter = parent.verticalCenter;
                anchors.horizontalCenter = undefined;
                x = parent.width;
                y = 0;
            } else if( items[i] === "top" ){
                position = items[i];
                anchors.verticalCenter = undefined;
                anchors.horizontalCenter = parent.horizontalCenter;
                x = 0;
                y = -1*height;
            } else if( items[i] === "bottom" ){
                position = items[i];
                anchors.verticalCenter = undefined;
                anchors.horizontalCenter = parent.horizontalCenter;
                x = 0;
                y = parent.height;
            }
        }
    }

    SRoundedRectangle {
        id: rectanglTitle;
        x: Theme.popover_arrow_width;
        y: Theme.popover_arrow_width;
        color: Theme.popover_title_bg;
        width: parent.width;
        height: textTitle.height;
        radius: Theme.btn_border_radius_small;
        borderColor: Theme.panel_default_border;

        implicitWidth: textTitle.width;
        implicitHeight: textTitle.height;

        Text {
            id: textTitle;
            topPadding: Theme.padding_base_vertical;
            bottomPadding: Theme.padding_base_vertical;
            leftPadding: Theme.padding_base_horizontal;
            rightPadding: Theme.padding_base_horizontal;
            color: Theme.text_color;
            font.pointSize:  Theme.font_size_base;
            font.family: openSansLight.name;
            font.weight: Font.Light;
            width: implicitWidth > Theme.popover_max_width ? Theme.popover_max_width : implicitWidth;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
        }
    }

    SRoundedRectangle {
        id: rectangleContent;
        x: Theme.popover_arrow_width;
        y: Theme.popover_arrow_width + rectanglTitle.height;
        color: Theme.popover_bg;
        width: parent.width;
        height: textContent.height;
        radius: Theme.btn_border_radius_small;
        borderColor: Theme.panel_default_border;

        implicitWidth: textContent.width;
        implicitHeight: textContent.height;

        Text {
            id: textContent;
            topPadding: padding_vertical;
            bottomPadding: padding_vertical;
            leftPadding: padding_horizontal;
            rightPadding: padding_horizontal;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            color: Theme.text_color;
            font.pointSize: font_size;
            font.family: openSansLight.name;
            font.weight: Font.Light;
            width: implicitWidth > Theme.popover_max_width ? Theme.popover_max_width : implicitWidth;
        }

    }



    Canvas {
        id: canvas;
        antialiasing: true;
        //double the height and scale down for retina displays
        width: (parent.width)*pixelRatio;
        height: parent.height*pixelRatio;
        transform: Scale { xScale: 1.0/pixelRatio; yScale: 1.0/pixelRatio; }

        onPaint: {
            var ctx = getContext("2d");
            var twidth;
            var theight;

            ctx.save();
            ctx.clearRect(0,0,width,height);
            ctx.lineWidth = 3;
            ctx.strokeStyle = Theme.popover_bg;
            ctx.fillStyle = ctx.strokeStyle;
            ctx.globalAlpha = Theme.popover_opacity;
            ctx.lineJoin = "round";

            ctx.beginPath();

            if( (position === "left") || (position === "right") ){
                twidth = Theme.popover_arrow_width*2;
                theight = Theme.popover_arrow_width*4;
            } else {
                twidth = Theme.popover_arrow_width*4;
                theight = Theme.popover_arrow_width*2;
            }

            if( position === "left" ){
                // draw the triangle on the right
                ctx.translate(width-twidth-1, height/2);
                ctx.moveTo(0,-theight/2);
                ctx.lineTo(twidth, 0);
                ctx.lineTo(0,theight/2);
            } else if( position === "right" ){
                // draw the triangle on the left
                ctx.moveTo(0,height/2);
                ctx.lineTo(twidth, height/2-theight/2);
                ctx.lineTo(twidth,height/2+theight/2);
            } else if( position === "top" ){
                // draw the triangle on the bottom
                ctx.translate(width/2, height-theight);
                ctx.moveTo(-twidth/2,0);
                ctx.lineTo(0, theight);
                ctx.lineTo(twidth/2,0);
            } else if( position === "bottom" ){
                // draw the triangle on the top
                ctx.moveTo(width/2, 0);
                ctx.lineTo(width/2-twidth/2, theight);
                ctx.lineTo(width/2+twidth/2, theight);
            }

            ctx.closePath();
            ctx.fill();

            ctx.restore();
        }
    }




}
