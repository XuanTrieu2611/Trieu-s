#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "udp.h"
#include "MarkerModel.h"
#include "liveimageprovider.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //QQmlContext * rootContext = engine.rootContext();

    UDP client;
    engine.rootContext()->setContextProperty("dataudp",&client);

    qmlRegisterType<MarkerModel>("XT.MarkerModel",1,0,"MarkerModel");

    LiveImageProvider *liveImageProvider(new LiveImageProvider());
    engine.rootContext()->setContextProperty("liveImageProvider", liveImageProvider);
    engine.addImageProvider("live", liveImageProvider);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    const QUrl url1(QStringLiteral("qrc:/GroundStationMap.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url1](QObject *obj, const QUrl &objUrl) {
            if (!obj && url1 == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);
    engine.load(url1);

    return app.exec();
}
