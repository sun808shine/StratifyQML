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

import QtQuick 2.8
import QtQuick.Controls 2.1
import StratifyLabs.UI 2.0

Button {
    id: control

    property alias style: attr.style;
    property alias span: attr.span;
    property alias attr: attr;
    property alias label: control.text;
    property string icon;

    implicitWidth: contentItem.implicitWidth + attr.paddingHorizontal*2;
    implicitHeight: attr.fontContainerHeight;
    baselineOffset: contentItem.y + contentItem.baselineOffset;

    topPadding: attr.paddingVertical;
    bottomPadding: attr.paddingVertical;
    leftPadding: attr.paddingHorizontal;
    rightPadding: attr.paddingHorizontal;

    contentItem:  SIcon {
        id: contentIcon;
        icon: control.icon;
        label: control.text;
        attr.style: control.attr.style;
        attr.fontColor: control.attr.fontColor;
        attr.fontColorMuted: control.attr.fontColorMuted;
        attr.fontSize: control.attr.fontSize;
        attr.fontWeight: control.attr.fontWeight;
    }

    background: Rectangle {
        color: {
            if( !enabled ){
                return attr.colorDisabled;
            }

            if( control.pressed ){
                return attr.colorPressed;
            }

            if( control.hovered ){
                return attr.colorHovered;
            }

            return attr.color;
        }
        border.color: enabled ? attr.borderColor : attr.colorDisabled;
        border.width: attr.borderWidth;
        radius: attr.radius;
    }


    SAttributes {
        id: attr;
        type: "btn";

        property alias icon: contentIcon.attr;

        color: STheme.btn_primary_bg;
        borderColor: STheme.btn_primary_border;
        fontColor: STheme.btn_primary_color;

        onStyleChanged: {
            var items = parseStyle();
            attr.radius = STheme.btn_border_radius_base;
            for(var i = 0; i < items.length; i++){
                if( (items[i] === "btn-primary") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_primary_bg; });
                    attr.fontColor = Qt.binding(function(){ return STheme.btn_primary_color; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_primary_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.1); });
                } else if( (items[i] === "btn-outline-primary") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_primary_color; });
                    attr.fontColor = Qt.binding(function(){ if( control.hovered || control.pressed ){ return STheme.btn_primary_color; } return STheme.btn_primary_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_primary_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return STheme.btn_primary_bg; });
                } else if( (items[i] === "btn-default") || (items[i] === "btn-secondary") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_secondary_bg; });
                    attr.textColor = Qt.binding(function(){ return STheme.btn_secondary_color; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_secondary_border; });
                    attr.textColorMuted = Qt.binding(function(){ return STheme.text_muted; });
                    attr.colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.1); });
                } else if( (items[i] === "btn-outline-default") || (items[i] === "btn-outline-secondary") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_secondary_color; });
                    attr.fontColor = Qt.binding(function(){ if( control.hovered || control.pressed ){ return STheme.btn_secondary_color; } return STheme.btn_secondary_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_secondary_border; });
                    attr.textColorMuted = Qt.binding(function(){ return STheme.text_muted; });;
                    attr.colorHovered = Qt.binding(function(){ return STheme.btn_secondary_bg; });
                } else if( (items[i] === "btn-danger") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_danger_bg; });
                    attr.textColor = Qt.binding(function(){ return STheme.btn_danger_color; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_danger_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.1); });
                } else if( (items[i] === "btn-outline-danger") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_danger_color; });
                    attr.fontColor = Qt.binding(function(){ if( control.hovered || control.pressed ){ return STheme.btn_danger_color; } return STheme.btn_danger_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_danger_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return STheme.btn_danger_bg; });
                } else if( (items[i] === "btn-success") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_success_bg; });
                    attr.textColor = Qt.binding(function(){ return STheme.btn_success_color; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_success_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.1); });
                } else if( (items[i] === "btn-outline-success") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_success_color; });
                    attr.fontColor = Qt.binding(function(){ if( control.hovered || control.pressed ){ return STheme.btn_success_color; } return STheme.btn_success_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_success_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return STheme.btn_success_bg; });
                } else if( (items[i] === "btn-info") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_info_bg; });
                    attr.textColor = Qt.binding(function(){ return STheme.btn_info_color; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_info_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.1); });
                } else if( (items[i] === "btn-outline-info") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_info_color; });
                    attr.fontColor = Qt.binding(function(){ if( control.hovered || control.pressed ){ return STheme.btn_info_color; } return STheme.btn_info_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_info_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return STheme.btn_info_bg; });
                } else if( (items[i] === "btn-warning") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_warning_bg; });
                    attr.textColor = Qt.binding(function(){ return STheme.btn_warning_color; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_warning_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.1); });
                } else if( (items[i] === "btn-outline-warning") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_warning_color; });
                    attr.fontColor = Qt.binding(function(){ if( control.hovered || control.pressed ){ return STheme.btn_warning_color; } return STheme.btn_warning_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_warning_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return STheme.btn_warning_bg; });
                } else if( (items[i] === "btn-naked") ){
                    attr.color = "transparent";
                    attr.fontColor = Qt.binding(function(){ return STheme.text_color; });
                    attr.borderColor = attr.color;
                    attr.textColorMuted = attr.fontColor;
                    attr.colorHovered = attr.color;
                } else if( (items[i] === "btn-close") ){
                    attr.color = "transparent";
                    attr.textColor = Qt.binding(function(){ return STheme.text_muted; });
                    attr.borderColor = "transparent";
                    attr.textColorMuted = Qt.binding(function(){ return STheme.text_muted; });
                } else if( (items[i] === "btn-lg")){
                    attr.radius = Qt.binding(function(){ return STheme.btn_border_radius_large; });
                    attr.fontSize = Qt.binding(function(){ return STheme.font_size_large; });
                    attr.paddingVertical = Qt.binding( function(){ return STheme.padding_large_vertical; });
                    attr.paddingHorizontal = Qt.binding( function(){ return STheme.padding_large_horizontal; });
                } else if( (items[i] === "btn-block")){
                    attr.blockWidth = true;
                } else if( (items[i] === "btn-sm")){
                    attr.paddingVertical = Qt.binding( function(){ return STheme.padding_small_vertical; });
                    attr.paddingHorizontal = Qt.binding( function(){ return STheme.padding_small_horizontal; });
                    attr.radius = Qt.binding(function(){ return STheme.btn_border_radius_small; });
                    attr.fontSize = Qt.binding(function(){ return STheme.font_size_small; });
                } else if( (items[i] === "btn-xs")){
                    attr.paddingVertical = Qt.binding( function(){ return STheme.padding_xs_vertical; });
                    attr.paddingHorizontal = Qt.binding( function(){ return STheme.padding_xs_horizontal; });
                    attr.radius = Qt.binding(function(){ return STheme.btn_border_radius_small; });
                    attr.fontSize = Qt.binding(function(){ return STheme.font_size_small; });
                }
            }
        }
    }
}