# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-soundfish

CONFIG += sailfishapp

SOURCES += src/soundfish.cpp

OTHER_FILES += qml/harbour-soundfish.qml \
    qml/cover/*.qml \
    qml/pages/*.qml \
    rpm/harbour-soundfish.changes.in \
    rpm/harbour-soundfish.spec \
    translations/*.ts \
    harbour-soundfish.desktop \
    soundfish/*
    qml/pages/AuthPage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-soundfish-de.ts

# include python modules
include(third/requests.pri)
include(third/soundcloud.pri)

python_files.files = py/
python_files.path = /usr/share/$$TARGET/

third_requests_files.files = third/
third_requests_files.path = /usr/share/$$TARGET/

INSTALLS += python_files third_requests_files
