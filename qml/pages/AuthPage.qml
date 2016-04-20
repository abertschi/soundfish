import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.4


Page {
    id: page
    SilicaFlickable {
        anchors.fill: parent

        Component.onCompleted: {
            py.importModule('sc_service', function () {
                py.call('sc_service.service.get_authorize_url', [], function (url) {
                    console.log("Requested authorize_url=" + url)
                    webView.url = url
                    webView.authorize_url = url
                });
            });
        }

        SilicaWebView {
            id: webView
            property string authorize_url;

            anchors.fill: parent
            url: ""
            onNavigationRequested: {
                if (request && request.url) {
                    if (("" + request.url).substr(0, 16) === "http://localhost") {
                        console.log("Soundcloud redirect_url received=" + url)

                        py.importModule('sc_service', function() {
                            var success = py.call_sync('sc_service.service.auth_user_with_redirect_url',
                                                       [request.url])

                            if (success) {
                                console.log("User successfully authenticated.")
                                app.pageStack.pop()

                            }
                            else {
                                console.log("Unable to authenticate user. Retry")
                                webView.url = authorize_url;
                                webView.reload();
                            }
                        });
                    }
                }
            }
        }
    }
}



