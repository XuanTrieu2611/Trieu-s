#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "MakerModel.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
//    QQmlContext * rootContext = engine.rootContext();
//    MarkerModel model;
//    rootContext->setContextProperty("markerModel", &model);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    qmlRegisterType<MarkerModel>("XT.MarkerModel",1,0,"MarkerModel");
    engine.load(url);

    return app.exec();
}
