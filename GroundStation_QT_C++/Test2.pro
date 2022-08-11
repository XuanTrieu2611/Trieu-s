QT += quick qml network core positioning location charts gamepad

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        liveimageprovider.cpp \
        main.cpp \
        udp.cpp

RESOURCES += qml.qrc
#OTHER_FILES += main.qml \
#UI/indicator/CustomImage.qml \
#UI/indicator/AttitudeIndicator.qml \
#UI/indicator/Gridinfor.qml \
#UI/indicator/HeadingIndicator.qml \
#UI/indicator/ControlPanel1.qml \
#UI/map/MapBox.qml \
#UI/indicator/CustomCanvas.qml \
#UI/indicator/CustomForeground.qml \
#UI/indicator/CustomNeedle.qml \
#UI/indicator/CustomText.qml \
#UI/indicator/GaugeMask.qml \
#UI/indicator/PropellerGauge/PropellerGauge.qml \
#UI/indicator/PropellerGauge/PropellerGaugeStyle.qml


# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    MarkerModel.h \
    liveimageprovider.h \
    udp.h

#DISTFILES += \
#    UI/indicator/CustomCanvas.qml \
#    UI/indicator/CustomForeground.qml \
#    UI/indicator/CustomNeedle.qml \
#    UI/indicator/CustomText.qml \
#    UI/indicator/GaugeMask.qml \
#    UI/indicator/PropellerGauge/PropellerGauge.qml \
#    UI/indicator/PropellerGauge/PropellerGaugeStyle.qml

DISTFILES += \
