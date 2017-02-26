import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Sliders";

    EHeading {
        title: "Sliders";
        inherits: "QtQuick.Controls 2.0 Slider";
        stratifyName: "SSlider";
    }

    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Colors"; }
    SliderExampleColors{}
    ECodeExample { source: "SliderExampleColors"; }

    ESectionTitle { text: "Sizes"; }
    SliderExampleSizes{}
    ECodeExample { source: "SliderExampleSizes"; }

}
